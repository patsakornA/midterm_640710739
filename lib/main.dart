import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = "0";
  double _result = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _input,
                style: TextStyle(fontSize: 50.0),
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        buildButton('C', constraints),
                        buildButton('DEL', constraints),
                      ],
                    ),
                    Row(
                      children: [
                        buildButton('7', constraints),
                        buildButton('8', constraints),
                        buildButton('9', constraints),
                        buildButton('÷', constraints),
                      ],
                    ),
                    Row(
                      children: [
                        buildButton('4', constraints),
                        buildButton('5', constraints),
                        buildButton('6', constraints),
                        buildButton('×', constraints),
                      ],
                    ),
                    Row(
                      children: [
                        buildButton('1', constraints),
                        buildButton('2', constraints),
                        buildButton('3', constraints),
                        buildButton('-', constraints),
                      ],
                    ),
                    Row(
                      children: [
                        buildButton('0', constraints, flex: 3),
                        buildButton('+', constraints),
                      ],
                    ),
                    Row(
                      children: [
                        buildButton('=', constraints),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText, BoxConstraints constraints,
      {int flex = 1}) {
    Color buttonColor;

    // Set button color based on the type of button
    if (buttonText == 'C' ||
        buttonText == 'DEL' ||
        buttonText == '÷' ||
        buttonText == '×' ||
        buttonText == '-' ||
        buttonText == '+') {
      buttonColor = Colors.grey;
    } else if (buttonText == '=') {
      buttonColor = Colors.green;
    } else {
      buttonColor = Colors.blue;
    }

    return Expanded(
      flex: flex,
      child: ElevatedButton(
        onPressed: () {
          if (buttonText == 'C') {
            clearInput();
          } else if (buttonText == 'DEL') {
            deleteLastCharacter();
          } else {
            handleButtonPress(buttonText);
          }
        },
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          minimumSize:
              Size(constraints.maxWidth / 4, constraints.maxHeight / 6),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  void deleteLastCharacter() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
      }
    });
  }

  void handleButtonPress(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        try {
          _input = _result.toString();
        } catch (e) {
          _input = '';
        }
      } else {
        _input += buttonText;
      }
    });
  }

  void clearInput() {
    setState(() {
      _input = "";
    });
  }
}
