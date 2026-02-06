import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarInstallmentUi extends StatefulWidget {
  const CarInstallmentUi({super.key});

  @override
  State<CarInstallmentUi> createState() => _CarInstallmentUiState();
}

class _CarInstallmentUiState extends State<CarInstallmentUi> {
  // Controller สำหรับรับค่าจาก TextField
  final TextEditingController _carPriceCtrl = TextEditingController();
  final TextEditingController _interestCtrl = TextEditingController();

  // ตัวแปรสำหรับเก็บค่าต่างๆ (Challenge)
  int _downPercent = 10; // สำหรับ Radio Group
  String _installmentMonth = '24 เดือน'; // สำหรับ Dropdown
  double _resultMonth = 0.00; // ผลลัพธ์การคำนวณ

  // รายการสำหรับ Dropdown
  final List<String> _monthList = [
    '24 เดือน',
    '36 เดือน',
    '48 เดือน',
    '60 เดือน',
    '72 เดือน'
  ];

  // ฟังก์ชันคำนวณ
  void _calculateInstallment() {
    // 1. Validate ข้อมูลว่าป้อนหรือยัง
    if (_carPriceCtrl.text.isEmpty || _interestCtrl.text.isEmpty) {
      _showWarningDialog('กรุณากรอกข้อมูลราคารถและอัตราดอกเบี้ยให้ครบถ้วน');
      return;
    }

    // 2. แปลงค่าเพื่อคำนวณ
    double carPrice = double.parse(_carPriceCtrl.text);
    double interestRate = double.parse(_interestCtrl.text);
    // ดึงเฉพาะตัวเลขจาก String เช่น "24 เดือน" ให้เหลือแค่ 24
    int months = int.parse(_installmentMonth.split(' ')[0]);

    // 3. เริ่มคำนวณตามสูตร
    // ยอดจัด = ราคารถ - (ราคารถ * เงินดาวน์(%) / 100)
    double financeAmount = carPrice - (carPrice * _downPercent / 100);

    // ดอกเบี้ยทั้งหมด = (ยอดจัด * (อัตราดอกเบี้ย/100)) * (จำนวนปี)
    double totalInterest =
        (financeAmount * (interestRate / 100)) * (months / 12);

    // ค่างวดต่อเดือน = (ยอดจัด + ดอกเบี้ยทั้งหมด) / จำนวนเดือน
    setState(() {
      _resultMonth = (financeAmount + totalInterest) / months;
    });
  }

  // ฟังก์ชันรีเซ็ตค่า (ปุ่มยกเลิก)
  void _resetForm() {
    setState(() {
      _carPriceCtrl.clear();
      _interestCtrl.clear();
      _downPercent = 10;
      _installmentMonth = '24 เดือน';
      _resultMonth = 0.00;
    });
  }

  // แจ้งเตือนเมื่อกรอกไม่ครบ
  void _showWarningDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('คำเตือน'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ตัวแปรสำหรับจัดฟอร์แมตตัวเลขหลักพัน (Challenge)
    var fNum = NumberFormat("#,###.00", "en_US");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Installment',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'คำนวณค่างวดรถ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // ส่วนแสดงรูปภาพ (แก้ให้แล้วครับ)
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://img.freepik.com/premium-vector/auto-calculator_543534-137.jpg',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.directions_car,
                      size: 100,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text('ราคารถ (บาท)',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _carPriceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'ป้อนราคารถ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            const Text('จำนวนเงินดาวน์ (%)',
                style: TextStyle(fontWeight: FontWeight.bold)),
            // Radio Group Challenge
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [10, 20, 30, 40, 50].map((int value) {
                return Row(
                  children: [
                    Radio<int>(
                      value: value,
                      groupValue: _downPercent,
                      activeColor: Colors.green,
                      onChanged: (int? newValue) {
                        setState(() {
                          _downPercent = newValue!;
                        });
                      },
                    ),
                    Text('$value%'),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 10),

            const Text('ระยะเวลาผ่อน (เดือน)',
                style: TextStyle(fontWeight: FontWeight.bold)),
            // Dropdown Challenge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _installmentMonth,
                  isExpanded: true,
                  items: _monthList.map((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _installmentMonth = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),

            const Text('อัตราดอกเบี้ย (%/ปี)',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _interestCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'ป้อนดอกเบี้ย',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculateInstallment,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15)),
                    child: const Text('คำนวณ'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15)),
                    child: const Text('ยกเลิก'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // ส่วนแสดงผลลัพธ์
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green[50],
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Text('ค่างวดรถต่อเดือนเป็นเงิน',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(
                    fNum.format(_resultMonth),
                    style: const TextStyle(
                        fontSize: 35,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text('บาทต่อเดือน', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
