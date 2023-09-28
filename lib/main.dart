import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mlingo/home_screen.dart';
import 'package:mlingo/models/table_model.dart';

import 'configs.dart';

void main() async {
  await _initApp();
  runApp(const MyApp());
}

_initApp() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TableModelAdapter());
  DatabaseUtil.box = await Hive.openBox('key_box');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
