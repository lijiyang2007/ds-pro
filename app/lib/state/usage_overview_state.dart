// 全局用量与花费: every conversation on this host, added up. The numbers are
// the engine's own `tokenUsage` projections, read for each listed conversation
// and summed; nothing is measured or estimated on the app's side except the
// money, which uses [modelPrices] and says so.

import 'dart:async';

import 'package:dsh_client/dsh_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'connection_state.dart';
import 'sessions_state.dart';
import 'usage_state.dart';

/// What one conversation used.
class SessionSpend {
  const SessionSpend({
    required this.sessionId,
    required this.title,
    required this.updatedAt,
    required this.usage,
    this.route,
    this.cost,
  });

  final String sessionId;

  /// Empty when the conversation has no title yet (the page says 未命名).
  final String title;
  final DateTime updatedAt;
  final SessionUsage usage;

  /// The route the conversation last used (`provider/model`), when the list
  /// said: the row the price came from.
  final String? route;

  /// Money, when [modelPrices] knows [route].
  final double? cost;
}

/// Every conversation's use of the model, with the totals.
class UsageOverview {
  const UsageOverview({this.rows = const [], this.unpriced = 0, this.failed = 0});

  /// Newest first; conversations with no tokens are left out.
  final List<SessionSpend> rows;

  /// Conversations whose tokens had no price row: they count in the tokens
  /// and not in the money, and the page says how many.
  final int unpriced;

  /// Conversations the host refused or that vanished meanwhile.
  final int failed;

  static const empty = UsageOverview();

  int get input => rows.fold(0, (sum, row) => sum + row.usage.input);
  int get uncachedInput => rows.fold(0, (sum, row) => sum + row.usage.uncachedInput);
  int get cacheRead => rows.fold(0, (sum, row) => sum + row.usage.cacheRead);
  int get cacheWrite => rows.fold(0, (sum, row) => sum + row.usage.cacheWrite);
  int get output => rows.fold(0, (sum, row) => sum + row.usage.output);
  int get billed => input + output;

  /// Share of the input served from the cache; null before the first request.
  double? get cacheHitRate => input == 0 ? null : cacheRead / input;

  /// Total money over the priced rows; null when no row is priced.
  double? get cost {
    final priced = [for (final row in rows) ?row.cost];
    return priced.isEmpty ? null : priced.fold<double>(0, (sum, value) => sum + value);
  }
}

/// 全局用量与花费: reads every listed conversation's `tokenUsage` and sums it.
class UsageOverviewController extends AsyncNotifier<UsageOverview> {
  /// How many conversations are read at once.
  static const concurrency = 4;

  /// Conversations read at most, newest first: a very old tail adds little and
  /// one page should not stall on a thousand calls.
  static const cap = 200;

  @override
  Future<UsageOverview> build() => _read();

  Future<void> refresh() async {
    state = const AsyncValue<UsageOverview>.loading();
    state = await AsyncValue.guard(_read);
  }

  Future<UsageOverview> _read() async {
    final conn = ref.read(activeConnectionProvider).value;
    final sessions = ref.read(sessionsProvider).value ?? const <SessionSummary>[];
    if (conn == null) return UsageOverview.empty;
    final client = conn.client;
    final listed = [
      for (final s in sessions)
        if (!s.blank && !s.isSubagent) s,
    ]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    final chosen = listed.length > cap ? listed.sublist(0, cap) : listed;

    final rows = <SessionSpend>[];
    var unpriced = 0;
    var failed = 0;
    for (var start = 0; start < chosen.length; start += concurrency) {
      final read = await Future.wait([
        for (final summary in chosen.skip(start).take(concurrency)) _one(client, summary),
      ]);
      for (final result in read) {
        if (result == null) {
          failed++;
          continue;
        }
        if (result.usage.input == 0 && result.usage.output == 0) continue;
        if (result.cost == null) unpriced++;
        rows.add(result);
      }
    }
    return UsageOverview(rows: rows, unpriced: unpriced, failed: failed);
  }

  Future<SessionSpend?> _one(DshClient client, SessionSummary summary) async {
    try {
      final projections = await client.projections(summary.sessionId);
      if (projections == null) return null;
      final usage = SessionUsage.fromProjections(projections.values);
      final model = summary.projections.nextModel ?? summary.projections.lastUsedModel;
      final route = model == null ? null : '${model.provider}/${model.model}';
      final price = route == null ? null : modelPrices[route];
      final title = summary.projections.title?.trim() ?? '';
      return SessionSpend(
        sessionId: summary.sessionId,
        title: title,
        updatedAt: summary.updatedAt,
        usage: usage,
        route: route,
        cost: price == null ? null : estimateCost(usage, price),
      );
    } catch (_) {
      return null;
    }
  }
}

final usageOverviewProvider = AsyncNotifierProvider<UsageOverviewController, UsageOverview>(
  UsageOverviewController.new,
);

/// Prices per million tokens, by `provider/model`, in yuan: DeepSeek's
/// published list price for its two chat routes. A route that is not here
/// shows its tokens and no money, rather than a guess.
const Map<String, TokenPricing> modelPrices = {
  'deepseek/deepseek-chat': TokenPricing(
    currency: 'CNY',
    inputPerMillion: 2,
    cacheHitPerMillion: 0.5,
    outputPerMillion: 8,
  ),
  'deepseek/deepseek-reasoner': TokenPricing(
    currency: 'CNY',
    inputPerMillion: 2,
    cacheHitPerMillion: 0.5,
    outputPerMillion: 8,
  ),
};

/// `¥12.35`; anything above zero but under a fen reads as `<¥0.01`.
String formatYuan(double yuan) {
  if (yuan > 0 && yuan < 0.01) return '<¥0.01';
  return '¥${yuan.toStringAsFixed(2)}';
}
