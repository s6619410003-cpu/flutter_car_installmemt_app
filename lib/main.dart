import 'package:flutter/material.dart';
import 'view/splash_screen_ui.dart'; // ตรวจสอบ path ให้ถูกต้อง

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
    ),
  );
}
