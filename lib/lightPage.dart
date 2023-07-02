import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LightPage extends StatefulWidget {
  const LightPage({super.key});

  @override
  State<LightPage> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  static const platform = MethodChannel('example.my.strobe/strobe');
  bool _torchOn = false;
  bool _strobing = false;
  int _delaytime = 1000;
  int _delaytime2 = 950;
  int amplitude = 10; // ความแรงของการสั่น

  int on = 1000;
  int off = 950;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('on $_delaytime ms'),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: Slider(
                  value: _delaytime.toDouble(),
                  min: 1,
                  max: 1000,
                  activeColor: _strobing ? Colors.black : Colors.grey,
                  inactiveColor: Colors.black,
                  onChanged: (newDelay) {
                    setState(() {
                      _delaytime = newDelay.toInt();
                    });
                  }),
            ),
            Center(
              child: Text('off $_delaytime2 ms'),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: Slider(
                  value: _delaytime2.toDouble(),
                  min: 1,
                  max: 1000,
                  activeColor: _strobing ? Colors.black : Colors.grey,
                  inactiveColor: Colors.black,
                  onChanged: (newDelay) {
                    setState(() {
                      _delaytime2 = newDelay.toInt();
                    });
                  }),
            ),
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
            _strobing == false
                ? GestureDetector(
                    onTap: () async {
                      setState(() {
                        _strobing = true;
                      });
                      // ที่ไฟล์ MainActivity.kt มีเขียนโค้ดเอาไว้
                      do {
                        // _torchOn = !_torchOn;
                        SystemChrome.setEnabledSystemUIOverlays([]);
                        await platform.invokeMethod('strobeIt', {"isOn": "$_torchOn"});
                        await Future.delayed(Duration(milliseconds: 1));
                        if (on != 0 && _torchOn) {
                          on -= 1;
                        } else if (on == 0 && _torchOn) {
                          // off -= 1;
                          on = _delaytime;
                          _torchOn = false;
                        } else if (off != 0 && _torchOn == false) {
                          off -= 1;
                        } else if (off == 0 && _torchOn == false) {
                          // off -= 1;
                          off = _delaytime2;
                          _torchOn = true;
                        }
                        print(_delaytime);
                      } while (_strobing);
                    },
                    child: Container(
                      height: 80,
                      width: 70,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.highlight,
                            size: 40,
                          ),
                          Text('เปิด')
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        _strobing = false;
                        _torchOn = false;
                      });
                      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                      await platform.invokeMethod('strobeIt', {"isOn": "true"});
                    },
                    // onTap: () async {
                    //   setState(() {
                    //     _strobing = false;
                    //     _torchOn = false;
                    //   });
                    //   SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                    //   await platform.invokeMethod('strobeIt', {"isOn": "true"});
                    // },
                    child: Container(
                      height: 80,
                      width: 70,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.highlight,
                            size: 40,
                          ),
                          Text('ปิด'),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
