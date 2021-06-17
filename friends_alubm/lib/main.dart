import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_alubm/providers.dart';
import 'package:friends_alubm/router.dart';
import 'package:friends_alubm/screens/friend_info_screen.dart';
import 'package:friends_alubm/screens/friends_alubm_screen.dart';
import 'package:friends_alubm/screens/friends_reg_screen.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  //
  //
  //
  @override
  Widget build(BuildContext context, watch) => watch(bootProvider).maybeWhen(
        orElse: () => Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        data: (_) => MaterialApp(
          title: '友達図鑑',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FriendsListScreen(),
          // routes: {
          //   '/add' : () =/
          // },
          onGenerateRoute: (settings) => [
            AddEditFriendsScreen.router,
            FriendInfoScreen.router,
          ].generate(settings),
        ),
      );
}
