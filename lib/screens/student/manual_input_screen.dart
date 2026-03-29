import 'package:flutter/material.dart';
import 'package:poleangels_planner/theme/app_theme.dart';

const _weekdays = [
  ('monday', 'Esmaspäev'),
  ('tuesday', 'Teisipäev'),
  ('wednesday', 'Kolmapäev'),
  ('thursday', 'Neljapäev'),
  ('friday', 'Reede'),
  ('saturday', 'Laupäev'),
  ('sunday', 'Pühapäev'),
];

const _timeSlots = [
  ('morning', 'Hommik (6:00–12:00)'),
  ('afternoon', 'Pärastlõuna (12:00–17:00)'),
  ('evening', 'Õhtu (17:00–21:00)'),
];

const _levels = [
  ('beginner', 'Algaja'),
  ('intermediate', 'Keskmine'),
  ('advanced', 'Edasijõudnud'),
];

class ManualInputScreen extends StatefulWidget {
  const ManualInputScreen({super.key});

  @override
  State<ManualInputScreen> createState() => _ManualInputScreenState();
}

class _ManualInputScreenState extends State<ManualInputScreen> {
  final Set<String> _selectedDays = {};
  final Set<String> _selectedTimes = {};
  String _selectedLevel = '';

  bool get _canSubmit =>
      _selectedDays.isNotEmpty && _selectedTimes.isNotEmpty && _selectedLevel.isNotEmpty;

  void _toggle(Set<String> set, String id) {
    setState(() {
      if (set.contains(id)) {
        set.remove(id);
      } else {
        set.add(id);
      }
    });
  }

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
              'Käsitsi sisestamine',
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
                _SectionTitle('Vali päevad'),
                const SizedBox(height: 16),
                ..._weekdays.map((d) => _SelectionTile(
                      label: d.$2,
                      selected: _selectedDays.contains(d.$1),
                      onTap: () => _toggle(_selectedDays, d.$1),
                    )),
                const SizedBox(height: 32),
                _SectionTitle('Vali ajad'),
                const SizedBox(height: 16),
                ..._timeSlots.map((t) => _SelectionTile(
                      label: t.$2,
                      selected: _selectedTimes.contains(t.$1),
                      onTap: () => _toggle(_selectedTimes, t.$1),
                    )),
                const SizedBox(height: 32),
                _SectionTitle('Sinu tase'),
                const SizedBox(height: 16),
                ..._levels.map((l) => _SelectionTile(
                      label: l.$2,
                      selected: _selectedLevel == l.$1,
                      onTap: () => setState(() => _selectedLevel = l.$1),
                    )),
              ],
            ),
          ),
          // Fixed bottom button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppTheme.surface,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _canSubmit
                      ? () => Navigator.pushNamed(context, '/confirmation')
                      : null,
                  icon: const Icon(Icons.check),
                  label: const Text(
                    'Saada',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppTheme.primary.withAlpha(102),
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppTheme.textPrimary,
      ),
    );
  }
}

class _SelectionTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SelectionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: selected ? AppTheme.primary : AppTheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppTheme.primary : AppTheme.primary.withAlpha(64),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: selected ? Colors.white : AppTheme.textPrimary,
                ),
              ),
              if (selected)
                const Icon(Icons.check, size: 20, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
