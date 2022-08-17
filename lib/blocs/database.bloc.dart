import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech/blocs/database.state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseBloc extends Cubit<DatabaseState> {
  DatabaseBloc() : super(InitDatabaseState());

  Database? database;

  Future<void> initDatabase() async {
    final databasePath = await getDatabasesPath();
    // print(databasePath);
    final path = join(databasePath, 'products.db');
    if (await Directory(dirname(path)).exists()) {
      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE products (id INTEGER PRIMARY KEY, slug TEXT,title TEXT,description TEXT, price INTEGER,featured_image TEXT,status TEXT, created_at TEXT)');
        await db.execute(
            'CREATE TABLE cart (id INTEGER PRIMARY KEY, slug TEXT,title TEXT,description TEXT, price INTEGER,featured_image TEXT,status TEXT, created_at TEXT)');
      });

      emit(LoadDatabaseState());
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
        database = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE products (id INTEGER PRIMARY KEY, slug TEXT,title TEXT,description TEXT, price INTEGER,featured_image TEXT,status TEXT, created_at TEXT)');
          await db.execute(
              'CREATE TABLE cart (id INTEGER PRIMARY KEY, slug TEXT,title TEXT,description TEXT, price INTEGER,featured_image TEXT,status TEXT, created_at TEXT)');
        });
        emit(LoadDatabaseState());
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
