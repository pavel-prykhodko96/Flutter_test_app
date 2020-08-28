import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ChangableBackgroundWidget());
  }
}

class ChangableBackgroundWidget extends StatefulWidget {
  @override
  _ChangableBackgroundWidgetState createState() =>
      _ChangableBackgroundWidgetState();
}

class _ChangableBackgroundWidgetState extends State<ChangableBackgroundWidget> {
  // TO DO: finish choosing color types
  // FIX: the color of the text label

  static const List<String> colorTypes = ["Any", "Light", "Dark", "Rainbow"];
  static const List<Color> rainbowColors = [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 127, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 75, 0, 130),
    Color.fromARGB(255, 143, 0, 255),
  ];

  final Random numbersGenerator = Random();
  Color backgroundColor = Colors.black;
  Color textColor = Colors.white;
  String currentColorType = colorTypes[0];

  void _generateColor() {
    setState(() {
      switch (currentColorType) {
        case "Any":
          final alpha = numbersGenerator.nextInt(256);
          final red = numbersGenerator.nextInt(256);
          final green = numbersGenerator.nextInt(256);
          final blue = numbersGenerator.nextInt(256);
          backgroundColor = Color.fromARGB(alpha, red, green, blue);
          break;
        case "Rainbow":
          backgroundColor =
              rainbowColors[numbersGenerator.nextInt(rainbowColors.length - 1)];
          break;
        case "Light":
          final alpha = 255;
          final red = 192 + numbersGenerator.nextInt(64);
          final green = 192 + numbersGenerator.nextInt(64);
          final blue = 192 + numbersGenerator.nextInt(64);
          backgroundColor = Color.fromARGB(alpha, red, green, blue);
          break;
        case "Dark":
          final alpha = 128;
          final red = numbersGenerator.nextInt(128);
          final green = numbersGenerator.nextInt(128);
          final blue = numbersGenerator.nextInt(128);
          backgroundColor = Color.fromARGB(alpha, red, green, blue);
          break;
      }

      // This computation is needed to select text color
      // depending on background to make the first visible
      final normalizedAlpha = backgroundColor.alpha / 255.0;
      final grey = 0.2126 * backgroundColor.red +
          0.7152 * backgroundColor.green +
          0.0722 * backgroundColor.blue;
      textColor = grey * normalizedAlpha < 128 ? Colors.white : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: this.backgroundColor,
      body: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.transparent),
          child: Center(
            child: Text(
              "Hey there",
              style: TextStyle(color: textColor),
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
        onTap: _generateColor,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Choose colors type: ",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: DropdownButton<String>(
                isExpanded: true,
                style: TextStyle(fontSize: 16, color: Colors.black),
                value: currentColorType,
                items: (_ChangableBackgroundWidgetState.colorTypes)
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  if (currentColorType != value) {
                    currentColorType = value;
                    _generateColor();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
