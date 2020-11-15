import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:CrudComidas/model/comida.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

 void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE comida(id INTEGER PRIMARY KEY,nome TEXT, tipo TEXT, calorias TEXT, preco TEXT)');
  }

  Future<int> inserirComida(Comida comida) async {
    var dbClient = await db;
    var result = await dbClient.insert("comida", comida.toMap());

    return result;
  }

  Future<List> getComidas() async {
    var dbClient = await db;
    var result = await dbClient.query("comida", columns: ["id", "nome", "tipo", "calorias", "preco"]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM comida'));
  }
Future<Comida> getComida(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("comida",
        columns: ["id", "nome", "tipo", "calorias", "preco"], where: 'ide = ?', whereArgs: [id]);
    if (result.length > 0) {
      return new Comida.fromMap(result.first);
    }
    return null;
  }
Future<int> deleteComida(int id) async {
    var dbClient = await db;
    return await dbClient.delete("comida", where: 'id = ?', whereArgs: [id]);
  }
Future<int> updateComida(Comida comida) async {
    var dbClient = await db;
    return await dbClient.update("comida", comida.toMap(),
        where: "id = ?", whereArgs: [comida.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
