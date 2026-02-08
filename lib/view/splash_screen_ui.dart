import 'dart:async';
import 'package:flutter/material.dart';
import 'car_installment_ui.dart'; // เรียกแบบนี้ขีดแดงจะหายครับ

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    // ตั้งเวลา 3 วินาที (ตามที่วงกลมหมุน) แล้วไปหน้าต่อไป
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CarInstallmentUi()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // พื้นหลังสีเขียวตามภาพ
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // รูปภาพ No.1.png จากโฟลเดอร์ assets/images
            Image.asset(
              'assets/images/car-loan.webp',
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            const SizedBox(height: 30),
            const Text(
              'Car Installment',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              'คำนวณค่างวดรถยนต์',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            // วงกลมหมุนๆ (Loading)
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 50),
            const Text(
              'Created by NinniN DTI-SAU',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
