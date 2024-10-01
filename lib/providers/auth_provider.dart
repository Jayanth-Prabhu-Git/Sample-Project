// lib/providers/auth_provider.dart

import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  Future<void> signup(String username, String password) async {
    final user = {'username': username, 'password': password};
    await DBHelper.insertUser(user);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true); // Set login state
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    final users = await DBHelper.getUsers();
    for (var user in users) {
      if (user['username'] == username && user['password'] == password) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true); // Set login state
        notifyListeners();
        return; // Successful login
      }
    }
    throw Exception('Invalid username or password');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Clear login state
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    return await DBHelper.getUsers();
  }
}
