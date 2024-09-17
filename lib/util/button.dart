import 'dart:ffi';

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color? color;

  VoidCallback onPressed;

  Button({super.key, required this.text, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color ?? Colors.teal,
      child: Text(text),
    );
  }
}
