import 'package:flutter/material.dart';

extension AmazingTextButtonStyle on TextButtonThemeData {
  ButtonStyle get bottomButton => TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 24),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
}
