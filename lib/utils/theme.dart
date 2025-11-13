import 'package:flutter/material.dart';
import 'package:weather_application/utils/custom_themes.dart/app_bar_theme.dart';
import 'package:weather_application/utils/custom_themes.dart/custom_text_theme.dart';
import 'custom_themes.dart/elevate_button_theme.dart';
import 'custom_themes.dart/textfield_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFECF3FE),
    appBarTheme: AppbarTheme.lightAppBarTheme,
    textTheme: CustomTextTheme.lightTextTheme,
    elevatedButtonTheme: ElevateButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TextFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF272727),
    appBarTheme: AppbarTheme.darkAppBarTheme,
    textTheme: CustomTextTheme.darkTextTheme,
    elevatedButtonTheme: ElevateButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TextFieldTheme.darkInputDecorationTheme,
  );
}
