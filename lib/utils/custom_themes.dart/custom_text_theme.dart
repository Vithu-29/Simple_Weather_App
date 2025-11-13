import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFF333333),
      ),
    ),
    headlineMedium: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xFF333333),
      ),
    ),
    headlineSmall: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF333333),
      ),
    ),

    titleLarge: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF333333),
      ),
    ),

    bodyLarge: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF333333),
      ),
    ),
    bodyMedium: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF333333),
      ),
    ),
    bodySmall: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF333333).withValues(alpha: 0.5),
      ),
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    headlineMedium: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    headlineSmall: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    titleLarge: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    bodyLarge: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    bodyMedium: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),
    bodySmall: GoogleFonts.poppins(
      textStyle: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white.withValues(alpha: 0.5),
      ),
    ),
  );
}
