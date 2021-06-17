import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_alubm/components/reg_model.dart';
import 'package:friends_alubm/providers.dart';
import 'package:friends_alubm/router.dart';
import 'package:friends_alubm/screens/friends_reg_screen.dart';

class FriendInfoScreen extends ConsumerWidget {
  //
  static String name({@required int regId}) => '/info/$regId';

  static final router = UXRouter(
    pattern: r'/info/([a-z0-9\-]+)',
    builder: (match) => FriendInfoScreen(regId: int.parse(match.group(1))),
  );

  // @override
  // _FriendInfoScreenState createState() => _FriendInfoScreenState();

  final int regId;

  // final Function getRegInfo;
  // final Reg reg;

  FriendInfoScreen({
    @required this.regId,
    // this.getRegInfo,
    // this.reg,
  });

  Reg _reg;

  final _cardMargin = SizedBox(height: 10.0);

  @override
  Widget build(BuildContext context, watch) {
    //
    //
    // 削除された瞬間にnullになるが、前回の値を保持しているのでそれを使用
    //
    _reg = watch(singleRegProvider(regId)) ?? _reg;

    // スマホのサイズごとの余白サイズを決定する
    final _marginHeight = MediaQuery.of(context).size.height/15;

    print('re-build FriendInfoScreen');

    Widget _buttonArea() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Color.fromRGBO(224, 125, 117, 1.0),
              child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 18.0,
                    onPressed: () => Navigator.of(context).pop(),
              ),
          ),
             ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AddEditFriendsScreen.name(editRegId: _reg.id)),
              child: Text(
                '編集',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(224, 125, 117, 1.0),
                onPrimary: Color.fromRGBO(250,243,227,1.0),
                shape: const StadiumBorder(),
              ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(250,243,227,1.0),
      // appBar: AppBar(
      //   title: Text('${_reg.nickname}'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.edit),
      //       onPressed: () => Navigator.pushNamed(context, AddEditFriendsScreen.name(editRegId: _reg.id)),
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.delete),
      //       onPressed: () {
      //         context.read(regObjectsCtrlProvider).deleteById(regId);
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ],
      // ),
      // appBar: AppBar(
      //   backgroundColor: Colors.white.withOpacity(0.0),
      //   elevation: 0.0,
      // ),
      // extendBodyBehindAppBar: true,

      body: Center(
          child: Card(
            shadowColor: Colors.black,
            elevation: 10.0,
            margin: EdgeInsets.fromLTRB(20.0,_marginHeight,20.0,20.0),
            clipBehavior: Clip.antiAlias,
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                _buttonArea(),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 30,
                  ),
                  child: Container(
                    width: 170,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CircleAvatar(
                          child: ClipOval(
                            child: Image(
                                image: MemoryImage(_reg.image),
                            ),
                          ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                      '${_reg.nickname}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(130,116,99,1.0),
                      fontSize: 24
                    ),
                  ),
                ),
                _cardMargin,
                Table(
                  border: TableBorder.all(color: Color.fromRGBO(130,116,99,1.0),),
                  children: [
                    TableRow(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(3.0),
                              child: Text(
                                  '誕生日',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(130,116,99,1.0),
                                ),
                              ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(3.0),
                              child: Text(
                                  '性別',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(130,116,99,1.0),
                                ),),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(3.0),
                              child: Text(
                                  '${_reg.birthday}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(130,116,99,1.0),
                                ),
                              ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(3.0),
                              child: Text(
                                  '${_reg.sei}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(130,116,99,1.0),
                                ),),
                          ),
                        ]
                    ),
                  ],
                ),
                _cardMargin,
            Table(
              border: TableBorder.all(color: Color.fromRGBO(130,116,99,1.0),),
              children: [
                TableRow(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                            '関係性',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(130,116,99,1.0),
                          ),),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                            '${_reg.rel}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(130,116,99,1.0),
                          ),),
                      ),
                    ]
                ),
              ],
            ),
                _cardMargin,
                Table(
                  border: TableBorder.all(color: Color.fromRGBO(130,116,99,1.0),),

                  children: [
                    TableRow(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3.0),
                            alignment: Alignment.center,
                            child: Text(
                                'エピソード',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(130,116,99,1.0),
                              ),),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                                '${_reg.episode}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(130,116,99,1.0),
                              ),),
                          ),
                        ]
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
