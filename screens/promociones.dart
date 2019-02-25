import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizzapp/builders/order_builder.dart';

class Promociones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Promociones'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Promociones').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return orderBuilder(documents: snapshot.data.documents);
        },
      ),
    );
  }
}
