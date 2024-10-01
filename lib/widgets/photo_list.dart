// widgets/photo_list.dart

import 'package:flutter/material.dart';
import '../models/photo.dart';

class PhotoList extends StatelessWidget {
  final List<Photo> photos;

  const PhotoList({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: photos.length,
      itemBuilder: (ctx, i) {
        return GridTile(
          child: Image.network(photos[i].imageUrl, fit: BoxFit.cover),
        );
      },
    );
  }
}
