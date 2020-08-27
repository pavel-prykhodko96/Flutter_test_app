import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangableBackgroundWidget();
  }
}

class ChangableBackgroundWidget extends StatefulWidget {
  @override
  _ChangableBackgroundWidgetState createState() =>
      _ChangableBackgroundWidgetState();
}

class _ChangableBackgroundWidgetState extends State<ChangableBackgroundWidget> {
  final Random numbersGenerator = Random();
  Color backgroundColor = Colors.black;
  // Color textColor = Colors.white;

  void _generateColor() {
    setState(() {
      backgroundColor = Color.fromARGB(
          numbersGenerator.nextInt(256),
          numbersGenerator.nextInt(256),
          numbersGenerator.nextInt(256),
          numbersGenerator.nextInt(256));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: backgroundColor),
        child: Center(
          child: Text(
            "Hey there",
            style: TextStyle(),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
      onTap: _generateColor,
    );
  }
}
