import 'package:flutter/material.dart';
import 'package:flutter_car_installmemt_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Flutter_car_installmemt_app());
}

class Flutter_car_installmemt_app extends StatefulWidget {
  const Flutter_car_installmemt_app({super.key});

  @override
  State<Flutter_car_installmemt_app> createState() =>
      _FlutterBodyHealthCalculatorAppState();
}

class _FlutterBodyHealthCalculatorAppState
    extends State<Flutter_car_installmemt_app> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
