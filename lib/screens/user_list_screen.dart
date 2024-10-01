// screens/user_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_info/utils/app_routes.dart';
import '../providers/auth_provider.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
        actions: [
          IconButton(
            icon: const Row(
              children: [
                Text('Logout'),
                SizedBox(width: 5),
                Icon(Icons.logout),
              ],
            ),
            onPressed: () {
              // Call the logout method and navigate to login screen
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<AuthProvider>(context, listen: false).getAllUsers(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching users'));
          } else {
            final users = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (ctx, i) => Container(
                margin: const EdgeInsets.only(bottom: 2),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Colors.blue,
                child: Text(
                  users[i]['username'],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
