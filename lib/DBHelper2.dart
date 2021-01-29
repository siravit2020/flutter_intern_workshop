import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'employee.dart';

class DBHelper2 {
  static Database _db;
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String MESSAGE = 'message';
  static const String DATE = 'date';
  static const String TABLE = 'Note';
  static const String DB_NAME = 'note.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $TITLE TEXT, $MESSAGE TEXT,  $DATE TEXT)");
  }

  Future<Note> save(Note note) async {
    var dbClient = await db;
    note.id = await dbClient.insert(TABLE, note.toMap());
    return note;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<Note>> getNotes() async {
    var dbClient = await db;
    List<Map> maps =
        await dbClient.query(TABLE, columns: [ID, TITLE, MESSAGE, DATE]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Note> note = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        note.add(Note.fromMap(maps[i]));
      }
    }
    return note;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Note note) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, note.toMap(),
        where: '$ID = ?', whereArgs: [note.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
