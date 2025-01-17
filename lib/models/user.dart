// models/user.dart

class User {
  final int? id;
  final String username;
  final String password;

  User({this.id, required this.username, required this.password});

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        password: json['password'],
      );
}
