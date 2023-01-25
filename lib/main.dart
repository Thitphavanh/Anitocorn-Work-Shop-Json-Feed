import 'package:anitocorn_work_shop_json_feed/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService authService = AuthService();
  Widget page = const Login();

  final route = <String, WidgetBuilder>{
    "/login": (context) => const Login(),
    "/home": (context) => const Home(),
  };

  if (await authService.isLogin()) {
    page = const Home();
  }
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anitocorn Json Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: route,
      home: page,
    ),
  );
}




// https://www.youtube.com/watch?v=3l5zAHy3I9Y