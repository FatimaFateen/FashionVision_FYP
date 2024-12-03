import 'package:flutter/material.dart';
import 'customization_tassels.dart'; // Updated import

class CustomizationButtonPage extends StatefulWidget {
  const CustomizationButtonPage({Key? key}) : super(key: key);

  @override
  _CustomizationButtonPageState createState() =>
      _CustomizationButtonPageState();
}

class _CustomizationButtonPageState extends State<CustomizationButtonPage> {
  List<_ButtonItem> _buttonItems = [];
  String? _selectedButton; // Holds the currently selected button

  final List<String> buttonImages = [
    'assets/button1.png',
    'assets/button2.png',
    'assets/button3.png',
    'assets/button4.png',
    'assets/button5.png',
    'assets/button6.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFecd8c6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Back button
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous page
                  },
                ),
                const Text(
                  'Customize Your Dress with Buttons',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTapDown: (details) {
                // Place selected button at the tapped position
                if (_selectedButton != null) {
                  setState(() {
                    _buttonItems.add(_ButtonItem(
                      imagePath: _selectedButton!,
                      position: details.localPosition,
                    ));
                  });
                }
              },
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        'assets/custom_image.jpeg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  for (var buttonItem in _buttonItems)
                    Positioned(
                      left: buttonItem.position.dx - 50, // Center the button
                      top: buttonItem.position.dy - 50,
                      child: GestureDetector(
                        onScaleUpdate: (details) {
                          setState(() {
                            // Move the item using the focal point (for panning)
                            buttonItem.position += details.focalPointDelta;

                            // Scale the button
                            buttonItem.scale *= details.scale;
                            buttonItem.scale = buttonItem.scale.clamp(0.5, 3.0);
                          });
                        },
                        child: Transform.scale(
                          scale: buttonItem.scale,
                          child: Image.asset(
                            buttonItem.imagePath,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: buttonImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Set the selected button image
                      setState(() {
                        _selectedButton = buttonImages[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedButton == buttonImages[index]
                              ? Colors.pinkAccent
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Image.asset(
                        buttonImages[index],
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomizationTasselPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _ButtonItem {
  final String imagePath;
  Offset position;
  double scale;

  _ButtonItem({
    required this.imagePath,
    required this.position,
    this.scale = 1.0,
  });
}
