import 'package:flutter/material.dart';
import 'SignUpPage.dart'; // Import the SignUpPage

// The main entry point of the application
void main() {
  runApp(const MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion Vision',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

// Welcome screen widget
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    final double titleFontSize = screenWidth * 0.08;
    final double subtitleFontSize = screenWidth * 0.04;
    final double imageHeight = screenHeight * 0.25;

    return Scaffold(
      // Set background color to #e6d0bc
      backgroundColor: const Color(0xFFE6D0BC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05),
                child: Text(
                  'FashionVision',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05),
                child: Text(
                  'Imagination meets designs',
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Image.asset('assets/wel3-removebg-preview.png',
                      height: imageHeight),
                  Image.asset('assets/wel4-removebg-preview.png',
                      height: imageHeight),
                  Image.asset('assets/wel5-removebg-preview.png',
                      height: imageHeight),
                  Image.asset('assets/wel6-removebg-preview.png',
                      height: imageHeight),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the SignUpPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
