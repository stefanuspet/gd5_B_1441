import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  //createDb
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
    CREATE TABLE employee(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      email TEXT,
      address TEXT
    )
    """);
  }

  //call DB
  static Future<sql.Database> db() async {
    return sql.openDatabase('employee.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  //add Employee
  static Future<int> addEmployee(String name, String email, String address) async {
    final db = await SQLHelper.db();
    final data = {'name': name, 'email': email, 'address': address};
    return await db.insert('employee', data);
  }

  //read Employee
  static Future<List<Map<String, dynamic>>> getEmployee() async {
    final db = await SQLHelper.db();
    return db.query('employee');
  }

  //edit Employee
  static Future<int> editEmployee(int id, String name, String email, String address) async {
    final db = await SQLHelper.db();
    final data = {'name': name, 'email': email, 'address': address};
    return await db.update('employee', data, where: 'id = $id');
  }

  //delete Employee
  static Future<int> deleteEmployee(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('employee', where: 'id = $id');
  }
}
