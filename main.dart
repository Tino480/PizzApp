import 'package:flutter/material.dart';
import 'package:pizzapp/screens/splash.dart';
import 'package:pizzapp/screens/login.dart';
import 'package:pizzapp/screens/drawer.dart';
import 'package:pizzapp/screens/signup.dart';
import 'package:pizzapp/screens/pizza.dart';
import 'package:pizzapp/screens/refrescos.dart';
import 'package:pizzapp/screens/postres.dart';
import 'package:pizzapp/screens/promociones.dart';
import 'package:pizzapp/screens/alitas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red, hintColor: Colors.white),
      title: 'PizzApp',
      routes: <String, WidgetBuilder>{
        '/Splash': (BuildContext context) => SplashScreen(),
        '/Login': (BuildContext context) => LoginPage(),
        '/Drawer': (BuildContext context) => DrawerPage(),
        '/Signup': (BuildContext context) => SignUp(),
        '/Pizza': (BuildContext context) => Pizza(),
        '/Refrescos': (BuildContext context) => Refrescos(),
        '/Postres': (BuildContext context) => Postres(),
        '/Promociones': (BuildContext context) => Promociones(),
        '/Alitas': (BuildContext context) => Alitas(),
      },
      home: SplashScreen(),
    );
  }
}
