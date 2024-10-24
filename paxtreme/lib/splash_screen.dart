import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacementNamed('/lib/login.dart');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF023047), // Set the background color
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4, // Adjust flex values to distribute space more responsively
            child: Center(
              child: Image.asset(
                'assets/splash.gif',
                width: screenWidth * 1.0, // Use 80% of the screen width
                height: screenHeight * 0.8, // Use 60% of the screen height
                fit: BoxFit.fill, // Ensure the image fits well within the allocated space
              ),
            ),
          ),
          const Spacer(), // Pushes the text to the bottom
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.05), // Responsive padding
            child: const Text(
              'Copyright Nebras Technology 2024',
              style: TextStyle(
                color: Colors.white, // Text color set to white for better contrast
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}