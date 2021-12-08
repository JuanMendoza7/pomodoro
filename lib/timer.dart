import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'demo.dart';

class Timer extends StatefulWidget {
  Timer({Key? key}) : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  int _duration = 2500;
  bool _isPause = false;
  CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            Center(
              child: CircularCountDownTimer(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                duration: _duration,
                fillColor: Colors.redAccent,
                controller: _controller,
                backgroundColor: Colors.white54,
                strokeWidth: 10.0,
                strokeCap: StrokeCap.round,
                autoStart: true,
                isTimerTextShown: true,
                isReverse: true,
                onComplete: () {
                  FlutterRingtonePlayer.play(
                    android: AndroidSounds.notification,
                    ios: IosSounds.glass,
                    looping: false, // Android only - API >= 28 /
                    volume: 0.1, // Android only - API >= 28/
                    asAlarm: false, // Android only - all APIs/
                  );
                  Alert(
                          context: context,
                          title: 'Done',
                          style: AlertStyle(
                            isCloseButton: true,
                            isButtonVisible: false,
                            titleStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                            ),
                          ),
                          type: AlertType.success)
                      .show();
                },
                textStyle:
                    TextStyle(fontSize: 50.0, color: Colors.red.shade900),
                ringColor: Colors.red,
              ),
            ),
            FloatingActionButton.extended(
                onPressed: () => _controller.restart(duration: _duration),
                label: Text('restart work timer'),
                icon: Icon(Icons.restart_alt)),
            SizedBox(height: 10),
            FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  if (_isPause) {
                    _isPause = false;
                    _controller.resume();
                  } else {
                    _isPause = true;
                    _controller.pause();
                  }
                });
              },
              icon: Icon(
                _isPause ? Icons.play_arrow : Icons.pause,
              ),
              label: Text(
                _isPause ? 'Resume' : 'Pause',
              ),
            ),
            SizedBox(height: 10),
            FloatingActionButton.extended(
                onPressed: () => _controller.restart(duration: 300),
                label: Text('rest'),
                icon: Icon(Icons.hourglass_empty_sharp)),
            SizedBox(height: 10),
            FloatingActionButton.extended(
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DemoApp()))
                    },
                label: Text('menu'),
                icon: Icon(Icons.menu_book_outlined)),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
