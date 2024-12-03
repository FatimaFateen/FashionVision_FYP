import 'package:flutter/material.dart';

class CustomizationTasselPage extends StatefulWidget {
  const CustomizationTasselPage({Key? key}) : super(key: key);

  @override
  _CustomizationTasselPageState createState() =>
      _CustomizationTasselPageState();
}

class _CustomizationTasselPageState extends State<CustomizationTasselPage> {
  List<_TasselItem> _tasselItems = []; // List to store added tassel items
  String? _selectedTassel; // Currently selected tassel

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Back button and title
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
                  'Customize Your Dress with Tassels',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Dress container with click-to-place area
          Expanded(
            child: GestureDetector(
              onTapDown: (details) {
                // Place selected tassel at the tapped position
                if (_selectedTassel != null) {
                  setState(() {
                    _tasselItems.add(_TasselItem(
                      imagePath: _selectedTassel!,
                      position: details.localPosition,
                    ));
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/custom_image.jpeg', // Dress image
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Display all placed tassels
                  for (var tasselItem in _tasselItems)
                    Positioned(
                      left: tasselItem.position.dx - 25, // Center the tassel
                      top: tasselItem.position.dy - 25,
                      child: Image.asset(
                        tasselItem.imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title for the tassels
          const Text(
            'Select a Tassel to Customize',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // Horizontal list of tassel images for selection
          Container(
            height: 80, // Height for the tassel images
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildSelectableTassel('assets/tassel1.png'),
                _buildSelectableTassel('assets/tassel2.png'),
                _buildSelectableTassel('assets/tassel3.png'),
                _buildSelectableTassel('assets/tassel4.png'),
                _buildSelectableTassel('assets/tassel5.png'),
                _buildSelectableTassel('assets/tassel6.png'),
                _buildSelectableTassel('assets/tassel7.png'),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Build tappable tassel items for selection
  Widget _buildSelectableTassel(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTassel = imagePath; // Set the selected tassel
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _selectedTassel == imagePath
                  ? Colors.pinkAccent
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
          child: Image.asset(
            imagePath,
            width: 50, // Size of the static tassel
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

// Class to represent each tassel item (with position)
class _TasselItem {
  final String imagePath;
  Offset position;

  _TasselItem({
    required this.imagePath,
    required this.position,
  });
}
