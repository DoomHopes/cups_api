/// User model
class User {
  /// User id
  final int id;

  /// User name
  final String email;

  /// User hash password
  final String passwordHash;

  /// Соль для проверки пароля
  final String salt;

  User({required this.id, required this.email, required this.passwordHash, required this.salt});

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'password': passwordHash};
  }
}
