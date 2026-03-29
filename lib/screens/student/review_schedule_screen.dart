import 'package:flutter/material.dart';
import 'package:poleangels_planner/models/schedule_item.dart';
import 'package:poleangels_planner/theme/app_theme.dart';
import 'package:poleangels_planner/widgets/schedule_card.dart';

class ReviewScheduleScreen extends StatelessWidget {
  final List<ScheduleItem> schedule;

  const ReviewScheduleScreen({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 1,
        shadowColor: const Color(0x1A000000),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28, color: AppTheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          children: [
            Icon(Icons.calendar_today_outlined, size: 20, color: AppTheme.primary),
            SizedBox(width: 8),
            Text(
              'Sinu graafik',
              style: TextStyle(fontSize: 18, color: AppTheme.textPrimary),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vaata üle',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Lõime sulle ajakava sinu eelistuste põhjal',
                  style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 24),
                ...schedule.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ScheduleCard(item: item),
                    )),
                // Summary card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.primary.withAlpha(32)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nädalane kokkuvõte',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _SummaryRow(label: 'Tunde kokku:', value: '${schedule.length} nädalas'),
                      const SizedBox(height: 12),
                      _SummaryRow(
                        label: 'Kestus:',
                        value: '${schedule.length * 60} minutit',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Fixed bottom actions
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppTheme.surface,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primary,
                          side: const BorderSide(color: AppTheme.primary, width: 2),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Muuda',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/confirmation'),
                        icon: const Icon(Icons.check, size: 20),
                        label: const Text(
                          'Kinnita',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary)),
      ],
    );
  }
}
