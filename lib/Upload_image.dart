import 'dart:io'; // Only needed for mobile/desktop
import 'dart:typed_data'; // Needed for web
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'SelectCategoryPage.dart'; // Import the second page

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  Uint8List? _webImage; // For storing image bytes in web

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      if (kIsWeb) {
        // Handle web: Convert picked image to bytes
        final webImageBytes = await pickedFile.readAsBytes();
        setState(() {
          _webImage = webImageBytes;
          _imageFile = pickedFile;
        });
      } else {
        // Handle mobile/desktop
        setState(() {
          _imageFile = pickedFile;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    final double imagePreviewSize = screenWidth * 0.5; // Image preview size
    final double buttonWidth = screenWidth * 0.4;
    final double buttonHeight = screenHeight * 0.07;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/baby pink.png', // Background image
              fit: BoxFit.cover,
            ),
          ),
          // Upload image options
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Image preview
                    _imageFile == null
                        ? const Text('No image selected.')
                        : kIsWeb
                            ? Image.memory(
                                _webImage!,
                                height: imagePreviewSize,
                                width: imagePreviewSize,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(_imageFile!.path),
                                height: imagePreviewSize,
                                width: imagePreviewSize,
                                fit: BoxFit.cover,
                              ),
                    const SizedBox(height: 20),
                    // Buttons to select image
                    Wrap(
                      spacing: 20.0,
                      runSpacing: 20.0,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          icon: const Icon(Icons.image, color: Colors.white),
                          label: const Text(
                            'Select from Gallery',
                            style: TextStyle(
                                color: Colors.white), // Set text color to white
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            minimumSize: Size(buttonWidth, buttonHeight),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.camera),
                          icon:
                              const Icon(Icons.camera_alt, color: Colors.white),
                          label: const Text(
                            'Capture with Camera',
                            style: TextStyle(
                                color: Colors.white), // Set text color to white
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            minimumSize: Size(buttonWidth, buttonHeight),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Submit button to go to SelectCategoryPage
                    ElevatedButton(
                      onPressed: _imageFile == null && _webImage == null
                          ? null
                          : () {
                              // Navigate to SelectCategoryPage with the selected image
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectCategoryPage(
                                    imageFile:
                                        _imageFile, // Pass the selected image
                                    webImage:
                                        _webImage, // Pass web image for web platform
                                  ),
                                ),
                              );
                            },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white), // Set text color to white
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        minimumSize: Size(buttonWidth, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
