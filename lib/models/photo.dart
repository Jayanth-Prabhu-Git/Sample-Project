// models/photo_model.dart

class Photo {
  final String id;
  final String imageUrl;

  Photo({required this.id, required this.imageUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'].toString(),
      imageUrl: json['img_src'],
    );
  }
}
