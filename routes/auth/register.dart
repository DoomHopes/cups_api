// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'package:cups_api/helpers/crypto_helper.dart';
import 'package:cups_api/services/db_service.dart';
import 'package:cups_api/services/user_service.dart';
import 'package:dart_frog/dart_frog.dart';

bool emailValidate(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

bool checkingForTheVoid(String email, String password) {
  if (email.isEmpty || password.isEmpty) {
    return false;
  }

  return true;
}

bool passwordChecking(String password) {
  if (password.length < 8) {
    return false;
  }

  return true;
}

Future<int> register(String email, String password) async {
  final db = await DBProvider.db.database;
  UserService userService = UserService();

  List<String> passwordData = bcryptPassword(password);

  String salt = passwordData[0];
  String passwordHash = passwordData[1];

  return userService.createUser(db, email, passwordHash, salt);
}

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: 405, body: 'Method Not Allowed');
  }

  final body = await context.request.body();
  final data = jsonDecode(body);

  final email = data['email'] as String;
  final password = data['password'] as String;

  if (checkingForTheVoid(email, password)) {
    return Response.json(body: {'message': 'email and password are required'});
  }

  if (passwordChecking(password)) {
    return Response.json(body: {'message': 'The password is very short'});
  }

  if (emailValidate(email) == false) {
    return Response.json(body: {'message': 'The email is not valid'});
  }

  try {
    int id = await register(email, password);

    return Response.json(body: {'message': 'User ($id) registered successfully'});
  } catch (e) {
    return Response.json(body: {'message': e});
  }
}
