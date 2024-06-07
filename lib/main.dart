import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/view/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
