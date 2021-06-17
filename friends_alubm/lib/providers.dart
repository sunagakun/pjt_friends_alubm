//
//
//

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_alubm/components/database_helper.dart';
import 'package:friends_alubm/components/reg_model.dart';

//
// データベースヘルパー自体のプロバイダー
//
final databaseProvider = Provider((ref) => DatabaseHelper());

//
// Listでも良いが、Mapとしてデータを保持
//
class RegObjectsCtrl extends StateNotifier<Map<int, Reg>> {
  //
  final Reader _read;
  RegObjectsCtrl(this._read) : super({});

  //
  // 初期データ読み込み用
  //
  void loadFromList(List<Reg> objects) => state = Map.fromIterable(
        objects,
        key: (e) => e.id,
        value: (e) => e,
      );

  //
  // 保存か新規登録
  //
  Future<void> update(Reg reg) async {
    //
    // 先にDBを更新してIDを取得する（Insertだった場合）
    //
    final id = await _read(databaseProvider).updateOrInsertReg(reg);

    //
    // IDを保証したオブジェクトを作り直す
    // Insertだった場合SQLITEによってIDが付与されるため
    //
    final newReg = reg.copyWith(id: id);

    //
    // メモリ内を更新
    //
    state = {
      ...state,
      newReg.id: newReg,
    };
  }

  Future<void> deleteById(int id) async {
    //
    state = state..removeWhere((key, value) => value.id == id);
    await _read(databaseProvider).deleteReg(id);
  }
}

final regObjectsCtrlProvider = StateNotifierProvider((ref) => RegObjectsCtrl(ref.read));

//
// 起動関連の処理を書くプロバイダー
//
final bootProvider = FutureProvider<void>((ref) async {
  //
  // 起動時の処理
  //

  //
  // DBの初期化はここでしておく
  //
  await ref.read(databaseProvider).initDb();

  //
  // 初期データ読み込み
  //
  final list = await ref.read(databaseProvider).getRegList();
  ref.read(regObjectsCtrlProvider).loadFromList(list);

  return;
});

//
// 一覧表示用にRegのListをプロバイドする
//
final regListProvider = Provider<List<Reg>>((ref) => ref.watch(regObjectsCtrlProvider.state).values.toList());

//
// １つだけのRegをプロバイドする
//
final singleRegProvider = Provider.family<Reg, int>((ref, regId) => ref.watch(regObjectsCtrlProvider.state)[regId]);
