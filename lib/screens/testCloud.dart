import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TestCloud extends StatefulWidget {
  const TestCloud({Key? key}) : super(key: key);

  @override
  State<TestCloud> createState() => _TestCloudState();
}

class _TestCloudState extends State<TestCloud> {
  @override
  void initState() {
    setCollection();
      super.initState();
  }


   setCollection() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference  proudctesC = firebaseFirestore.collection("products");
    QuerySnapshot  querySnapshot =  await firebaseFirestore.collection("products").get();
    Stream<QuerySnapshot>  qureS =   firebaseFirestore.collection("products").snapshots();
    DocumentSnapshot  documentSnapshot =await firebaseFirestore.collection("products").doc("BJfmd0hO1FSLUxrYlkdq").get();



   }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
