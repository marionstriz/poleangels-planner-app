import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFD94F8A);
  static const Color background = Color(0xFFFDF6F8);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color primaryLight = Color(0x33D94F8A); // 20% opacity
  static const Color primaryFaint = Color(0x1AD94F8A); // 10% opacity
  static const Color divider = Color(0x66D94F8A); // 40% opacity

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        surface: surface,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        shadowColor: Color(0x1A000000),
      ),
      fontFamily: 'Inter',
    );
  }
}
