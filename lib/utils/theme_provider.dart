import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool? _isDarkMode;
  bool get isDarkMode => _isDarkMode ?? _getSystemTheme();

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('is_dark_mode')) {
      _isDarkMode = prefs.getBool('is_dark_mode');
    } else {
      _isDarkMode = null;
    }
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (_isDarkMode == null) {
      _isDarkMode = !_getSystemTheme();
    } else {
      _isDarkMode = !_isDarkMode!;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_mode', _isDarkMode!);
    notifyListeners();
  }

  bool _getSystemTheme() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }

  void handleSystemThemeChange() {
    if (_isDarkMode == null) {
      notifyListeners();
    }
  }
}
