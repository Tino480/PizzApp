import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    getUID() async {
      final FirebaseUser user = await auth.currentUser();
      final uid = user.uid;
      return uid;
    }

    final documentId = getUID();
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Orders')
            .where('user', isEqualTo: documentId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          return CurrentOrderBuilder(documents: snapshot.data.documents);
        },
      ),
    );
  }
}

class CurrentOrderBuilder extends StatelessWidget {
  const CurrentOrderBuilder({this.documents});

  final List<DocumentSnapshot> documents;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: documents.length,
        itemExtent: 200.0,
        itemBuilder: (BuildContext context, int index) {
          String customer = documents[index].data['Customer'].toString();
          String items = documents[index].data['Items'].toString();
          String total = documents[index].data['Total'].toString();
          return Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            height: 400.0,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/pizza2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    height: 400.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          customer,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: Colors.white),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(items,
                                  style: const TextStyle(
                                      fontSize: 30.0, color: Colors.white)),
                            ]),
                        Text(
                          total,
                          style: const TextStyle(
                              fontSize: 30.0, color: Colors.white),
                        ),
                        Container(
                          width: 250.0,
                          decoration: const BoxDecoration(color: Colors.red),
                          child: const ListTile(
                              title: Text(
                                'Cobrar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                  color: Colors.red,
                                  iconSize: 30.0,
                                  icon: Icon(Icons.add_shopping_cart),
                                  onPressed: null)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
