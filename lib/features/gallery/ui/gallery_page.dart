import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final VoidCallback shouldLogOut;

  final VoidCallback shouldShowCamera;

  const GalleryPage({
    required this.shouldLogOut,
    required this.shouldShowCamera,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: shouldLogOut,
              child: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: shouldShowCamera,
        child: const Icon(Icons.camera_alt),
      ),
      body: Container(
        child: _galleryGrid(),
      ),
    );
  }

  Widget _galleryGrid() {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 3,
        itemBuilder: (context, index) {
          return const Placeholder();
        });
  }
}
