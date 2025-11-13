import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElevateButtonTheme {
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Color(0xFFECF3FE),
      backgroundColor: Color(0xFF4B68FF),
      disabledForegroundColor: Color(0xFF939393),
      disabledBackgroundColor: Color(0xFFC4C4C4),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Color(0xFFECF3FE),
      backgroundColor: Color(0xFF4B68FF),
      disabledForegroundColor: Color(0xFF939393),
      disabledBackgroundColor: Color(0xFF4F4F4F),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
