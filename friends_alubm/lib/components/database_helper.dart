import 'dart:io';

import 'package:friends_alubm/components/reg_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //
  //
  // シングルトンはあまり推奨されない設計
  // static final DatabaseHelper instance = DatabaseHelper();
  Database _db;

  // DatabaseHelper._instance();

  String regTable = 'reg_table';
  String colId = 'id';
  String colImage = 'image';
  String colNickname = 'nickname';
  String colSei = 'sei';
  String colBirthday = 'birthday';
  String colRel = 'rel';
  String colEpisode = 'episode';


  // Future<Database> get db async {
  //   if (_db == null) {
  //     _db = await _initDb();
  //   }
  //   return _db;
  // }

  //
  // 事前に initDb()　コールするのを必須な設計にする
  //
  Future<void> initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'reg_friends.db';
    // await deleteDatabase(path); // 毎回初期化 (DEBUG)
    _db = await openDatabase(path, version: 1, onCreate: _createDb);
    // _db.delete(table)
    // return regFriendsDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $regTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colImage BLOB, $colNickname TEXT,$colSei TEXT,$colBirthday TEXT, $colRel TEXT,$colEpisode TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> getRegMapList() async {
    // Database db = await this.db;
    final List<Map<String, dynamic>> result = await _db.query(regTable);
    return result;
  }

  Future<List<Reg>> getRegList() async {
    final List<Map<String, dynamic>> regMapList = await getRegMapList();
    final List<Reg> regList = [];
    regMapList.forEach((regMap) {
      regList.add(Reg.fromJson(regMap));
    });
    regList.sort((regA, regB) => regA.nickname.compareTo(regB.nickname)); //何でソートするか決める
    return regList;
  }

  Future<int> deleteReg(int id) => _db.delete(
        regTable,
        where: '$colId = ?',
        whereArgs: [id],
      );

  //
  // Update OR Insert
  //
  Future<int> updateOrInsertReg(Reg reg) => _db.insert(
        regTable,
        reg.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace, // IDが重複していたらUpdate
      );
}
