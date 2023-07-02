import 'dart:async';

import 'package:apptest/QRcodePage.dart';
import 'package:apptest/lightPage.dart';
import 'package:apptest/soundPage.dart';
import 'package:apptest/vibrationPage.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torch_light/torch_light.dart';
import 'package:vibration/vibration.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel('example.my.strobe/strobe');
  bool _torchOn = false;
  bool _strobing = false;
  int _delaytime = 1000;
  int _delaytime2 = 950;
  int amplitude = 10; // ความแรงของการสั่น

  int on = 1000;
  int off = 950;

  bool isturnon = false;
  bool isplay = false;
  bool vibration = false;
  final assetsAudioPlayer = AssetsAudioPlayer();
  Timer? _timer2;
  Timer? _timer;
  int dsecond = 1;
  int second = 1;
  List<int> seconds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> dseconds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> durations = [10000, 20000, 30000, 40000, 50000, 60000];
  int duration = 5000;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('App Testting'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('10'),
            //       Text('20'),
            //       Text('30'),
            //       Text('40'),
            //       Text('50'),
            //       Text('60'),
            //       Text('70'),
            //       Text('80'),
            //       Text('90'),
            //       Text('100'),
            //     ],
            //   ),
            // ),
            // Center(
            //   child: Text('on $_delaytime ms'),
            // ),
            // RotatedBox(
            //   quarterTurns: 2,
            //   child: Slider(
            //       value: _delaytime.toDouble(),
            //       min: 1,
            //       max: 1000,
            //       activeColor: _strobing ? Colors.black : Colors.grey,
            //       inactiveColor: Colors.black,
            //       onChanged: (newDelay) {
            //         setState(() {
            //           _delaytime = newDelay.toInt();
            //         });
            //       }),
            // ),
            // Center(
            //   child: Text('off $_delaytime2 ms'),
            // ),
            // RotatedBox(
            //   quarterTurns: 2,
            //   child: Slider(
            //       value: _delaytime2.toDouble(),
            //       min: 1,
            //       max: 1000,
            //       activeColor: _strobing ? Colors.black : Colors.grey,
            //       inactiveColor: Colors.black,
            //       onChanged: (newDelay) {
            //         setState(() {
            //           _delaytime2 = newDelay.toInt();
            //         });
            //       }),
            // ),
            // GestureDetector(
            //   onLongPressStart: (_) async {
            //     setState(() {
            //       _strobing = true;
            //     });
            //     // ที่ไฟล์ MainActivity.kt มีเขียนโค้ดเอาไว้
            //     do {
            //       _torchOn = !_torchOn;
            //       SystemChrome.setEnabledSystemUIOverlays([]);
            //       await platform.invokeMethod('strobeIt', {"isOn": "$_torchOn"});
            //       await Future.delayed(Duration(milliseconds: _delaytime));
            //     } while (_strobing);
            //   },
            //   onLongPressEnd: (_) async {
            //     setState(() {
            //       _strobing = false;
            //       _torchOn = false;
            //     });
            //     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
            //     await platform.invokeMethod('strobeIt', {"isOn": "true"});
            //   },
            //   onForcePressEnd: (_) async {
            //     setState(() {
            //       _strobing = false;
            //       _torchOn = false;
            //     });
            //     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
            //     await platform.invokeMethod('strobeIt', {"isOn": "true"});
            //   },
            //   child: Container(
            //     height: 50,
            //     width: 70,
            //     decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            //     child: Icon(
            //       Icons.highlight,
            //       size: 50,
            //     ),
            //   ),
            // ),
            // Text('กดค้าง'),
            // _strobing == false
            //     ? GestureDetector(
            //         onTap: () async {
            //           setState(() {
            //             _strobing = true;
            //           });
            //           // ที่ไฟล์ MainActivity.kt มีเขียนโค้ดเอาไว้
            //           do {
            //             // _torchOn = !_torchOn;
            //             SystemChrome.setEnabledSystemUIOverlays([]);
            //             await platform.invokeMethod('strobeIt', {"isOn": "$_torchOn"});
            //             await Future.delayed(Duration(milliseconds: 1));
            //             if (on != 0 && _torchOn) {
            //               on -= 1;
            //             } else if (on == 0 && _torchOn) {
            //               // off -= 1;
            //               on = _delaytime;
            //               _torchOn = false;
            //             } else if (off != 0 && _torchOn == false) {
            //               off -= 1;
            //             } else if (off == 0 && _torchOn == false) {
            //               // off -= 1;
            //               off = _delaytime2;
            //               _torchOn = true;
            //             }
            //             print(_delaytime);
            //           } while (_strobing);
            //         },
            //         child: Container(
            //           height: 80,
            //           width: 70,
            //           decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Icon(
            //                 Icons.highlight,
            //                 size: 40,
            //               ),
            //               Text('เปิด')
            //             ],
            //           ),
            //         ),
            //       )
            //     : GestureDetector(
            //         onTap: () async {
            //           setState(() {
            //             _strobing = false;
            //             _torchOn = false;
            //           });
            //           SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
            //           await platform.invokeMethod('strobeIt', {"isOn": "true"});
            //         },
            //         // onTap: () async {
            //         //   setState(() {
            //         //     _strobing = false;
            //         //     _torchOn = false;
            //         //   });
            //         //   SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
            //         //   await platform.invokeMethod('strobeIt', {"isOn": "true"});
            //         // },
            //         child: Container(
            //           height: 80,
            //           width: 70,
            //           decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Icon(
            //                 Icons.highlight,
            //                 size: 40,
            //               ),
            //               Text('ปิด'),
            //             ],
            //           ),
            //         ),
            //       ),

            // SizedBox(
            //   height: size.height * 0.03,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('10'),
            //       Text('50'),
            //       Text('100'),
            //       Text('150'),
            //       Text('200'),
            //       Text('250'),
            //     ],
            //   ),
            // ),
            // RotatedBox(
            //   quarterTurns: 2,
            //   child: Slider(
            //       value: amplitude.toDouble(),
            //       min: 10,
            //       max: 250,
            //       activeColor: vibration ? Colors.black : Colors.grey,
            //       inactiveColor: Colors.black,
            //       onChanged: (newAmplitude) {
            //         setState(() {
            //           amplitude = newAmplitude.toInt();
            //         });
            //       }),
            // ),
            // InkWell(
            //   onTap: () {
            //     print('object 1');
            //     //await Vibration.vibrate(duration: 1000, amplitude: 128);
            //     //Vibration.vibrate(duration: 1000, amplitude: 255);

            //     //Vibration.cancel();
            //     if (vibration == false) {
            //       setState(() {
            //         vibration = true;
            //       });
            //       if (_timer != null) _timer!.cancel();
            //       _timer = Timer.periodic(Duration(seconds: dsecond), (timer) async {
            //         Vibration.vibrate(duration: duration, amplitude: amplitude);
            //       });
            //       // Vibration.vibrate(duration: duration, amplitude: 255);
            //     } else {
            //       setState(() {
            //         vibration = false;
            //       });
            //       Vibration.cancel();
            //       _timer!.cancel();
            //     }
            //   },
            //   child: Container(
            //       height: size.height * 0.05,
            //       width: size.width * 0.35,
            //       color: Colors.grey,
            //       child: Center(child: Text('สั่น'))),
            // ),
            SizedBox(
              height: size.height * 0.03,
            ),
            // Center(
            //   child: Container(
            //     height: size.height * 0.30,
            //     width: size.width * 0.70,
            //     color: vibration == true ? Colors.green : Colors.red,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text('เลือกระยะเวลาที่จะให้เครื่องสั่น หน่วย ms'),
            //         DropdownButton<int>(
            //           value: duration,
            //           icon: const Icon(Icons.arrow_downward),
            //           elevation: 16,
            //           style: const TextStyle(color: Colors.deepPurple),
            //           underline: Container(
            //             height: 2,
            //             color: Colors.deepPurpleAccent,
            //           ),
            //           onChanged: (int? value) {
            //             // This is called when the user selects an item.
            //             setState(() {
            //               duration = value!;
            //             });
            //           },
            //           items: durations.map<DropdownMenuItem<int>>((int value) {
            //             return DropdownMenuItem<int>(
            //               value: value,
            //               child: Text(value.toString()),
            //             );
            //           }).toList(),
            //         ),
            //         Text('เลือกช่วงเวลาที่จะให้เครื่องสั่น'),
            //         DropdownButton<int>(
            //           value: dsecond,
            //           icon: const Icon(Icons.arrow_downward),
            //           elevation: 16,
            //           style: const TextStyle(color: Colors.deepPurple),
            //           underline: Container(
            //             height: 2,
            //             color: Colors.deepPurpleAccent,
            //           ),
            //           onChanged: (int? value2) {
            //             // This is called when the user selects an item.
            //             setState(() {
            //               dsecond = value2!;
            //             });
            //           },
            //           items: dseconds.map<DropdownMenuItem<int>>((int value2) {
            //             return DropdownMenuItem<int>(
            //               value: value2,
            //               child: Text(value2.toString()),
            //             );
            //           }).toList(),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             print('object 1');
            //             //await Vibration.vibrate(duration: 1000, amplitude: 128);
            //             //Vibration.vibrate(duration: 1000, amplitude: 255);

            //             //Vibration.cancel();
            //             if (vibration == false) {
            //               setState(() {
            //                 vibration = true;
            //               });
            //               if (_timer != null) _timer!.cancel();
            //               _timer = Timer.periodic(Duration(seconds: dsecond), (timer) async {
            //                 Vibration.vibrate(duration: duration, amplitude: 255);
            //               });
            //               // Vibration.vibrate(duration: duration, amplitude: 255);
            //             } else {
            //               setState(() {
            //                 vibration = false;
            //               });
            //               Vibration.cancel();
            //               _timer!.cancel();
            //             }
            //           },
            //           child: Container(height: size.height * 0.05, width: size.width * 0.35, color: Colors.grey, child: Center(child: Text('สั่น'))),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Center(
              child: InkWell(
                onTap: () {
                  print('object 3');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LightPage()));
                },
                child: Container(
                  height: size.height * 0.1,
                  width: size.width * 0.70,
                  color: isplay == true ? Colors.green : Colors.red,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.highlight,
                        size: 25,
                      ),
                      Text(
                        'ไฟ',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  )),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  print('object 3');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VibrationPage()));
                },
                child: Container(
                  height: size.height * 0.1,
                  width: size.width * 0.70,
                  color: isplay == true ? Colors.green : Colors.red,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.vibration,
                        size: 25,
                      ),
                      Text(
                        'สั่น',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  )),
                ),
              ),
            ),
            // Center(
            //   child: Container(
            //     height: size.height * 0.1,
            //     width: size.width * 0.70,
            //     color: isturnon == true ? Colors.green : Colors.red,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text('เลือกช่วงเวลาที่จะให้เปิดแสงกระพริบ'),
            //         DropdownButton<int>(
            //           value: second,
            //           icon: const Icon(Icons.arrow_downward),
            //           elevation: 16,
            //           style: const TextStyle(color: Colors.deepPurple),
            //           underline: Container(
            //             height: 2,
            //             color: Colors.deepPurpleAccent,
            //           ),
            //           onChanged: (int? value1) {
            //             // This is called when the user selects an item.
            //             setState(() {
            //               second = value1!;
            //             });
            //           },
            //           items: seconds.map<DropdownMenuItem<int>>((int value1) {
            //             return DropdownMenuItem<int>(
            //               value: value1,
            //               child: Text(value1.toString()),
            //             );
            //           }).toList(),
            //         ),
            //         InkWell(
            //             onTap: () async {
            //               print('object 2');
            //               if (isturnon == false) {
            //                 setState(() {
            //                   isturnon = true;
            //                 });

            //                 if (_timer2 != null) _timer2!.cancel();
            //                 _timer2 = Timer.periodic(Duration(seconds: second), (timer2) async {
            //                   try {
            //                     for (var i = 0; i < 25; i++) {
            //                       final _seconds = i % 2;
            //                       if (_seconds == 0) {
            //                         print(_seconds);
            //                         await TorchLight.enableTorch();
            //                       } else {
            //                         await TorchLight.disableTorch();
            //                       }
            //                     }
            //                   } on Exception catch (_) {
            //                     // Handle error
            //                   }
            //                 });
            //               } else {
            //                 setState(() {
            //                   isturnon = false;
            //                 });
            //                 try {
            //                   await TorchLight.disableTorch();
            //                   _timer2!.cancel();
            //                 } on Exception catch (_) {
            //                   // Handle error
            //                 }
            //               }
            //             },
            //             child: Container(height: size.height * 0.05, width: size.width * 0.35, color: Colors.grey, child: Center(child: Text('แสง')))),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  print('object 3');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SoundPage()));
                },
                child: Container(
                  height: size.height * 0.1,
                  width: size.width * 0.70,
                  color: isplay == true ? Colors.green : Colors.red,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.volume_up_rounded,
                        size: 25,
                      ),
                      Text(
                        'เสียง',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  )),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  print('object 3');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QRcodePage()));
                },
                child: Container(
                  height: size.height * 0.1,
                  width: size.width * 0.70,
                  color: isplay == true ? Colors.green : Colors.red,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code,
                        size: 25,
                      ),
                      Text(
                        ' QRcode',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
