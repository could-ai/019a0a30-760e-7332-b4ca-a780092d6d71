import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spinner Wheel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SpinnerPage(),
    );
  }
}

class SpinnerPage extends StatefulWidget {
  const SpinnerPage({super.key});

  @override
  State<SpinnerPage> createState() => _SpinnerPageState();
}

class _SpinnerPageState extends State<SpinnerPage> {
  final StreamController<int> _selected = StreamController<int>();
  String _result = "Pending";
  final List<String> _items = [
    'Groceries',
    'Electronics',
    'Fashion',
    'Home Decor',
    'Books',
    'Sports',
    'Beauty',
    'Toys',
  ];

  @override
  void dispose() {
    _selected.close();
    super.dispose();
  }

  void _spinWheel() {
    final random = Random();
    final selectedIndex = random.nextInt(_items.length);
    _selected.add(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spinner Wheel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: FortuneWheel(
                selected: _selected.stream,
                animateFirst: false,
                items: [
                  for (var it in _items) FortuneItem(child: Text(it)),
                ],
                onFlingEnd: (selectedIndex) {
                  setState(() {
                    _result = _items[selectedIndex];
                  });
                },
                indicators: const <FortuneIndicator>[
                  FortuneIndicator(
                    alignment: Alignment.topCenter,
                    child: TriangleIndicator(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _spinWheel,
              child: const Text('Spin'),
            ),
            const SizedBox(height: 30),
            Text(
              'Result: $_result',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
