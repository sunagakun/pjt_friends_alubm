import 'package:flutter/material.dart';

//
// Simple router pattern
//

typedef UXRouterBuilder = Widget Function(RegExpMatch);
typedef UXRouterNameBuilder = String Function(Map<String, String>);

extension UXRouterExt on Iterable<UXRouter> {
  //
  bool containsMatch(String path) {
    for (final router in this) {
      if (router.match(path) != null) return true;
    }
    return false;
  }

  Route<dynamic> generate(RouteSettings settings) {
    //
    final path = settings.name;
    if (path == null) return null;

    for (final router in this) {
      final match = router.match(path);
//      print('path: $path, match:$match');
      if (match != null) {
        return MaterialPageRoute(
          builder: (_) => router.builder(match),
          settings: settings,
          fullscreenDialog: router.fullscreenDialog,
        );
      }
    }

    // return null;
  }
}

class UXRouter {
  //
  final String pattern;
  final UXRouterBuilder builder;
  final bool fullscreenDialog;

  RegExp _regExp;

  UXRouter({
    @required this.pattern,
    @required this.builder,
    this.fullscreenDialog = false,
  }) : _regExp = RegExp(
          '^$pattern\$',
          caseSensitive: false,
          multiLine: false,
        );

  RegExpMatch match(String path) => _regExp.firstMatch(path);
}
