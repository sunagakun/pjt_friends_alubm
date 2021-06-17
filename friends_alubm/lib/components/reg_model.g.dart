// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reg_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Reg _$_$_RegFromJson(Map<String, dynamic> json) {
  return _$_Reg(
    id: json['id'] as int,
    image: const ImageConverter().fromJson(json['image'] as Uint8List),
    nickname: json['nickname'] as String,
    sei: json['sei'] as String,
    birthday: json['birthday'] as String,
    rel: json['rel'] as String,
    episode: json['episode'] as String,
    // birthday: json['birthday'] == null
    //     ? null
    //     : DateTime.parse(json['birthday'] as String),
  );
}

Map<String, dynamic> _$_$_RegToJson(_$_Reg instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('image', const ImageConverter().toJson(instance.image));
  writeNotNull('nickname', instance.nickname);
  writeNotNull('sei', instance.sei);
  writeNotNull('birthday', instance.birthday);
  writeNotNull('rel', instance.rel);
  writeNotNull('episode', instance.episode);
  // writeNotNull('birthday', instance.birthday?.toIso8601String());
  return val;
}
