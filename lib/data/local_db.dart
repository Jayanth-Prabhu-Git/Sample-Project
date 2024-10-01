// data/local_db.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class LocalDB {
  static Future<Database> get _initMobileDB async {
    String path = join(await getDatabasesPath(), 'users.db');
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          password TEXT
        )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> createUser(String username, String password) async {
    if (Platform.isAndroid || Platform.isIOS) {
      final db = await _initMobileDB;
      await db.insert('users', {'username': username, 'password': password});
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(username, password);
    }
  }

  static Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    if (Platform.isAndroid || Platform.isIOS) {
      final db = await _initMobileDB;
      final res = await db.query('users',
          where: 'username = ? AND password = ?',
          whereArgs: [username, password]);
      if (res.isNotEmpty) {
        return res.first;
      }
    } else {
      final prefs = await SharedPreferences.getInstance();
      final storedPassword = prefs.getString(username);
      if (storedPassword == password) {
        return {'username': username, 'password': password};
      }
    }
    return null;
  }

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final db = await _initMobileDB;
      return await db.query('users');
    } else {
      final prefs = await SharedPreferences.getInstance();
      final users = prefs
          .getKeys()
          .map((key) => {'username': key, 'password': prefs.getString(key)})
          .toList();
      return users;
    }
  }
}
