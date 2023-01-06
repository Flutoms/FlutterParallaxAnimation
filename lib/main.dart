import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'SF Pro Display'),
        title: 'Buy Tickets',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
