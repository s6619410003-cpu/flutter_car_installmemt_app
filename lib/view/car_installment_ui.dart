import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // สำหรับจัดการตัวเลข Comma

class CarInstallmentUi extends StatefulWidget {
  const CarInstallmentUi({super.key});

  @override
  State<CarInstallmentUi> createState() => _CarInstallmentUiState();
}

class _CarInstallmentUiState extends State<CarInstallmentUi> {
  // Controllers สำหรับช่องกรอกข้อมูล
  TextEditingController carPriceCtrl = TextEditingController();
  TextEditingController interestRateCtrl = TextEditingController();

  // ตัวแปรสำหรับเก็บค่าที่เลือก
  int selectedDownPayment = 10; // ค่าเริ่มต้น Radio 10%
  String selectedPeriod = '24'; // ค่าเริ่มต้น Dropdown 24 เดือน
  String monthlyInstallment = '0.00'; // ค่าที่จะแสดงผล

  // รายการสำหรับ Dropdown
  List<String> periods = ['24', '36', '48', '60', '72'];

  // ฟังก์ชันคำนวณ
  void calculateInstallment() {
    // 1. Validate ข้อมูล
    if (carPriceCtrl.text.isEmpty || interestRateCtrl.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('คำเตือน'),
          content: const Text('กรุณาป้อนราคารถและอัตราดอกเบี้ยให้ครบถ้วน'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ตกลง'),
            ),
          ],
        ),
      );
      return;
    }

    // 2. แปลงค่าเพื่อคำนวณ
    double carPrice = double.parse(carPriceCtrl.text);
    double interestRate = double.parse(interestRateCtrl.text);
    int periodMonths = int.parse(selectedPeriod);

    // 3. ใช้สูตรคำนวณตามโจทย์
    double financeAmount = carPrice - (carPrice * selectedDownPayment / 100);
    double totalInterest =
        (financeAmount * interestRate / 100) * (periodMonths / 12);
    double result = (financeAmount + totalInterest) / periodMonths;

    // 4. แสดงผลแบบมี Comma (Challenge!)
    setState(() {
      monthlyInstallment = NumberFormat('#,##0.00').format(result);
    });
  }

  // ฟังก์ชันยกเลิก (Reset)
  void resetForm() {
    setState(() {
      carPriceCtrl.clear();
      interestRateCtrl.clear();
      selectedDownPayment = 10;
      selectedPeriod = '24';
      monthlyInstallment = '0.00';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CI Calculator'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('คำนวณค่างวดรถ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            // รูปภาพ No.2.png
            Image.asset('assets/images/approval.webp', height: 180),
            const SizedBox(height: 20),

            // ราคารถ
            TextField(
              controller: carPriceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'ราคารถ (บาท)',
                  border: OutlineInputBorder(),
                  hintText: '0.00'),
            ),
            const SizedBox(height: 15),

            // RadioGroup เงินดาวน์
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('จำนวนเงินดาวน์ (%)')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [10, 20, 30, 40, 50].map((int value) {
                return Row(
                  children: [
                    Radio(
                      value: value,
                      groupValue: selectedDownPayment,
                      onChanged: (int? val) =>
                          setState(() => selectedDownPayment = val!),
                    ),
                    Text('$value'),
                  ],
                );
              }).toList(),
            ),

            // Dropdown ระยะเวลาผ่อน
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('ระยะเวลาผ่อน (เดือน)')),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedPeriod,
              items: periods.map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text('$value เดือน'));
              }).toList(),
              onChanged: (String? val) => setState(() => selectedPeriod = val!),
            ),
            const SizedBox(height: 15),

            // อัตราดอกเบี้ย
            TextField(
              controller: interestRateCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'อัตราดอกเบี้ย (%/ปี)',
                  border: OutlineInputBorder(),
                  hintText: '0.00'),
            ),
            const SizedBox(height: 25),

            // ปุ่มกด
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: calculateInstallment,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white),
                    child: const Text('คำนวณ'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: resetForm,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white),
                    child: const Text('ยกเลิก'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // ส่วนแสดงผล
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.green.shade50,
              child: Column(
                children: [
                  const Text('ค่างวดรถต่อเดือนเป็นเงิน'),
                  Text(
                    monthlyInstallment,
                    style: const TextStyle(
                        fontSize: 40,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text('บาทต่อเดือน'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
