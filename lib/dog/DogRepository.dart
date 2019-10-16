import 'package:flutter_sqlite/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'Dog.dart';

class DogRepository {
  static final _table = "dogs";

  DogRepository._privateConstructor();

  static final instance = DogRepository._privateConstructor();

  Future<Database> get database async {
    return DatabaseHelper.instance.database;
  }

  Future<void> insertDog(Dog dog) async {
    Database db = await database;
    await db.insert(
      _table,
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dog>> dogs() async {
    Database db = await database;
    final List<Map<String, dynamic>> dogMaps = await db.query(_table);
    return List.generate(dogMaps.length, (int i) {
      return Dog(
        id: dogMaps[i]['id'],
        name: dogMaps[i]['name'],
        age: dogMaps[i]['age'],
      );
    });
  }

  Future<void> updateDog(Dog dog) async {
    final db = await database;
    await db.update(
      _table,
      dog.toMap(),
      where: "id = ?",
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int dogId) async {
    final db = await database;
    await db.delete(
      _table,
      where: "id = ?",
      whereArgs: [dogId],
    );
  }
}
