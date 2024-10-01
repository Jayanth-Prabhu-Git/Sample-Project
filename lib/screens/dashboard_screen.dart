// screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/photo_provider.dart';
import '../widgets/photo_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch photos when the DashboardScreen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PhotoProvider>(context, listen: false).fetchPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NASA Photos')),
      body: Consumer<PhotoProvider>(
        builder: (context, photoProvider, child) {
          return photoProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : PhotoList(photos: photoProvider.photos);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).pushNamed('/users');
        },
        child: const Icon(Icons.people),
      ),
    );
  }
}
