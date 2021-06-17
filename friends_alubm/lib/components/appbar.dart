import 'package:flutter/material.dart';


class MainHeader extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(250,243,227,1.0),
      // leading: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Icon(Icons.dehaze),
      // ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Icon(Icons.calendar_today),
      //   ),
      // ],
      title: Image.asset(
          'images/appbar_logo.png',
        height: 60,
        width: 110,
      ),
      centerTitle: true,
      elevation: 0.0,
    );
  }
}

class InfoHeader extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(255,248,220,1.0),
      // leading: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Icon(Icons.dehaze),
      // ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('編集'),
        ),
      ],
      title: Text(
        '友達図鑑',
        style: TextStyle(
          color: Color.fromRGBO(25, 25, 112, 1.0),
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
    );
  }
}