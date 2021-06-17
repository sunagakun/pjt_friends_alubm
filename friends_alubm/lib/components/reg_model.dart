import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reg_model.freezed.dart';
part 'reg_model.g.dart';

//
// コードジェネレータよるコード生成
// カスタムオブジェクトの比較及びtoJson/fromJsonメソッドの自動生成
//
// 再生成する場合は下記コマンド
// flutter pub run build_runner build
//

@freezed
abstract class Reg with _$Reg {
  //
  @JsonSerializable(includeIfNull: false)
  const factory Reg({
    int id,
    @ImageConverter() Uint8List image,
    String nickname,
    String sei,
    String birthday,
    String rel,
    String episode,
  }) = _Reg;

  factory Reg.fromJson(Map<String, dynamic> json) => _$RegFromJson(json);
}

//
// Uint8ListがJsonでは無いのでコード生成で問題が起きないようにする回避策
//
class ImageConverter implements JsonConverter<Uint8List, Uint8List> {
  //
  const ImageConverter();

  @override
  Uint8List fromJson(Uint8List json) => json;

  @override
  Uint8List toJson(Uint8List object) => object;
}
