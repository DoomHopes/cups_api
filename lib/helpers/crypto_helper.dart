import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:crypto/crypto.dart';

/// метод для получения hash пароля
String hashSHA256(String password) {
  return sha256.convert(utf8.encode(password)).toString();
}

/// создание пароля [соль, пароль]
List<String> bcryptPassword(String password) {
  final salt = BCrypt.gensalt(logRounds: 12);
  final hashedPassword = BCrypt.hashpw(password, salt);

  return [salt, hashedPassword];
}

/// проверка пароля
bool bcryptIsValid(String password, String salt) {
  final hashedPassword = BCrypt.hashpw(password, salt);

  return BCrypt.checkpw(password, hashedPassword);
}
