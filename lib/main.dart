import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  int totalTime = 0;
  int times = 0;
  late Timer timer;
  String timeview = '0:00:00';
  bool isRunning = false;

  void timeStart() {
    if (isRunning) {
      timeStop();
    } else {
      setState(() {
        isRunning = !isRunning;
      });
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          timeview = Duration(seconds: times).toString().split('.')[0];
          if (times < 0 || times == 0) {
            timeStop();
          }
          times--;
        });
      });
    }
  }

  void timeReset() {
    timeStop();
    setState(() {
      times = totalTime;
      isRunning = false;
      timeview = Duration(seconds: times).toString().split('.')[0];
    });
  }

  void timeStop() {
    timer.cancel();
    setState(() {
      isRunning = !isRunning;
    });
  }

  void timeplus(int sec) {
    times = times + sec;
    times = times < 0 ? 0 : times;
    setState(() {
      timeview = Duration(seconds: times).toString().split('.')[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      '타이모루',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                )),
            Flexible(
                child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => timeplus(60),
                            child: Container(
                              width: 120,
                              height: 100,
                              child: Center(
                                  child: Text(
                                '60s',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 255, 8),
                                    fontSize: 60),
                              )),
                            ),
                          ),
                          IconButton(
                              iconSize: 100,
                              onPressed: () => timeplus(10),
                              icon: Icon(
                                Icons.timer_10_select,
                                color: Colors.blue,
                              )),
                          IconButton(
                              iconSize: 100,
                              onPressed: () => timeplus(3),
                              icon: Icon(
                                Icons.timer_3_select,
                                color: Color.fromARGB(255, 0, 38, 255),
                              )),
                          GestureDetector(
                            onTap: () => timeplus(1),
                            child: Container(
                              width: 70,
                              height: 100,
                              child: Center(
                                  child: Text(
                                '1s',
                                style: TextStyle(
                                    color: Colors.purple, fontSize: 60),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ))),
            Flexible(
                child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        '$timeview',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ))),
            Flexible(
                child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isRunning)
                            IconButton(
                                iconSize: 100,
                                onPressed: timeStart,
                                icon: const Icon(
                                  Icons.pause_circle,
                                  color: Colors.greenAccent,
                                ))
                          else
                            IconButton(
                                iconSize: 100,
                                onPressed: timeStart,
                                icon: const Icon(
                                  Icons.play_circle,
                                  color: Colors.red,
                                )),
                          IconButton(
                              iconSize: 100,
                              onPressed: timeReset,
                              icon: const Icon(
                                Icons.restore_rounded,
                                color: Color.fromARGB(255, 255, 238, 0),
                              ))
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
