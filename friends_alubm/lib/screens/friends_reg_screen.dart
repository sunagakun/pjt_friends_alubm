import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:friends_alubm/components/reg_model.dart';
import 'package:friends_alubm/providers.dart';
import 'package:friends_alubm/router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// part 'friends_reg_screen.freezed.dart';

//
// 状態
//
// @freezed
// abstract class AddEditScreenCtrlState with _$AddEditScreenCtrlState {
//   //
//   const factory AddEditScreenCtrlState({
//     String sei,
//     String mei,
//     Uint8List image,
//   }) = _AddEditScreenCtrlState;
// }

//
// コントローラー
//
class AddEditScreenCtrl extends StateNotifier<Reg> {
  //
  final Reader reader;
  final int editRegId;

  final TextEditingController nicknameCtrl;
  final TextEditingController seiCtrl;
  final TextEditingController birthdayCtrl;
  final TextEditingController relCtrl;
  final TextEditingController episodeCtrl;

  // final Reg editReg;

  AddEditScreenCtrl({
    @required this.reader,
    this.editRegId,
  })  : nicknameCtrl = TextEditingController(),
        seiCtrl = TextEditingController(),
        birthdayCtrl = TextEditingController(),
        relCtrl = TextEditingController(),
        episodeCtrl = TextEditingController(),
        // editReg = reader(singleRegProvider(editRegId)),
        super(reader(singleRegProvider(editRegId)) ?? Reg()) {
    //
    // 各初期値を設定
    //

    nicknameCtrl.text = state.nickname;
    seiCtrl.text = state.sei;
    birthdayCtrl.text = state.birthday;
    relCtrl.text = state.rel;
    episodeCtrl.text = state.episode;

    //
    // 文字類が変わった時に状態を更新
    //
    nicknameCtrl
        .addListener(() => state = state.copyWith(nickname: nicknameCtrl.text));
    seiCtrl.addListener(() => state = state.copyWith(sei: seiCtrl.text));
    birthdayCtrl
        .addListener(() => state = state.copyWith(birthday: birthdayCtrl.text));
    relCtrl.addListener(() => state = state.copyWith(rel: relCtrl.text));
    episodeCtrl
        .addListener(() => state = state.copyWith(episode: episodeCtrl.text));
  }

  void dispose() {
    nicknameCtrl.dispose();
    seiCtrl.dispose();
    birthdayCtrl.dispose();
    relCtrl.dispose();
    episodeCtrl.dispose();
    super.dispose();
  }

  //
  // 保存の処理はオブジェクト一覧を管理しているプロバイダに任せる
  //
  Future<void> save() => reader(regObjectsCtrlProvider).update(state);

  Future<void> takePhoto() async {
    final pickerResult =
        await ImagePicker().getImage(source: ImageSource.gallery);
    // _cropImage(friendImage.path);
    if (pickerResult == null) return;
    // final bytes = await pickerResult.readAsBytes();
    File _croppedImage = await ImageCropper.cropImage(
      sourcePath: pickerResult.path,
      maxHeight: 300,
      maxWidth: 300,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    if (_croppedImage == null) return;
    Uint8List bytes = await _croppedImage.readAsBytes();

    // ImageCropper.cropImage(sourcePath: sourcePath)
    state = state.copyWith(image: bytes);
  }

// _cropImage(filePath) async {
//   File _croppedImage =
//       await ImageCropper.cropImage(sourcePath: filePath, maxHeight: 100, maxWidth: 100, aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
//   if (_croppedImage != null) {
//     Uint8List _imageFile = await _croppedImage.readAsBytes();
//     setState(() {
//       _showImage = File(_croppedImage.path);
//       _image = _imageFile;
//     });
//   }
// }

//
// 変更があるかはこれだけで探知できる
//
// bool isMofified() => state != reader(singleRegProvider(editRegId));

}

final addEditScreenCtrlProvider = StateNotifierProvider.family.autoDispose(
    (ref, regId) => AddEditScreenCtrl(reader: ref.read, editRegId: regId));

//
// 保存可能かどうかのプロバイダ
//
final canSaveProvider = Provider.family.autoDispose<bool, int>((ref, regId) {
  //
  // 編集内容取得
  //
  final newReg = ref.watch(addEditScreenCtrlProvider(regId).state);

  //
  // 必須項目をチェック
  //
  if (newReg.image == null ||
      (newReg.nickname?.length ?? 0) < 1 ||
      (newReg.episode?.length ?? 0) < 1) return false;

  //
  // すでに存在しているものと比較して変更があれば保存可能
  //
  return newReg != ref.read(singleRegProvider(regId));
});

final imageProvider =
    Provider.family.autoDispose<ImageProvider, int>((ref, regId) {
  final bytes = ref.watch(addEditScreenCtrlProvider(regId).state).image;
  if (bytes != null) return MemoryImage(bytes);
  return null;
});

//
// ビュー
//
class AddEditFriendsScreen extends ConsumerWidget {
  //
  static String name({int editRegId}) =>
      editRegId == null ? '/add-edit' : '/add-edit/$editRegId';

  static final router = UXRouter(
    pattern: r'/add-edit(/([a-z0-9\-]+))?',
    builder: (matches) => AddEditFriendsScreen(
        editRegId: matches[2] != null ? int.parse(matches[2]) : null),
  );

  final int editRegId;

  AddEditFriendsScreen({
    @required this.editRegId,
  });

  @override
  Widget build(BuildContext context, watch) {
    //
    final ctrl = watch(addEditScreenCtrlProvider(editRegId));
    int count = 0;

    Future<void> delete() async {
      if (editRegId != null) {
        TextButton(
          child: Text('登録'),
          onPressed: () {
            context.read(regObjectsCtrlProvider).deleteById(editRegId);
            Navigator.pop(context);
          },
        );
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        //
        // ここで変更がある場合のみIconButtonを押せるようにする
        //
        child: Consumer(
          builder: (ctx, watch, _) => AppBar(
            //
            // 戻るボタンを非表示にする
            //
            // automaticallyImplyLeading: false,
            leadingWidth: 85,
            leading: TextButton(
              child: Text(
                'キャンセル',
                style: TextStyle(
                  color: Color.fromRGBO(224, 125, 117, 1.0),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Image.asset(
              'images/appbar_logo.png',
              height: 60,
              width: 110,
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Color.fromRGBO(250, 243, 227, 1.0),
            actions: <Widget>[
              Container(
                width: 50.0,
                child: editRegId == null
                    ? Container()
                    : TextButton(
                        child: Text(
                          '削除',
                          style: TextStyle(
                            color: Color.fromRGBO(224, 125, 117, 1.0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          context
                              .read(regObjectsCtrlProvider)
                              .deleteById(editRegId);
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return Container(
                                child: AlertDialog(
                                  backgroundColor:
                                      Color.fromRGBO(250, 243, 227, 1.0),
                                  title: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.trashAlt,
                                        size: 130.0,
                                        color:
                                            Color.fromRGBO(88, 86, 104, 1.0),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        '削除が完了しました',
                                        style: TextStyle(
                                          color: Color.fromRGBO(88, 86, 104, 1.0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ElevatedButton(
                                        child: Text(
                                            "ホームへ戻る",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromRGBO(
                                              224, 125, 117, 1.0),
                                          onPrimary: Color.fromRGBO(
                                              250, 243, 227, 1.0),
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () => Navigator.popUntil(
                                            context, (_) => count++ >= 3),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
              TextButton(
                child: editRegId == null
                    ? Text(
                        '登録',
                        style: TextStyle(
                          color: Color.fromRGBO(224, 125, 117, 1.0),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        '完了',
                        style: TextStyle(
                          color: Color.fromRGBO(224, 125, 117, 1.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                // icon: Icon(Icons.save),
                onPressed: watch(canSaveProvider(editRegId))
                    ? () async {
                        await ctrl.save();
                        // Navigator.pop(context);
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return Container(
                              child: AlertDialog(
                                backgroundColor:
                                    Color.fromRGBO(88, 86, 104, 1.0),
                                title: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.checkCircle,
                                      size: 130.0,
                                      color: Color.fromRGBO(250, 243, 227, 1.0),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      '登録が完了しました',
                                      style: TextStyle(
                                        color:
                                            Color.fromRGBO(250, 243, 227, 1.0),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                      child: Text("ホームへ戻る"),
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromRGBO(224, 125, 117, 1.0),
                                        onPrimary:
                                            Color.fromRGBO(250, 243, 227, 1.0),
                                        shape: const StadiumBorder(),
                                      ),
                                      onPressed: () => Navigator.popUntil(
                                          context, (_) => count++ >= 2),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    : null,
              )
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ),
            alignment: Alignment.center,
            child: Container(
              width: 200,
              // color: Colors.red,
              child: Consumer(
                builder: (ctx, watch, _) => AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      //
                      // 背景色
                      //
                      // Container(
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: Colors.grey.shade300,
                      //   ),
                      // ),
                      //
                      //　アイコン
                      //
                      Center(
                        child: Icon(
                          Icons.account_circle_sharp,
                          size: 200.0,
                          color: Color.fromRGBO(204, 204, 204, 1.0),
                        ),
                      ),
                      //
                      //　画像がある時は表示
                      //
                      if (watch(imageProvider(editRegId)) != null)
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image(
                              image: watch(imageProvider(editRegId)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      //
                      // タップのレイヤー
                      //
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(onTap: () => ctrl.takePhoto()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          TextField(
            controller: ctrl.nicknameCtrl,
            maxLength: 9,
            decoration: InputDecoration(
              hintText: 'たなかくん',
              labelText: 'ニックネーム*',
            ),
          ),
          TextField(
            controller: ctrl.seiCtrl,
            maxLength: 5,
            decoration: InputDecoration(
              hintText: '男の子',
              labelText: '性別*',
            ),
          ),
          TextField(
            controller: ctrl.birthdayCtrl,
            maxLength: 12,
            decoration: InputDecoration(
              hintText: '2000/01/01',
              labelText: '誕生日*',
            ),
          ),
          TextField(
            controller: ctrl.relCtrl,
            maxLength: 12,
            decoration: InputDecoration(
              hintText: '友人',
              labelText: '関係性*',
            ),
          ),
          TextField(
            controller: ctrl.episodeCtrl,
            maxLength: 255,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                hintText: 'エピソードを入力してください', labelText: 'エピソード*'),
          ),
        ],
      ),
    );
  }
}
