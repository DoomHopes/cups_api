import 'package:sqflite/sqflite.dart';

/// Сервис для работы с юзером
class UserService {

  /// Вставляет новую запись и возвращает id созданного пользователя
  Future<int> createUser(Database db, String email, String hashPassword, String salt) async {
    final data = {
      'email': email,
      'hash_password': hashPassword,
      'salt': salt,
    };
    return db.insert('user', data);
  }

  /// Если пользователь найден, возвращает Map с его данными, иначе null
  Future<Map<String, dynamic>?> getUserById(Database db, int id) async {
    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
