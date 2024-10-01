// providers/photo_provider.dart

import 'package:flutter/material.dart';
import '../data/api_service.dart';
import '../models/photo.dart';

class PhotoProvider with ChangeNotifier {
  List<Photo> _photos = [];
  bool _isLoading = false;

  List<Photo> get photos => _photos;
  bool get isLoading => _isLoading;

  Future<void> fetchPhotos() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<Photo> fetchedPhotos = await ApiService().fetchPhotos();
      _photos =
          fetchedPhotos.take(10).toList(); // Use take to get the first 10 items
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }
}
