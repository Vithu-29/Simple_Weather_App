import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/features/welcome_input_screen.dart';
import 'utils/theme.dart';
import 'utils/theme_provider.dart';
import 'features/home/home_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.startOnHome});

  final bool startOnHome;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: startOnHome ? const HomeScreen() : const WelcomeInputScreen(),
    );
  }
}
