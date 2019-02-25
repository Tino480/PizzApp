import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class orderBuilder extends StatelessWidget {
  final List<DocumentSnapshot> documents;

  orderBuilder({this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: documents.length,
        itemExtent: 200.0,
        itemBuilder: (BuildContext context, int index) {
          String Photo = documents[index].data['Photo'].toString();
          String Nombre = documents[index].data['Nombre'].toString();
          String Descripcion = documents[index].data['Descripcion'].toString();
          String Precio = documents[index].data['Precio'].toString();
          int Cantidad = documents[index].data['Cantidad'];

          void order() async {
            final FirebaseAuth _auth = FirebaseAuth.instance;
            final FirebaseUser user = await _auth.currentUser();
            final String uid = user.uid;
            Firestore.instance.collection('Orders').document(uid).updateData(
              {
                'user': uid,
                'Items': FieldValue.arrayUnion([Nombre]),
                'Total': FieldValue.arrayUnion([Precio]),
                'Customer': FieldValue.arrayUnion([Cantidad]),
              },
            );
          }

          return Container(
              constraints: BoxConstraints(
                  maxHeight: 200.0,
                  maxWidth: 300.0,
                  minWidth: 150.0,
                  minHeight: 150.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(Photo), fit: BoxFit.cover)),
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: ExpansionTile(
                  title: Text(Nombre),
                  children: <Widget>[
                    Text(Descripcion),
                    Text(Precio),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Cantidad"),
                        IconButton(
                          icon: Icon(Icons.arrow_left),
                          onPressed: () {
                            Firestore.instance.runTransaction(
                                (Transaction transaction) async {
                              DocumentSnapshot snapshot = await transaction
                                  .get(documents[index].reference);
                              if (Cantidad != 1)
                                await transaction.update(snapshot.reference,
                                    {'Cantidad': snapshot['Cantidad'] - 1});
                            });
                          },
                        ),
                        Text('$Cantidad'),
                        IconButton(
                          icon: Icon(Icons.arrow_right),
                          onPressed: () {
                            Firestore.instance.runTransaction(
                                (Transaction transaction) async {
                              DocumentSnapshot snapshot = await transaction
                                  .get(documents[index].reference);
                              await transaction.update(snapshot.reference,
                                  {'Cantidad': snapshot['Cantidad'] + 1});
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.red),
                      child: ListTile(
                        title: Text(
                          'Agregar a Mi Orden',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.add_shopping_cart),
                        onTap: order,
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
