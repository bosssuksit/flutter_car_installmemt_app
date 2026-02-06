import 'package:flutter/material.dart';
import 'package:flutter_car_installmemt_app/views/car_installment_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    // หน่วงเวลา 3 วินาทีแล้วไปที่หน้า CarInstallmentUi
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CarInstallmentUi(),
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ใช้สีเขียวตาม Reference ในรูปภาพ
      backgroundColor: const Color(0xFF4CAF50),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. ส่วนของรูปภาพ Logo (รถและเครื่องคิดเลข)
            // แก้ไขส่วน Image.network ใน Widget build ดังนี้ครับ

            Image.network(
              // ใช้ Link ตรงของรูปภาพ (Direct Link)
              'https://img.freepik.com/premium-vector/auto-calculator_543534-137.jpg',
              width: MediaQuery.of(context).size.width * 0.65,
              // เพิ่มการจัดการกรณีโหลดรูปไม่ได้
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.directions_car,
                  size: 100,
                  color: Colors.white,
                );
              },
              // เพิ่มตัว Loading ระหว่างรอรูปภาพขึ้น
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white70),
                );
              },
            ),

            // 2. ชื่อแอปภาษาอังกฤษ
            const Text(
              'Car Installment',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC0FF8C), // สีเขียวอ่อนสว่างๆ ตามภาพ
              ),
            ),

            // 3. ชื่อแอปภาษาไทย
            const Text(
              'คำนวณค่างวดรถยนต์',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC0FF8C),
              ),
            ),
            const SizedBox(height: 60.0),

            // 4. Loading Indicator (ตัวหมุน)
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 60.0),

            // 5. เครดิตผู้สร้างและเวอร์ชันด้านล่าง
            const Text(
              'Created by Saksit ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
