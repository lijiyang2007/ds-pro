// 本地备份与恢复: the on-device engine's conversations as one file, and the way
// back. Reads and writes the engine's own session directory
// (`<DSH_HOME>/sessions`, the JSONL backend's root), so a backup is those files
// as they are — not a re-encoding — and a restore is those files put back
// where the engine scans for them.

import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../l10n/l10n.dart';
import '../../runtime/local_footprint.dart' show RuntimeMissing;
import '../../runtime/runtime_bridge.dart' show RuntimePhase;
import '../../runtime/runtime_state.dart';
import '../../share_code/guest_fs.dart';
import '../../state/artifacts.dart' show filesChannelProvider, saveWindowDismissed, savedInChosenPlace;
import '../../state/local_backup.dart';
import '../../state/sessions_state.dart';
import '../../state/app_info.dart';
import '../shell/page_frame.dart';
import '../settings/settings_widgets.dart';
import '../theme/app_icons.dart';
import '../theme/theme.dart';

/// 本地备份与恢复.
class LocalBackupPage extends ConsumerStatefulWidget {
  const LocalBackupPage({super.key});

  @override
  ConsumerState<LocalBackupPage> createState() => _LocalBackupPageState();
}

class _LocalBackupPageState extends ConsumerState<LocalBackupPage> {
  bool _busy = false;
  String? _message;
  bool _failed = false;

  /// What is on disk right now, read when the page opens and after a restore.
  LocalSessionFiles? _files;
  int _sessions = 0;
  int _bytes = 0;

  @override
  void initState() {
    super.initState();
    unawaited(_scan());
  }

  Future<void> _scan() async {
    final fs = await ref.read(guestFsProvider.future);
    if (!mounted) return;
    if (fs == null) {
      setState(() {
        _files = null;
        _sessions = 0;
        _bytes = 0;
      });
      return;
    }
    final files = LocalSessionFiles(fs);
    final sessions = files.scan();
    final bytes = files.footprint();
    if (!mounted) return;
    setState(() {
      _files = files;
      _sessions = sessions.length;
      _bytes = bytes;
    });
  }

  Future<void> _run(Future<String?> Function(LocalSessionFiles files) action) async {
    final files = _files;
    if (_busy || files == null) return;
    setState(() {
      _busy = true;
      _message = null;
      _failed = false;
    });
    try {
      final message = await action(files);
      if (mounted) setState(() => _message = message);
    } on BackupException catch (error) {
      if (mounted) {
        setState(() {
          _message = _problemText(context.l10n, error);
          _failed = true;
        });
      }
    } on FileSystemException {
      if (mounted) {
        setState(() {
          _message = context.l10n.localBackupStorageFailed;
          _failed = true;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _message = context.l10n.backupUnknownFailure;
          _failed = true;
        });
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Writes the archive beside the app's cache and hands it to the system's
  /// save: the person picks where it lands.
  Future<String?> _export(LocalSessionFiles files) async {
    final l10n = context.l10n;
    final titles = await _sessionTitles();
    final archive = await buildLocalBackup(files, app: AppInfo.version, titles: titles);
    final stamp = _stamp(archive.backup.createdAt);
    final dir = Directory('${(await getTemporaryDirectory()).path}/local-backup')..createSync(recursive: true);
    final file = File('${dir.path}/ds-pro-backup-$stamp.zip');
    await file.writeAsBytes(archive.bytes, flush: true);
    try {
      final saved = await ref
          .read(filesChannelProvider)
          .saveToDownloads(file.path, name: 'ds-pro-backup-$stamp.zip', mime: 'application/zip');
      return savedInChosenPlace(saved) ? l10n.localBackupSavedChosen : l10n.localBackupSaved(saved);
    } on Exception catch (error) {
      if (saveWindowDismissed(error)) return null;
      rethrow;
    } finally {
      try {
        await file.delete();
      } on FileSystemException {
        // A leftover in the cache is cleared by the system.
      }
    }
  }

  Future<Map<String, String>> _sessionTitles() async {
    try {
      final sessions = await ref.read(sessionsProvider.future);
      return {
        for (final s in sessions)
          if (s.projections.title case final title? when title.trim().isNotEmpty) s.sessionId: title.trim(),
      };
    } catch (_) {
      return const {};
    }
  }

  Future<String?> _import(LocalSessionFiles files) async {
    final l10n = context.l10n;
    final picked = await FilePicker.pickFile(type: FileType.custom, allowedExtensions: const ['zip']);
    if (picked == null) return null;
    final bytes = await picked.readAsBytes();
    final archive = readLocalBackup(bytes);
    final total = archive.backup.sessionCount;
    if (!mounted) return null;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.backupRestoreTitle),
        content: Text(l10n.backupRestoreBody(total, _stamp(archive.backup.createdAt))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonCancel)),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.backupRestoreAction)),
        ],
      ),
    );
    if (confirmed != true) return null;
    final written = await restoreLocalBackup(files, archive);
    await _restartIfRunning();
    if (!mounted) return null;
    unawaited(_scan());
    return l10n.localBackupRestored(written);
  }

  /// The engine holds its session list in memory: a restore shows up after a
  /// restart, and the page offers one rather than doing it behind the person.
  Future<void> _restartIfRunning() async {
    final status = ref.read(localRuntimeProvider).status;
    if (status.phase != RuntimePhase.running) return;
    try {
      await ref.read(localRuntimeProvider.notifier).stop();
      await ref.read(localRuntimeProvider.notifier).start();
    } catch (_) {
      // Left to the person: 本机引擎 has the same two switches.
    }
  }

  static String _stamp(DateTime at) {
    final local = at.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${local.year}${two(local.month)}${two(local.day)}-${two(local.hour)}${two(local.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final dsh = DshColors.of(context);
    final missing = ref.watch(localRuntimeProvider.select((s) => s.status.runtimeMissing));
    final ready = _files != null && !missing;
    final footnote = theme.textTheme.bodySmall?.copyWith(color: dsh.textTertiary, height: 1.55);

    return AppPage.list(
      title: l10n.localBackupTitle,
      subtitle: Text(l10n.backupIntro),
      children: [
        SettingsSection(
          title: l10n.backupOnThisPhone,
          footer: Text(l10n.backupWhere),
          children: [
            InfoRow(label: l10n.backupSessionCount, value: _sessions.toString()),
            InfoRow(label: l10n.backupSize, value: _size(_bytes)),
          ],
        ),
        SettingsSection(
          title: l10n.backupExport,
          children: [
            SettingsTile(
              icon: AppIcons.download,
              tinted: false,
              title: l10n.backupExportAction,
              subtitle: l10n.backupExportHint,
              onTap: ready && !_busy && _sessions > 0 ? () => _run(_export) : null,
            ),
            SettingsTile(
              icon: AppIcons.uploadToHost,
              tinted: false,
              title: l10n.backupRestoreActionTitle,
              subtitle: l10n.backupRestoreHint,
              onTap: ready && !_busy ? () => _run(_import) : null,
            ),
          ],
        ),
        if (_busy)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (_message case final message? when !_busy)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: _failed ? dsh.danger : colors.onSurfaceVariant,
                height: 1.55,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: Text(l10n.backupNotes, style: footnote),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  static String _size(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  static String _problemText(L10n l10n, BackupException error) => switch (error.problem) {
    BackupProblem.noSessions => l10n.backupNoSessions,
    BackupProblem.noEngine => l10n.backupNoEngine,
    BackupProblem.tooLarge => l10n.backupTooLarge,
    BackupProblem.notABackup => l10n.backupNotBackup,
    BackupProblem.newerBackup => l10n.backupNewer,
    BackupProblem.unsafePath => l10n.backupUnsafe,
    BackupProblem.storage => l10n.localBackupStorageFailed,
  };
}
