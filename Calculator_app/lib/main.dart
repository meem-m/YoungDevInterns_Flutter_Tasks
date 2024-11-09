import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Reset calculator
        _output = "0";
        _currentInput = "";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "X" || buttonText == "/") {
        // Set operator
        _num1 = double.tryParse(_currentInput) ?? 0;
        _operator = buttonText;
        _currentInput = "";
      } else if (buttonText == "=") {
        // Calculate result
        _num2 = double.tryParse(_currentInput) ?? 0;
        if (_operator == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operator == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operator == "X") {
          _output = (_num1 * _num2).toString();
        } else if (_operator == "/") {
          _output = _num2 != 0 ? (_num1 / _num2).toString() : "Error";
        }
        _num1 = 0;
        _num2 = 0;
        _operator = "";
        _currentInput = _output;
      } else {
        // Append number or decimal to current input
        if (buttonText == "." && _currentInput.contains(".")) {
          // Prevent multiple decimals
          return;
        }
        _currentInput += buttonText;
        _output = _currentInput;
      }
    });
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: <Widget>[
                  buildButton("7", Colors.grey),
                  buildButton("8", Colors.grey),
                  buildButton("9", Colors.grey),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4", Colors.grey),
                  buildButton("5", Colors.grey),
                  buildButton("6", Colors.grey),
                  buildButton("X", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1", Colors.grey),
                  buildButton("2", Colors.grey),
                  buildButton("3", Colors.grey),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton(".", Colors.grey),
                  buildButton("0", Colors.grey),
                  buildButton("=", Colors.orange),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("C", Colors.red), // Clear button
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
