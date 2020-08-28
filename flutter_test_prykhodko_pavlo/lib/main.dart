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

  Color backgroundColor = Colors.black;
  Color textColor = Colors.white;
  String currentColorType = colorTypes[0];

  void _generateColor() {
    setState(() {
      switch (currentColorType) {
        case "Any":
          final alpha = Random().nextInt(256);
          final red = Random().nextInt(256);
          final green = Random().nextInt(256);
          final blue = Random().nextInt(256);
          backgroundColor = Color.fromARGB(alpha, red, green, blue);
          break;
        case "Rainbow":
          backgroundColor =
              rainbowColors[Random().nextInt(rainbowColors.length)];
          break;
        case "Light":
          final alpha = 255;
          final red = 192 + Random().nextInt(64);
          final green = 192 + Random().nextInt(64);
          final blue = 192 + Random().nextInt(64);
          backgroundColor = Color.fromARGB(alpha, red, green, blue);
          break;
        case "Dark":
          final alpha = 128;
          final red = Random().nextInt(128);
          final green = Random().nextInt(128);
          final blue = Random().nextInt(128);
          backgroundColor = Color.fromARGB(alpha, red, green, blue);
          break;
      }

      // This computation is needed to select text color
      // depending on background one to make the first visible
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
                    .map<DropdownMenuItem<String>>((String colorType) {
                  return DropdownMenuItem<String>(
                    value: colorType,
                    child: Text(colorType),
                  );
                }).toList(),
                onChanged: (newColorType) {
                  if (currentColorType != newColorType) {
                    currentColorType = newColorType;
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
