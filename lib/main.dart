// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_info/screens/dashboard_screen.dart';
import 'package:user_info/screens/login_screen.dart';
import 'package:user_info/screens/user_list_screen.dart';
import './providers/auth_provider.dart';
import './providers/photo_provider.dart';
import './utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('isLoggedIn');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PhotoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User Info',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: isLoggedIn(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return snapshot.data == true
                  ? const DashboardScreen()
                  : const LoginScreen();
            }
          },
        ),
        routes: {
          AppRoutes.dashboard: (ctx) => const DashboardScreen(),
          AppRoutes.login: (ctx) => const LoginScreen(),
          AppRoutes.users: (ctx) => const UserListScreen(),
        },
      ),
    );
  }
}
