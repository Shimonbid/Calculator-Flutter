import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

void main() => runApp(YopiWearOS());

class YopiWearOS extends StatelessWidget {
  const YopiWearOS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Yopi WearOS',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _leftNumber = 0;
  int _rightNumber = 0;

  void _generateRandomNumbers() {
    final random = Random();
    setState(() {
      _leftNumber = random.nextInt(100);
      _rightNumber = random.nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Yopi WearOS'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCircleWidget(_leftNumber, 'VO2'),
            _buildCircleWidget(_rightNumber, 'Effort'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRandomNumbers,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildCircleWidget(int number, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            children: [
              CircularProgressIndicator(
                value: number / 100,
                backgroundColor: Colors.grey[300],
              ),
              Center(
                child: Text(
                  number.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
