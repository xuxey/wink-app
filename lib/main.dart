import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

//const myTask = "checkTime";
bool _timeSet = false;

// Range from 0 to 2;
// Sad is 0, No emotion is 1, Happy is 2;
int _emotionState = 2;
String _emotion = "Sad";
AssetImage _emotionImage = _happy;
Color _emotionColor = _happyColor;

AssetImage _happy = AssetImage('assets/images/happy.png');
AssetImage _sad = AssetImage('assets/images/sad.png');
AssetImage _neutral = AssetImage('assets/images/neutral.png');
Color _happyColor = Colors.green;
Color _neutralColor = Colors.blue;
Color _sadColor = Colors.red;

DateTime _setSleepTime = new DateTime(2020, 11, 14, 14);
DateTime _setWakeTime = new DateTime(2020, 11, 14, 23);

void update() {
  // Time comparison:
  // DateTime currentTime = new DateTime.now();
  // if (currentTime.isAfter(_setSleepTime) &&
  //     currentTime.isBefore(_setWakeTime)) {
  //   _emotion_state--;
  // } else if (currentTime.isAfter(_setWakeTime) &&
  //     currentTime.isBefore(_setSleepTime)) {
  //   _emotion_state++;
  // }
  _emotionState++;
  if (_emotionState > 2) {
    _emotionState = 0;
  }
  switch (_emotionState) {
    case 0:
      {
        _emotion = "Sad";
        _emotionImage = _sad;
        _emotionColor = _sadColor;
      }
      break;

    case 1:
      {
        _emotion = "Neutral";
        _emotionImage = _neutral;
        _emotionColor = _neutralColor;
      }
      break;

    case 2:
      {
        _emotion = "Happy";
        _emotionImage = _happy;
        _emotionColor = _happyColor;
      }
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wink',
      theme: ThemeData(
        primarySwatch: _emotionColor,
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
  @override
  void initState() {
    super.initState();
    _getTimeSet();
    _getEmotionState();
  }

  Future<bool> _getTimeSet() async {
    final prefs = await SharedPreferences.getInstance();
    final timeHasBeenSet = prefs.getBool('timeSet');
    if (timeHasBeenSet != null) {
      return timeHasBeenSet;
    } else {
      return false;
    }
  }

  Future<int> _getEmotionState() async {
    final prefs = await SharedPreferences.getInstance();
    final emotionState = prefs.getInt('emotionState');
    if (emotionState != null) {
      return emotionState;
    } else {
      return 0;
    }
  }

  Future<void> updateSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    print(_timeSet);
    print(_emotionState);
    await prefs.setBool('timeSet', _timeSet);
    await prefs.setInt('emotionState', _emotionState);
  }

  void setTime() {
    setState(() {
      update();
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.title),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             'Current Emotion:',
  //           ),
  //           Text(
  //             '$_emotion',
  //             style: Theme.of(context).textTheme.headline4,
  //           ),
  //         ],
  //       ), // This trailing comma makes auto-formatting nicer for build methods.
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: [
          new Container(
            color: _emotionColor,
            height: 350.0,
            alignment: Alignment.center,
            child: new Column(
              children: [
                new Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  height: 200.0,
                  width: 200.0,
                  decoration: new BoxDecoration(
                      image: DecorationImage(
                          image: _emotionImage, fit: BoxFit.fill),
                      shape: BoxShape.circle),
                ),
                new Container(
                  child: new Text(
                    'Current Emotion: $_emotion',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.symmetric(vertical: 50.0),
            child: new Column(
              children: [
                Text(
                  'You\'ve used your device for 5 hours after bedtime.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black),
                ),
                SizedBox(height: 50.0),
                Text(
                  'Current bedtime: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black),
                ),
                SizedBox(height: 50.0),
                Text(
                  'Current wake up time: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: setTime,
        child: Text('Update'),
        backgroundColor: _emotionColor,
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
