import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:favorite_app_20220248/screens/home.dart';

Future<void> main() async {
  await Hive.initFlutter();

  await Hive.openBox('favorites');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}
