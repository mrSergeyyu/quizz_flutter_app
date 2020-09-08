import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'QuizzBrain.dart';

QuizzBrain quizzBrains = QuizzBrain();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: (MyHomePage()),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Icon> answerMark = [];
  int correctAnswerNumber = 0;

  Icon chekingAnswer(bool answer) {
    if (answer == quizzBrains.getQuestionAnswer()) {
      correctAnswerNumber++;
      answerMark.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      answerMark.add(
        Icon(
          Icons.cancel,
          color: Colors.red,
        ),
      );
    }
    quizzBrains.nextQuestion();
    alert(quizzBrains.alertApp());
  }

  //alertPopup
  Alert alert(bool alert) {
    if (alert == true) {
      Alert(
        style: alertStyle,
        context: context,
        type: AlertType.success,
        title: "Congratulations!",
        desc: "You have $correctAnswerNumber correct answers",
        buttons: [
          DialogButton(
              color: Colors.green,
              width: 120,
              child: Text(
                "Try again",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  answerMark.removeRange(0, answerMark.length);
                  correctAnswerNumber = 0;
                  quizzBrains.reset();
                });
              })
        ],
      ).show();
    }
  }

  //AlertSettings
  var alertStyle = AlertStyle(
    backgroundColor: Colors.black,
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(color: Colors.white),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      side: BorderSide(
        color: Colors.white,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                quizzBrains.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 1, 30, 25),
            child: ButtonTheme(
              height: 55,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.green[700])),
                color: Colors.green,
                textColor: Colors.white,
                child: Text(
                  "True",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    chekingAnswer(true);
                  });
                },
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 1, 30, 20),
            child: ButtonTheme(
              height: 55,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.red[700])),
                color: Colors.red,
                textColor: Colors.white,
                child: Text(
                  "False",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    chekingAnswer(false);
                  });
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: answerMark,
          ),
        ),
      ],
    );
  }
}
