import 'package:flutter/material.dart';
import 'package:poleangels_planner/theme/app_theme.dart';
import 'package:poleangels_planner/screens/student/booking_screen.dart';
import 'package:poleangels_planner/screens/student/manual_input_screen.dart';
import 'package:poleangels_planner/screens/student/confirmation_screen.dart';

void main() {
  runApp(const PoleAngelsApp());
}

class PoleAngelsApp extends StatelessWidget {
  const PoleAngelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pole Angels Planner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (_) => const BookingScreen(),
        '/manual': (_) => const ManualInputScreen(),
        '/confirmation': (_) => const ConfirmationScreen(),
      },
    );
  }
}
