import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sliver Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'PizzApp',
              style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),

            backgroundColor: Colors.white,
            floating: true,
            // pinned: true,
            centerTitle: true,
            elevation: 10.0,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/pizza.png",
                fit: BoxFit.cover,
              ),
              title: Text(
                '       Postres',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 50.0,
              childAspectRatio: 1.0,
            ),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: new NetworkImage(
                              "https://images-gmi-pmc.edge-generalmills.com/087d17eb-500e-4b26-abd1-4f9ffa96a2c6.jpg"),
                          fit: BoxFit.cover)),
                  alignment: Alignment.bottomCenter,
                  child: new Container(
                    constraints: BoxConstraints(
                        maxHeight: 300.0,
                        maxWidth: 200.0,
                        minWidth: 150.0,
                        minHeight: 150.0),
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        image: new DecorationImage(
                            image: new AssetImage("assets/images/pizza5.jpg"),
                            fit: BoxFit.cover)),
                    child: new ExpansionTile(
                      title: new Text(
                        "Nombre",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      children: <Widget>[
                        new Text(
                            "This is a hella of a bomb ass cookie you wont regret ordering this")
                      ],
                    ),
                  ));
            }, childCount: 2),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
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
