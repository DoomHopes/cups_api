import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

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

void main() {
  group('GET /', () {
    test('responds with a 200 and "Welcome to Dart Frog!".', () {
      final context = _MockRequestContext();
      final response = route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.body(),
        completion(equals('Welcome to Dart Frog!')),
      );
    });
  });

  group('Email validation', () {
    test('Valid email returns true', () {
      expect(emailValidate('test@mail.com'), isTrue);
    });
    test('Invalid email returns false', () {
      expect(emailValidate('testmail.com'), isFalse);
      expect(emailValidate(''), isFalse);
    });
  });

  group('Void checking', () {
    test('Non-empty email and password returns true', () {
      expect(checkingForTheVoid('a', 'b'), isTrue);
    });
    test('Empty email returns false', () {
      expect(checkingForTheVoid('', 'b'), isFalse);
    });
    test('Empty password returns false', () {
      expect(checkingForTheVoid('a', ''), isFalse);
    });
  });

  group('Password checking', () {
    test('Password length >= 8 returns true', () {
      expect(passwordChecking('12345678'), isTrue);
    });
    test('Password length < 8 returns false', () {
      expect(passwordChecking('1234567'), isFalse);
    });
  });
}
