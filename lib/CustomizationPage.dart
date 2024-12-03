import 'package:flutter/material.dart';
import 'customization_button.dart'; // Import the CustomizationButtonPage

class CustomizationPage extends StatefulWidget {
  const CustomizationPage({Key? key}) : super(key: key);

  @override
  _CustomizationPageState createState() => _CustomizationPageState();
}

class _CustomizationPageState extends State<CustomizationPage> {
  List<_LaceItem> _laceItems = []; // List to store added lace items
  String? _selectedLace; // Currently selected lace to place on click

  // Lace images list (7 laces)
  final List<String> laceImages = [
    'assets/lace1.png',
    'assets/lace2.png',
    'assets/lace3.png',
    'assets/lace4.png',
    'assets/lace5.png',
    'assets/lace6.png',
    'assets/lace7.png',
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double containerHeight = screenSize.height *
        0.6; // Dress container height (60% of screen height)
    final double containerWidth =
        screenSize.width * 0.8; // Dress container width (80% of screen width)

    return Scaffold(
      backgroundColor: const Color(0xFFecd8c6), // Background color #ecd8c6
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Back button and title
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.black), // Changed to black
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous page
                  },
                ),
                const SizedBox(width: 10), // Spacing between arrow and title
                const Text(
                  'Customize Your Dress with Laces',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20), // Space between title and dress container

          // Dress container with onClick functionality
          Expanded(
            child: GestureDetector(
              onTapDown: (TapDownDetails details) {
                // Only place a lace if one is selected
                if (_selectedLace != null) {
                  setState(() {
                    _laceItems.add(_LaceItem(
                      imagePath: _selectedLace!,
                      position: details.localPosition -
                          const Offset(50, 50), // Center the lace
                    ));
                    _selectedLace = null; // Reset after placing
                  });
                }
              },
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: containerWidth,
                      height: containerHeight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        'assets/custom_image.jpeg', // Dress image
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Display all laces that have been added
                  for (var laceItem in _laceItems)
                    Positioned(
                      left: laceItem.position.dx,
                      top: laceItem.position.dy,
                      child: GestureDetector(
                        onScaleUpdate: (details) {
                          setState(() {
                            // Update the lace position and scale together
                            laceItem.position += details.focalPointDelta;
                            laceItem.scale = laceItem.scale * details.scale;
                          });
                        },
                        child: Transform.scale(
                          scale: laceItem.scale,
                          child: Image.asset(
                            laceItem.imagePath,
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

          const SizedBox(height: 10), // Adjust the height here if needed

          // Horizontal list of lace images (with 7 items)
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: laceImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Set the selected lace when an image is clicked
                      setState(() {
                        _selectedLace = laceImages[index];
                      });
                    },
                    child: Image.asset(
                      laceImages[index],
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                      color: _selectedLace == laceImages[index]
                          ? Colors.grey.withOpacity(0.5)
                          : null, // Show indication when lace is selected
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10), // Further reduce height here

          // Next button to navigate to CustomizationButtonPage
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomizationButtonPage()),
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
        ],
      ),
    );
  }
}

// Class to represent each lace item (with position and scale)
class _LaceItem {
  final String imagePath;
  Offset position;
  double scale;

  _LaceItem({
    required this.imagePath,
    required this.position,
    this.scale = 1.0, // Default scale is 1.0
  });
}
