// data/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

class ApiService {
  static const String apiUrl =
      'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos';
  static const String apiKey = 'DEMO_KEY';

  Future<List<Photo>> fetchPhotos() async {
    final response =
        await http.get(Uri.parse('$apiUrl?sol=1000&api_key=$apiKey'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['photos'];
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
