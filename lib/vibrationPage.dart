import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class VibrationPage extends StatefulWidget {
  const VibrationPage({super.key});

  @override
  State<VibrationPage> createState() => _VibrationPageState();
}

class _VibrationPageState extends State<VibrationPage> {
  int amplitude = 10; // ความแรงของการสั่น
  bool isturnon = false;
  bool isplay = false;
  bool vibration = false;
  final assetsAudioPlayer = AssetsAudioPlayer();
  Timer? _timer;
  int dsecond = 1;
  int second = 1;
  List<int> seconds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> dseconds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> durations = [10000, 20000, 30000, 40000, 50000, 60000];
  int duration = 500;
  int duration2 = 50;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('10'),
                  Text('50'),
                  Text('100'),
                  Text('150'),
                  Text('200'),
                  Text('250'),
                ],
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: Slider(
                  value: amplitude.toDouble(),
                  min: 10,
                  max: 250,
                  activeColor: vibration ? Colors.black : Colors.grey,
                  inactiveColor: Colors.black,
                  onChanged: (newAmplitude) {
                    setState(() {
                      amplitude = newAmplitude.toInt();
                    });
                  }),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: Slider(
                  value: duration2.toDouble(),
                  // min: 1,
                  max: 100,
                  activeColor: vibration ? Colors.black : Colors.grey,
                  inactiveColor: Colors.black,
                  label: duration2.round().toString(),
                  onChanged: (newAmplitude) {
                    setState(() {
                      duration2 = newAmplitude.toInt();
                      print(duration2);
                    });
                  }),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: Slider(
                  value: duration2.toDouble(),
                  // min: 1,
                  max: 100,
                  activeColor: vibration ? Colors.black : Colors.grey,
                  inactiveColor: Colors.black,
                  onChanged: (newAmplitude) {
                    setState(() {
                      duration2 = newAmplitude.toInt();
                      print(duration2);
                    });
                  }),
            ),
            InkWell(
              onTap: () {
                print('object 1');
                //await Vibration.vibrate(duration: 1000, amplitude: 128);
                //Vibration.vibrate(duration: 1000, amplitude: 255);

                //Vibration.cancel();
                if (vibration == false) {
                  setState(() {
                    vibration = true;
                  });
                  if (_timer != null) _timer!.cancel();
                  _timer = Timer.periodic(Duration(milliseconds: duration2), (timer) async {
                    Vibration.vibrate(duration: duration, amplitude: amplitude);
                  });
                  // Vibration.vibrate(duration: duration, amplitude: 255);
                } else {
                  setState(() {
                    vibration = false;
                  });
                  Vibration.cancel();
                  _timer!.cancel();
                }
              },
              child: Container(
                  height: size.height * 0.05,
                  width: size.width * 0.35,
                  color: Colors.grey,
                  child: Center(child: Text('สั่น'))),
            ),
          ],
        ),
      ),
    );
  }
}
