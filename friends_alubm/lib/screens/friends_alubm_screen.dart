import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_alubm/components/reg_model.dart';
import 'package:friends_alubm/providers.dart';
import 'package:friends_alubm/screens/friend_info_screen.dart';
import 'package:friends_alubm/screens/friends_reg_screen.dart';
import 'package:intl/intl.dart';
import '../components/appbar.dart';

class FriendsListScreen extends StatelessWidget {

  Widget _buildReg(BuildContext context, Reg reg) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 1.0,
                blurRadius: 10.0,
                offset: Offset(3, 3),
              ),
            ],
        ),
        child: AspectRatio(
          aspectRatio:  9 / 10,
          child: Card(
            child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: reg.image != null
                                ? ClipOval(
                                    child: Image.memory(reg.image),
                                  )
                                : Container(),
                          ),
                        ),
                      Container(
                            child: Text(
                              reg.nickname,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                onTap: () => Navigator.pushNamed(
                      context,
                      FriendInfoScreen.name(regId: reg.id),
                    )
                ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(88, 86, 104, 1.0),
      appBar: MainHeader(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromRGBO(224, 125, 117, 1.0),
        icon: Icon(Icons.create_rounded),
        label: Text(
            '登録する',
          style: TextStyle(
            color: Color.fromRGBO(250,243,227,1.0),
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          final reg = await Navigator.pushNamed(context, AddEditFriendsScreen.name());
        },
      ),
      body: Consumer(
        builder: (ctx, watch, _) {
          //
          final regList = watch(regListProvider);

          if (regList.isEmpty) {
            //
            // 空の場合
            //
            return Center(
              child: Text(
                'あなたの友達を登録してみましょう！',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: regList.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildReg(ctx, regList[index]);
            },
          );
        },
      ),
    );
  }
}
