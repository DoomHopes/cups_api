import 'package:cups_api/services/user_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

void main() {
  late Database db;
  late UserService userService;

  setUpAll(() async {
    // Инициализация FFI для SQLite
    sqfliteFfiInit();

    // Создание in-memory базы
    db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE user (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              email TEXT,
              hash_password TEXT,
              salt TEXT
            )
          ''');
        },
      ),
    );

    userService = UserService();
  });

  tearDownAll(() async {
    await db.close();
  });

  test('Create and fetch user', () async {
    final id = await userService.createUser(db, 'test@mail.com', 'hash', 'salt');
    expect(id, greaterThan(0));

    final user = await userService.getUserById(db, id);
    expect(user, isNotNull);
    expect(user!['email'], equals('test@mail.com'));
    expect(user['hash_password'], equals('hash'));
    expect(user['salt'], equals('salt'));
  });
}
