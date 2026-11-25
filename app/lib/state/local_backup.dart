// 本地备份与恢复: a ZIP of the on-device engine's own session files, and the
// way back. Nothing here invents a format: the archive holds the files the
// engine wrote (`<DSH_HOME>/sessions/<project>/<id>/session*.jsonl*`) exactly
// as they are, plus a small manifest the restore reads first.
//
// The engine has no import route, so a conversation comes back by putting its
// files where the engine keeps them and letting it scan again — that is why a
// restore offers to restart the engine when it is running.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import '../share_code/guest_fs.dart';

/// The archive's manifest name, at its root.
const localBackupManifest = 'dsh-backup.json';

/// The manifest's version: what this build can read back.
const localBackupVersion = 1;

/// One conversation in the manifest.
class BackupSession {
  const BackupSession({required this.id, required this.project, required this.files, this.title});

  final String id;

  /// The engine's project directory name (`--root-workspace--`).
  final String project;

  /// Paths inside the session's own directory, as the engine names them.
  final List<String> files;

  /// The title the list knew when the backup was made (only shown).
  final String? title;

  Map<String, Object?> toJson() => {
    'id': id,
    'project': project,
    'files': files,
    if (title != null) 'title': title,
  };

  static BackupSession? fromJson(Object? raw) {
    if (raw is! Map) return null;
    final id = raw['id'];
    final project = raw['project'];
    final files = raw['files'];
    if (id is! String || project is! String || files is! List) return null;
    if (!_safeSegment(id) || !_safeSegment(project)) return null;
    return BackupSession(
      id: id,
      project: project,
      files: [for (final f in files) if (f is String && _safeSegment(f)) f],
      title: raw['title'] is String ? raw['title'] as String : null,
    );
  }
}

/// What a backup holds.
class LocalBackup {
  const LocalBackup({required this.createdAt, required this.app, required this.sessions});

  final DateTime createdAt;
  final String app;
  final List<BackupSession> sessions;

  int get sessionCount => sessions.length;

  Map<String, Object?> toJson() => {
    'v': localBackupVersion,
    'created': createdAt.toUtc().toIso8601String(),
    'app': app,
    'sessions': [for (final s in sessions) s.toJson()],
  };
}

/// A name the engine could have written: no separators, no `..`, not empty.
/// The archive's paths come from a file a person picked, so every one of them
/// is checked before it reaches the filesystem.
bool _safeSegment(String name) =>
    name.isNotEmpty &&
    name.length <= 200 &&
    !name.startsWith('.') &&
    !name.contains('/') &&
    !name.contains('\\') &&
    !name.contains(':') &&
    !name.contains('\u0000') &&
    name != '.' &&
    name != '..';

/// The engine's whole sessions directory.
class LocalSessionFiles {
  const LocalSessionFiles(this.fs);

  final GuestFs fs;

  /// `<DSH_HOME>/sessions`, the JSONL backend's root.
  Directory get root => fs.dir('${GuestFs.dshHome}/sessions');

  /// Whether the engine has written any session yet.
  bool get exists => root.existsSync();

  /// Every conversation on disk: its project directory and the session files
  /// inside it.
  List<BackupSession> scan() {
    if (!exists) return const [];
    final out = <BackupSession>[];
    for (final project in _dirs(root)) {
      final projectName = _base(project);
      if (!_safeSegment(projectName)) continue;
      for (final session in _dirs(project)) {
        final id = _base(session);
        if (!_safeSegment(id)) continue;
        final files = [
          for (final entry in session.listSync(followLinks: false))
            if (entry is File && _isSessionFile(_base(entry))) _base(entry),
        ];
        if (files.isEmpty) continue;
        out.add(BackupSession(id: id, project: projectName, files: files));
      }
    }
    return out;
  }

  /// Bytes on disk of every session file.
  int footprint() {
    var total = 0;
    for (final session in scan()) {
      for (final name in session.files) {
        try {
          total += File('${root.path}/${session.project}/${session.id}/$name').lengthSync();
        } on FileSystemException {
          // A file that went away meanwhile counts as nothing.
        }
      }
    }
    return total;
  }

  /// The session-directory names the engine itself writes.
  static bool _isSessionFile(String name) =>
      RegExp(r'^session(\.v[1-9][0-9]*)?\.jsonl(\.zstd)?$').hasMatch(name) || name.endsWith('.lock');

  static Iterable<Directory> _dirs(Directory parent) sync* {
    final List<FileSystemEntity> entries;
    try {
      entries = parent.listSync(followLinks: false);
    } on FileSystemException {
      return;
    }
    for (final entry in entries) {
      if (entry is Directory && !_base(entry).startsWith('.')) yield entry;
    }
  }

  static String _base(FileSystemEntity entity) {
    final parts = entity.uri.pathSegments.where((s) => s.isNotEmpty).toList();
    return parts.isEmpty ? '' : parts.last;
  }
}

/// How much a backup may hold, so one export cannot exhaust the phone: the
/// whole archive, and one file inside it.
const localBackupMaxBytes = 512 * 1024 * 1024;
const localBackupMaxFileBytes = 64 * 1024 * 1024;

/// One archive as written and read.
class LocalBackupArchive {
  const LocalBackupArchive(this.bytes, this.backup);

  final Uint8List bytes;
  final LocalBackup backup;
}

/// Why a backup or a restore stopped.
enum BackupProblem {
  /// The engine has not written a session on this phone yet.
  noSessions,

  /// There is no runtime installed, so there is nowhere to read or write.
  noEngine,

  /// Too much to hold in one archive, or one file too large.
  tooLarge,

  /// The picked file is not a ZIP this app wrote.
  notABackup,

  /// Its manifest is from a newer build.
  newerBackup,

  /// A file inside it would land outside the sessions directory.
  unsafePath,

  /// The disk refused the write.
  storage,
}

class BackupException implements Exception {
  const BackupException(this.problem, [this.detail]);

  final BackupProblem problem;
  final String? detail;
}

/// Builds a backup of every conversation on this phone.
Future<LocalBackupArchive> buildLocalBackup(
  LocalSessionFiles files, {
  required String app,
  DateTime? now,
  Map<String, String> titles = const {},
  void Function(int done, int total)? onProgress,
}) async {
  if (!files.exists) throw const BackupException(BackupProblem.noSessions);
  final scanned = files.scan();
  if (scanned.isEmpty) throw const BackupException(BackupProblem.noSessions);
  final sessions = [
    for (final session in scanned)
      BackupSession(
        id: session.id,
        project: session.project,
        files: session.files,
        title: titles[session.id],
      ),
  ];
  final archive = Archive();
  var total = 0;
  var done = 0;
  for (final session in sessions) {
    for (final name in session.files) {
      final file = File('${files.root.path}/${session.project}/${session.id}/$name');
      final length = await file.length();
      if (length > localBackupMaxFileBytes) throw const BackupException(BackupProblem.tooLarge);
      total += length;
      if (total > localBackupMaxBytes) throw const BackupException(BackupProblem.tooLarge);
      final bytes = await file.readAsBytes();
      final entry = ArchiveFile.bytes('sessions/${session.project}/${session.id}/$name', bytes)
        ..lastModTime = file.lastModifiedSync().millisecondsSinceEpoch ~/ 1000;
      archive.add(entry);
      done++;
      onProgress?.call(done, done);
    }
  }
  final backup = LocalBackup(createdAt: now ?? DateTime.now(), app: app, sessions: sessions);
  archive.add(ArchiveFile.bytes(localBackupManifest, utf8.encode(jsonEncode(backup.toJson()))));
  final encoded = ZipEncoder().encodeBytes(archive);
  return LocalBackupArchive(encoded, backup);
}

/// Reads a picked file: its manifest first, then every entry's place checked
/// against [LocalSessionFiles.root].
LocalBackupArchive readLocalBackup(Uint8List bytes) {
  final Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(bytes, verify: true);
  } catch (_) {
    throw const BackupException(BackupProblem.notABackup);
  }
  Map<String, Object?>? manifest;
  final entries = <String, List<int>>{};
  for (final entry in archive) {
    if (!entry.isFile) continue;
    final name = entry.name;
    final content = entry.readBytes();
    if (content == null) throw const BackupException(BackupProblem.notABackup);
    if (name == localBackupManifest) {
      try {
        final decoded = jsonDecode(utf8.decode(content));
        if (decoded is Map<String, Object?>) manifest = decoded;
      } catch (_) {
        throw const BackupException(BackupProblem.notABackup);
      }
      continue;
    }
    if (!name.startsWith('sessions/')) continue;
    entries[name] = content;
  }
  final raw = manifest;
  if (raw == null) throw const BackupException(BackupProblem.notABackup);
  final version = raw['v'];
  if (version is! int || version < 1) throw const BackupException(BackupProblem.notABackup);
  if (version > localBackupVersion) throw const BackupException(BackupProblem.newerBackup);
  final sessions = <BackupSession>[];
  for (final item in raw['sessions'] is List ? raw['sessions'] as List : const <Object?>[]) {
    final session = BackupSession.fromJson(item);
    if (session == null) throw const BackupException(BackupProblem.unsafePath);
    // Every file the manifest promises must be in the archive, under this
    // session's own directory.
    for (final name in session.files) {
      if (!entries.containsKey('sessions/${session.project}/${session.id}/$name')) {
        throw const BackupException(BackupProblem.notABackup);
      }
    }
    sessions.add(session);
  }
  final created = raw['created'] is String ? DateTime.tryParse(raw['created'] as String) : null;
  return LocalBackupArchive(
    bytes,
    LocalBackup(
      createdAt: created ?? DateTime.now(),
      app: raw['app'] is String ? raw['app'] as String : '',
      sessions: sessions,
    ),
  );
}

/// Writes a backup back into the engine's sessions directory. Every file goes
/// to a `.part` beside its target and is renamed into place, so a full disk
/// leaves the conversation that was there before. Returns how many sessions
/// were written.
Future<int> restoreLocalBackup(LocalSessionFiles files, LocalBackupArchive archive) async {
  final sessions = archive.backup.sessions;
  if (sessions.isEmpty) throw const BackupException(BackupProblem.notABackup);
  final zip = ZipDecoder().decodeBytes(archive.bytes, verify: true);
  final byName = {
    for (final entry in zip)
      if (entry.isFile) entry.name: entry,
  };
  final root = files.root;
  try {
    root.createSync(recursive: true);
  } on FileSystemException {
    throw const BackupException(BackupProblem.storage);
  }
  var written = 0;
  for (final session in sessions) {
    final directory = Directory('${root.path}/${session.project}/${session.id}');
    final staging = Directory('${root.path}/${session.project}/${session.id}.part-${DateTime.now().microsecondsSinceEpoch}');
    try {
      staging.createSync(recursive: true);
      for (final name in session.files) {
        final entry = byName['sessions/${session.project}/${session.id}/$name'];
        final content = entry?.readBytes();
        if (content == null) throw const BackupException(BackupProblem.notABackup);
        File('${staging.path}/$name').writeAsBytesSync(content, flush: true);
      }
      // The old directory (if any) goes only once the new one is complete.
      if (directory.existsSync()) directory.deleteSync(recursive: true);
      staging.renameSync(directory.path);
      written++;
    } on FileSystemException catch (error) {
      try {
        if (staging.existsSync()) staging.deleteSync(recursive: true);
      } on FileSystemException {
        // A leftover `.part-` directory is ignored by the engine's scan.
      }
      throw BackupException(BackupProblem.storage, error.message);
    }
  }
  return written;
}
