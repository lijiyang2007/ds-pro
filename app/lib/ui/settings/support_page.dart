// The app's own support pages: 打赏 and 致谢 (设置 › 帮助与关于),
// 定制你自己的宠物 (设置 › 主题 › 宠物) and 想用更便宜的 API (设置 › 模型).
// One page shape: a line or two of introduction, the explanation, then the
// author's QQ to add, which a tap copies.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../state/app_info.dart';
import '../../state/star_prompt.dart' show starLinkOpenerProvider;
import '../common/brief_notice.dart';
import '../shell/page_frame.dart';
import '../theme/app_icons.dart';
import '../theme/theme.dart';
import 'settings_widgets.dart';

/// 打赏: thanks, and where to send it.
class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SupportPage(
      title: l10n.supportDonate,
      intro: l10n.supportDonateIntro,
      body: l10n.supportDonateBody,
    );
  }
}

/// 定制你自己的宠物: what to describe, and who makes it.
class PetCustomPage extends StatelessWidget {
  const PetCustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SupportPage(
      title: l10n.supportPetCustomTitle,
      intro: l10n.supportPetCustomIntro,
      body: l10n.supportPetCustomBody,
    );
  }
}

/// 想用更便宜的 API: the custom provider card, and who to ask about it.
class CheapApiPage extends StatelessWidget {
  const CheapApiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SupportPage(
      title: l10n.supportCheapApiTitle,
      intro: l10n.supportCheapApiIntro,
      body: l10n.supportCheapApiBody,
    );
  }
}

/// 致谢: where this app's code comes from.
class ThanksPage extends ConsumerWidget {
  const ThanksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = DshColors.of(context);
    final body = theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant, height: 1.65);
    Future<void> open() async {
      final messenger = ScaffoldMessenger.maybeOf(context);
      var opened = false;
      try {
        opened = await ref.read(starLinkOpenerProvider)(Uri.parse(AppInfo.upstreamUrl));
      } catch (_) {
        opened = false;
      }
      if (!opened && messenger != null) {
        await Clipboard.setData(ClipboardData(text: AppInfo.upstreamUrl));
        if (context.mounted) showBriefNotice(context, l10n.supportOpenLinkFailed);
      }
    }

    return AppPage.list(
      title: l10n.supportThanks,
      subtitle: Text(l10n.supportThanksIntro),
      children: [
        SettingsSection(
          children: [
            for (final text in [l10n.supportThanksBody, l10n.supportThanksBody2, l10n.supportThanksBody3])
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Text(text, style: body),
              ),
          ],
        ),
        SettingsSection(
          children: [
            SettingsTile(
              icon: AppIcons.openExternal,
              tinted: false,
              title: l10n.supportThanksSourceTitle,
              subtitle: l10n.supportThanksSourceValue,
              onTap: open,
            ),
            SettingsTile(
              icon: AppIcons.document,
              tinted: false,
              title: l10n.supportThanksLicenseTitle,
              value: Text(
                l10n.supportThanksLicenseValue,
                style: AppType.tabular(theme.textTheme.bodyMedium!.copyWith(color: colors.textTertiary)),
              ),
              chevron: false,
            ),
          ],
        ),
      ],
    );
  }
}

/// The one page the three support pages open: [intro] under the title,
/// [body] in a card, then the author's QQ.
class SupportPage extends StatelessWidget {
  const SupportPage({super.key, required this.title, required this.intro, required this.body});

  final String title;
  final String intro;
  final String body;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colors = DshColors.of(context);
    Future<void> copy() async {
      await Clipboard.setData(const ClipboardData(text: AppInfo.contactQq));
      if (context.mounted) showBriefNotice(context, l10n.supportContactCopied);
    }

    return AppPage.list(
      title: title,
      subtitle: Text(intro),
      children: [
        SettingsSection(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Text(
                body,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.65,
                ),
              ),
            ),
          ],
        ),
        SettingsSection(
          children: [
            SettingsTile(
              icon: AppIcons.qq,
              tinted: false,
              title: l10n.supportContactQq,
              subtitle: l10n.supportContactHint,
              value: Text(
                AppInfo.contactQq,
                style: AppType.tabular(theme.textTheme.bodyMedium!.copyWith(color: colors.textTertiary)),
              ),
              onTap: copy,
            ),
          ],
        ),
      ],
    );
  }
}
