import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await openMyDatabase();
    return _database!;
  }

  Future<Database> openMyDatabase() async {
    final path = join(Directory.current.path, 'db', 'cups_db.db');
    final database = await openDatabase(path);
    return database;
  }
}
