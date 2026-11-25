// 全局用量与花费: every conversation on this host, added up, and the money
// those tokens cost at DeepSeek's published prices. The page says it is an
// estimate: prices change, and a route the table does not know shows tokens and
// no money.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../../state/usage_overview_state.dart';
import '../chat/usage_sheet.dart' show UsageFigure, formatPercent, formatTokens;
import '../common/list_page_row.dart';
import '../shell/page_frame.dart';
import '../theme/app_icons.dart';
import '../theme/theme.dart';

class GlobalUsagePage extends ConsumerWidget {
  const GlobalUsagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final dsh = DshColors.of(context);
    final async = ref.watch(usageOverviewProvider);
    final overview = async.value ?? UsageOverview.empty;
    return AppPage(
      title: l10n.supportUsageTitle,
      subtitle: Text(l10n.supportUsageIntro),
      actions: [
        GlassIconButton(
          icon: AppIcons.refresh,
          tooltip: l10n.commonRetry,
          onPressed: async.isLoading ? null : () => ref.read(usageOverviewProvider.notifier).refresh(),
        ),
      ],
      slivers: [
        SliverList.list(
          children: [
            if (async.isLoading && overview.rows.isEmpty)
              const Padding(padding: EdgeInsets.symmetric(vertical: 60), child: Center(child: CircularProgressIndicator())),
            if (async.hasError && overview.rows.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                child: Text(
                  l10n.supportUsageFailed,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(color: dsh.danger),
                ),
              ),
            if (overview.rows.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _Figure(
                        label: l10n.supportUsageInput,
                        value: formatTokens(overview.input),
                        note: l10n.supportUsageCacheRate(
                          overview.cacheHitRate == null ? '—' : formatPercent(overview.cacheHitRate!),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _Figure(label: l10n.supportUsageOutput, value: formatTokens(overview.output)),
                    ),
                    Expanded(
                      child: _Figure(
                        label: l10n.supportUsageCost,
                        value: overview.cost == null ? '—' : formatYuan(overview.cost!),
                        strong: true,
                      ),
                    ),
                  ],
                ),
              ),
              ListPageCard(
                title: l10n.supportUsageByChat,
                children: [
                  for (final row in overview.rows)
                    ListPageRow(
                      icon: AppIcons.chat,
                      title: row.title.trim().isEmpty ? l10n.commonUntitledChat : row.title,
                      subtitle: [
                        formatTokens(row.usage.input + row.usage.output),
                        if (row.cost case final cost?) formatYuan(cost),
                      ].join(' · '),
                      meta: _day(row.updatedAt),
                      chevron: false,
                    ),
                ],
              ),
              if (overview.unpriced > 0)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                  child: Text(
                    l10n.supportUsageUnpriced(overview.unpriced),
                    style: theme.textTheme.bodySmall?.copyWith(color: dsh.textTertiary, height: 1.5),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                child: Text(
                  l10n.supportUsagePriceNote,
                  style: theme.textTheme.bodySmall?.copyWith(color: dsh.textTertiary, height: 1.5),
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ],
    );
  }

  static String _day(DateTime at) {
    final local = at.toLocal();
    return '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.label, required this.value, this.note, this.strong = false});

  final String label;
  final String value;
  final String? note;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final dsh = DshColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UsageFigure(
          value,
          style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500, height: 1.25),
          color: strong ? colors.primary : null,
        ),
        const SizedBox(height: 2),
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
        if (note case final note?)
          Text(note, style: theme.textTheme.bodySmall?.copyWith(color: dsh.textTertiary)),
      ],
    );
  }
}
