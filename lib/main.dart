import 'package:flutter/material.dart';
import 'screens/loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Weather App',
      home: Loading(),
    );
  }
}
