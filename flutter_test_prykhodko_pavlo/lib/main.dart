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
  Color textColor = Colors.white;

  void _generateColor() {
    setState(() {
      final alpha = numbersGenerator.nextInt(256);
      final red = numbersGenerator.nextInt(256);
      final green = numbersGenerator.nextInt(256);
      final blue = numbersGenerator.nextInt(256);

      backgroundColor = Color.fromARGB(alpha, red, green, blue);

      // EXTRA FEATURE: This computation is needed to select text color
      // depending on background to make the first visible
      final normalizedAlpha = alpha / 255.0;
      final grey = 0.2126 * red + 0.7152 * green + 0.0722 * blue;
      textColor = grey * normalizedAlpha < 128 ? Colors.white : Colors.black;
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
            style: TextStyle(color: textColor),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
      onTap: _generateColor,
    );
  }
}
