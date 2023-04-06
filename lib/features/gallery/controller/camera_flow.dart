import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/features/gallery/services/storage_service.dart';
import 'package:gallery_app/features/gallery/ui/camera_page.dart';
import 'package:gallery_app/features/gallery/ui/gallery_page.dart';

class CameraFlow extends StatefulWidget {
  final VoidCallback shouldLogOut;

  const CameraFlow({required this.shouldLogOut, super.key});

  @override
  State<StatefulWidget> createState() => _CameraFlowState();
}

class _CameraFlowState extends State<CameraFlow> {
  late CameraDescription _camera;

  bool _shouldShowCamera = false;

  late StorageService _storageService;

  List<MaterialPage> get _pages {
    return [
      MaterialPage(
        child: GalleryPage(
          imageUrlsController: _storageService.imageUrlsController,
          shouldLogOut: widget.shouldLogOut,
          shouldShowCamera: () => _toggleCameraOpen(true),
        ),
      ),
      if (_shouldShowCamera)
        MaterialPage(
          child: CameraPage(
            camera: _camera,
            didProvideImagePath: (imagePath) {
              _toggleCameraOpen(false);
              _storageService.uploadImageAtPath(imagePath);
            },
          ),
        ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _getCamera();
    _storageService = StorageService();
    _storageService.getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: _pages,
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  void _toggleCameraOpen(bool isOpen) {
    setState(() {
      _shouldShowCamera = isOpen;
    });
  }

  void _getCamera() async {
    final camerasList = await availableCameras();
    setState(() {
      final firstCamera = camerasList.first;
      _camera = firstCamera;
    });
  }
}
