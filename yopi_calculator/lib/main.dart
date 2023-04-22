import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

//run app
void main() {
  runApp(Calculator());
}

//create state
class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

//use state
class _CalculatorState extends State<Calculator> {
  //initial param
  String input = '';
  String previousInput = '';
  String result = '';

  //buttons press
  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        input = '';
        previousInput = '';
        result = '';
      } else if (buttonText == '⌫') {
        input = input.substring(0, input.length - 1);
      } else if (buttonText == '=') {
        try {
          //parser buttonText and update param
          Parser p = Parser();
          Expression exp = p.parse(input);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          previousInput = input;
          input = result;
        } catch (e) {
          result = 'Error';
        }
      } else {
        input += buttonText;
      }
    });
  }

  //widget Button
  Widget buildButton(String buttonText) {
    return TextButton(
      onPressed: () => onButtonPressed(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 24.0),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
        padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
  }

  //widget Context
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculator'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  previousInput,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  input,
                  style: TextStyle(fontSize: 48.0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('C'),
                buildButton('⌫'),
                buildButton('%'),
                buildButton('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('*'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('+'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('0'),
                buildButton('.'),
                buildButton('00'),
                buildButton('='),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
