import 'package:flutter/material.dart';
import 'package:wink/sleepTimeForm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wink',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Wink Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Range from 0 to 2;
  // Sad is 0, No emotion is 1, Happy is 2;
  int _emotion_state = 2;

  String _emotion = "Sad";

  DateTime setSleepTime = new DateTime(2020, 11, 14, 14);
  DateTime setWakeTime = new DateTime(2020, 11, 14, 23);

  void _updateEmotion() {
    setState(() {
      // Time comparison:
      // DateTime currentTime = new DateTime.now();
      // if (currentTime.isAfter(setSleepTime) &&
      //     currentTime.isBefore(setWakeTime)) {
      //   _emotion_state--;
      // } else if (currentTime.isAfter(setWakeTime) &&
      //     currentTime.isBefore(setSleepTime)) {
      //   _emotion_state++;
      // }
      _emotion_state++;
      if (_emotion_state > 2) {
        _emotion_state = 0;
      }
      switch (_emotion_state) {
        case 0:
          {
            _emotion = "Sad";
          }
          break;

        case 1:
          {
            _emotion = "Neutral";
          }
          break;

        case 2:
          {
            _emotion = "Happy";
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current Emotion:',
            ),
            Text(
              '$_emotion',
              style: Theme.of(context).textTheme.headline4,
            ),
            SleepTimeForm(
              labelText: 'Select sleep time',
              selectedTime: TimeOfDay.now(),
              selectTime: (value) {
                setSleepTime = value as DateTime;
              },
            ),
            SleepTimeForm(
              labelText: 'Select wake time',
              selectedTime: TimeOfDay.now(),
              selectTime: (value) {
                setWakeTime = value as DateTime;
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateEmotion,
        tooltip: 'Update Emotion',
        child: Icon(Icons.add),
      ),
    );
  }
}
