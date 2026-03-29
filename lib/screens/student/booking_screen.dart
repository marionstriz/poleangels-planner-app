import 'package:flutter/material.dart';
import 'package:poleangels_planner/theme/app_theme.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isProcessing = false;
  bool _isRecording = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    Navigator.pushNamed(context, '/confirmation');
    setState(() => _isProcessing = false);
  }

  void _handleMicToggle() {
    setState(() => _isRecording = !_isRecording);
    if (_isRecording) {
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        setState(() {
          _controller.text += ' Teisipäeviti ja neljapäeviti õhtuti';
          _isRecording = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _controller.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const SizedBox(height: 48),
              const Text(
                'Pole Angels · Aprilli graafik',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Millal oled vaba?',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                  height: 1.2,
                ),
              ),

              // Text input area
              const SizedBox(height: 40),
              Expanded(
                child: Stack(
                  children: [
                    TextField(
                      controller: _controller,
                      maxLines: null,
                      expands: true,
                      enabled: !_isProcessing && !_isRecording,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppTheme.textPrimary,
                        height: 1.6,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            'Näiteks: Teisipäeviti ja neljapäeviti õhtuti pärast kella 18, laupäeviti hommikul...',
                        hintStyle: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 16,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(24, 24, 64, 24),
                        filled: true,
                        fillColor: AppTheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: AppTheme.primary.withAlpha(128)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: AppTheme.primary.withAlpha(128), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: AppTheme.primary, width: 2),
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    // Mic button
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: _isProcessing ? null : _handleMicToggle,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _isRecording
                                ? AppTheme.primary
                                : AppTheme.primary.withAlpha(32),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.mic,
                            size: 20,
                            color: _isRecording ? Colors.white : AppTheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Hint text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isRecording ? 'Kuulan...' : 'Kirjelda oma ajakava vabalt',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.primary.withAlpha(153),
                      ),
                    ),
                    if (_controller.text.isNotEmpty)
                      Text(
                        '${_controller.text.length} märki',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.textPrimary.withAlpha(102),
                        ),
                      ),
                  ],
                ),
              ),

              // Bottom buttons
              _PrimaryButton(
                label: _isProcessing ? 'Saadan...' : 'Saada',
                icon: _isProcessing ? null : Icons.arrow_forward,
                onPressed: hasText && !_isProcessing ? _handleSubmit : null,
              ),
              const SizedBox(height: 16),
              _Divider(),
              const SizedBox(height: 16),
              _OutlineButton(
                label: 'Sisesta käsitsi',
                icon: Icons.calendar_today_outlined,
                onPressed: () => Navigator.pushNamed(context, '/manual'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  const _PrimaryButton({required this.label, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppTheme.primary.withAlpha(102),
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  const _OutlineButton({required this.label, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.primary,
          side: const BorderSide(color: AppTheme.primary, width: 2),
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppTheme.primary.withAlpha(64), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'või',
            style: TextStyle(fontSize: 14, color: AppTheme.primary.withAlpha(128)),
          ),
        ),
        Expanded(child: Divider(color: AppTheme.primary.withAlpha(64), thickness: 1)),
      ],
    );
  }
}
