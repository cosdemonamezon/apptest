import 'dart:math';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRcodePage extends StatefulWidget {
  const QRcodePage({super.key});

  @override
  State<QRcodePage> createState() => _QRcodePageState();
}

class _QRcodePageState extends State<QRcodePage> {
  TextEditingController code = TextEditingController();

  int randomInt = Random().nextInt(9000000) + 1000000;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(
                child: QrImage(
                  data: randomInt.toString(),
                  size: 300,
                  backgroundColor: Colors.transparent,
                  // eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.white),
                  // dataModuleStyle: QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey)),
              // margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
              padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
              width: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.75,
                    child: TextFormField(
                      controller: code,
                      // maxLength: 10,
                      obscureText: false,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: "รหัสเชิญชวนหรือแสกน",
                          labelStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await BarcodeScanner.scan();
                      print(result);
                      setState(() {
                        code.text = result.rawContent;
                      });
                    },
                    child: Icon(Icons.qr_code),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                style: ButtonStyle(
                    // backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 112, 46, 227)),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(13)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
                onPressed: () async {
                  if (code.text.isNotEmpty && code.text.length == 7) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('รหัส'),
                        content: Text(randomInt.toString()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('ตกลง'),
                          )
                        ],
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('ผิดพลาด'),
                        content: Text("กรุณากรอกรหัส/รหัสไม่ถูกต้อง"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('ตกลง'),
                          )
                        ],
                      ),
                    );
                  }
                },
                child: Text("รับ รหัส",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
