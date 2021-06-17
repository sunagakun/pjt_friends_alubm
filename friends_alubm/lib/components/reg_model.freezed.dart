// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'reg_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Reg _$RegFromJson(Map<String, dynamic> json) {
  return _Reg.fromJson(json);
}

/// @nodoc
class _$RegTearOff {
  const _$RegTearOff();

// ignore: unused_element
  _Reg call(
      {int id,
      @ImageConverter() Uint8List image,
        String nickname,
        String sei,
        String birthday,
        String rel,
        String episode,
      }) {
    return _Reg(
      id: id,
      image: image,
      nickname: nickname,
      sei: sei,
      birthday: birthday,
      rel: rel,
      episode: episode,
    );
  }

// ignore: unused_element
  Reg fromJson(Map<String, Object> json) {
    return Reg.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Reg = _$RegTearOff();

/// @nodoc
mixin _$Reg {
  int get id;
  @ImageConverter()
  Uint8List get image;
  String get nickname;
  String get sei;
  String get birthday;
  String get rel;
  String get episode;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $RegCopyWith<Reg> get copyWith;
}

/// @nodoc
abstract class $RegCopyWith<$Res> {
  factory $RegCopyWith(Reg value, $Res Function(Reg) then) =
      _$RegCopyWithImpl<$Res>;
  $Res call(
      {int id,
      @ImageConverter() Uint8List image,
        String nickname,
        String sei,
        String birthday,
        String rel,
        String episode,
      });
}

/// @nodoc
class _$RegCopyWithImpl<$Res> implements $RegCopyWith<$Res> {
  _$RegCopyWithImpl(this._value, this._then);

  final Reg _value;
  // ignore: unused_field
  final $Res Function(Reg) _then;

  @override
  $Res call({
    Object id = freezed,
    Object image = freezed,
    Object nickname = freezed,
    Object sei = freezed,
    Object birthday = freezed,
    Object rel = freezed,
    Object episode = freezed,

  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      image: image == freezed ? _value.image : image as Uint8List,
      nickname: nickname == freezed ? _value.nickname : nickname as String,
      sei: sei == freezed ? _value.sei : sei as String,
      birthday: birthday == freezed ? _value.birthday : birthday as String,
      rel: rel == freezed ? _value.rel : rel as String,
      episode: episode == freezed ? _value.episode : episode as String,
    ));
  }
}

/// @nodoc
abstract class _$RegCopyWith<$Res> implements $RegCopyWith<$Res> {
  factory _$RegCopyWith(_Reg value, $Res Function(_Reg) then) =
      __$RegCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      @ImageConverter() Uint8List image,
        String nickname,
        String sei,
        String birthday,
        String rel,
        String episode,
      });
}

/// @nodoc
class __$RegCopyWithImpl<$Res> extends _$RegCopyWithImpl<$Res>
    implements _$RegCopyWith<$Res> {
  __$RegCopyWithImpl(_Reg _value, $Res Function(_Reg) _then)
      : super(_value, (v) => _then(v as _Reg));

  @override
  _Reg get _value => super._value as _Reg;

  @override
  $Res call({
    Object id = freezed,
    Object image = freezed,
    Object nickname = freezed,
    Object sei = freezed,
    Object birthday = freezed,
    Object rel = freezed,
    Object episode = freezed,
  }) {
    return _then(_Reg(
      id: id == freezed ? _value.id : id as int,
      image: image == freezed ? _value.image : image as Uint8List,
      nickname: nickname == freezed ? _value.nickname : nickname as String,
      sei: sei == freezed ? _value.sei : sei as String,
      birthday: birthday == freezed ? _value.birthday : birthday as String,
      rel: rel == freezed ? _value.rel : rel as String,
      episode: episode == freezed ? _value.episode : episode as String,

    ));
  }
}

@JsonSerializable(includeIfNull: false)

/// @nodoc
class _$_Reg implements _Reg {
  const _$_Reg(
      {this.id,
      @ImageConverter() this.image,
      this.nickname,
        this.sei,
        this.birthday,
        this.rel,
      this.episode,
      });

  factory _$_Reg.fromJson(Map<String, dynamic> json) => _$_$_RegFromJson(json);

  @override
  final int id;
  @override
  @ImageConverter()
  final Uint8List image;
  @override
  final String nickname;
  @override
  final String sei;
  @override
  final String birthday;
  @override
  final String rel;
  @override
  final String episode;

  @override
  String toString() {
    return 'Reg(id: $id, image: $image, nickname: $nickname,sei: $sei, birthday: $birthday, rel: $rel, episode: $episode,)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Reg &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(other.nickname, nickname)) &&
            (identical(other.sei, sei) ||
                const DeepCollectionEquality()
                    .equals(other.sei, sei)) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality()
                    .equals(other.birthday, birthday)) &&
            (identical(other.rel, rel) ||
                const DeepCollectionEquality().equals(other.rel, rel)) &&
            (identical(other.episode, episode) ||
                const DeepCollectionEquality().equals(other.episode, episode))
            );
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(sei) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(rel) ^
      const DeepCollectionEquality().hash(episode);

  @JsonKey(ignore: true)
  @override
  _$RegCopyWith<_Reg> get copyWith =>
      __$RegCopyWithImpl<_Reg>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RegToJson(this);
  }
}

abstract class _Reg implements Reg {
  const factory _Reg(
      {int id,
      @ImageConverter() Uint8List image,
      String nickname,
        String sei,
        String birthday,
        String rel,
      String episode,
      }) = _$_Reg;

  factory _Reg.fromJson(Map<String, dynamic> json) = _$_Reg.fromJson;

  @override
  int get id;
  @override
  @ImageConverter()
  Uint8List get image;
  @override
  String get nickname;
  @override
  String get sei;
  @override
  String get birthday;
  @override
  String get rel;
  @override
  String get episode;
  @override
  @JsonKey(ignore: true)
  _$RegCopyWith<_Reg> get copyWith;
}
