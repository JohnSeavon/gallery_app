import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final StreamController<List<String>> imageUrlsController;

  final VoidCallback shouldLogOut;

  final VoidCallback shouldShowCamera;

  const GalleryPage({
    required this.imageUrlsController,
    required this.shouldLogOut,
    required this.shouldShowCamera,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
    return StreamBuilder(
      stream: imageUrlsController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: snapshot.data![index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No images to display.'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
