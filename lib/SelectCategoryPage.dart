import 'dart:io'; // For handling images from local storage (mobile/desktop)
import 'dart:typed_data'; // For handling images from web
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Design_page.dart'; // Import the DesignPage class

class SelectCategoryPage extends StatefulWidget {
  final XFile? imageFile; // Fabric image from mobile/desktop
  final Uint8List? webImage; // Fabric image from web

  const SelectCategoryPage({Key? key, this.imageFile, this.webImage})
      : super(key: key);

  @override
  _SelectCategoryPageState createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  String? _selectedCategory; // Main category (Shalwar or Qameez)
  String? _selectedSubCategory; // Subcategory (e.g., Kurta, Button Down, etc.)

  final List<String> _mainCategories = ['Qameez', 'Shalwar'];

  // Map of subcategories for each main category
  final Map<String, List<String>> _subCategories = {
    'Qameez': ['Kurta', 'Straight Shirt', 'Short Kurti', 'Button Down Shirt'],
    'Shalwar': ['Trouser', 'Palazzo', 'Shalwar', 'Capri', 'Dhoti Shalwar']
  };

  // Function to show subcategory dialog
  void _showSubCategoryDialog(String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select $category Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _subCategories[category]!.map((String subCategory) {
              return ListTile(
                title: Text(subCategory),
                onTap: () {
                  setState(() {
                    _selectedSubCategory = subCategory;
                  });
                  Navigator.of(context).pop(); // Close the dialog
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // Function to handle Generate button click
  void _onGeneratePressed() {
    // Check if both selections are made
    if (_selectedCategory != null && _selectedSubCategory != null) {
      // Navigate to DesignPage without passing parameters
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DesignPage(), // Just call the DesignPage
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both category and subcategory.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: const Color(0xFFecd8c6), // Background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Heading
              const Text(
                "Let's Generate your design",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(height: 20),

              // Show uploaded fabric image
              kIsWeb
                  ? Image.memory(
                      widget.webImage ??
                          Uint8List(0), // Handle null case for web
                      height: screenWidth * 0.5,
                      width: screenWidth * 0.5,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(widget.imageFile?.path ??
                          ''), // Handle null case for mobile/desktop
                      height: screenWidth * 0.5,
                      width: screenWidth * 0.5,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 20),

              // Dropdown for selecting main category (Qameez or Shalwar)
              DropdownButton<String>(
                value: _selectedCategory,
                hint: const Text("Select Category"),
                items: _mainCategories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                    _selectedSubCategory = null; // Reset subcategory selection
                    if (newValue != null) {
                      _showSubCategoryDialog(
                          newValue); // Show subcategory options
                    }
                  });
                },
                isExpanded: true,
                style: const TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Display selected subcategory
              if (_selectedSubCategory != null)
                Text(
                  'Selected: $_selectedSubCategory',
                  style: const TextStyle(fontSize: 16.0),
                ),

              const SizedBox(height: 20),

              // Generate button
              ElevatedButton(
                onPressed: _selectedCategory == null ||
                        _selectedSubCategory == null
                    ? null // Disable if no category or subcategory is selected
                    : _onGeneratePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  minimumSize: Size(screenWidth * 0.5, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  "Generate",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
