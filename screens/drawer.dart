import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:pizzapp/screens/promociones.dart';
import 'package:pizzapp/screens/pizza.dart';
import 'package:pizzapp/screens/alitas.dart';
import 'package:pizzapp/screens/postres.dart';
import 'package:pizzapp/screens/refrescos.dart';
import 'package:pizzapp/screens/current_order.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  Promociones one;
  Pizza two;
  Alitas three;
  Refrescos four;
  Postres five;
  CurrentOrder six;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    one = Promociones();
    two = Pizza();
    three = Alitas();
    four = Refrescos();
    five = Postres();
    six = CurrentOrder();
    pages = [one, two, three, four, five, six];
    currentPage = pages[5];

    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    // Attempt to get the currently authenticated user
    GoogleSignInAccount currentUser = _googleSignIn.currentUser;
    if (currentUser == null) {
      // Attempt to sign in without user interaction
      currentUser = await _googleSignIn.signInSilently();
    }
    if (currentUser == null) {
      // Force the user to interactively sign in
      currentUser = await _googleSignIn.signIn();
    }

    /* final GoogleSignInAuthentication auth = await currentUser.authentication;

    // Authenticate with firebase
    final FirebaseUser user = await _auth.signInWithCustomToken(
     var idToken: auth.idToken,
      var accessToken: auth.accessToken,
    );

    assert(user != null);
    assert(!user.isAnonymous);

    return user;*/
  }

  Future<Null> _signOut() async {
    await _auth.signOut();
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    Navigator.pushNamed(context, '/Splash');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          drawer: Drawer(
            child: Container(
              color: Colors.grey,
              child: ListView(
                children: <Widget>[
                  Container(
                    child: UserAccountsDrawerHeader(
                      accountName: Text(
                        'PizzApp',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      accountEmail: null,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/pizza2.jpg'),
                        fit: BoxFit.fill,
                      )),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Promociones',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      const IconData(0xe91a, fontFamily: 'icomoon'),
                      color: Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        currentPage = pages[0];
                      });
                    },
                    /*() {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/Promociones');
                      },*/
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text(
                      'Pizza',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.local_pizza,
                      color: Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        currentPage = pages[1];
                      });
                    },
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text(
                      'Alitas',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      const IconData(0xe902, fontFamily: 'icomoon'),
                      color: Colors.black,
                      size: 28.0,
                    ),
                    onTap: () {
                      setState(() {
                        currentPage = pages[2];
                      });
                    },
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text(
                      'Refrescos',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      const IconData(0xe900, fontFamily: 'icomoon'),
                      color: Colors.black,
                      size: 28.0,
                    ),
                    onTap: () {
                      setState(() {
                        currentPage = pages[3];
                      });
                    },
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text(
                      'Postres',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      const IconData(0xe901, fontFamily: 'icomoon'),
                      color: Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        currentPage = pages[4];
                      });
                    },
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text(
                      'Mi Orden',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      const IconData(0xe91a, fontFamily: 'icomoon'),
                      color: Colors.black,
                    ),
                    onTap: () {
                      setState(() {
                        currentPage = pages[5];
                      });
                    },
                    /*() {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/Promociones');
                      },*/
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      const IconData(0xea14, fontFamily: 'icomoon'),
                      color: Colors.black,
                      size: 35.0,
                    ),
                    onTap: () {
                      _signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
          body:
              currentPage, /*Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/pizza.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Tu Orden",
                                style: TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                "Asegura que este Correcta",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // add list here
                    ],
                  ),
                ),
              ),
            )*/
        ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
