import 'package:flutter/material.dart';

extension AmazingTextStyle on TextTheme {
  TextStyle get formFieldLabel => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
  TextStyle get cardTitle => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
}
