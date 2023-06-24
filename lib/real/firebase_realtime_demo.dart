import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeDemoScreen extends StatelessWidget {

  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    readData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Realtime Database Demo'),
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),

                  ),
                  child: Text('Create Data'),


                  onPressed: () {
                    createData();
                  },
                ),
                SizedBox(height: 8,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),

                  ),
                  child: Text('Read/View Data'),

                  onPressed: () {
                    readData();
                  },

                ),
                SizedBox(height: 8,),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),

                  ),
                  child: Text('Update Data'),

                  onPressed: () {
                    updateData();
                  },

                ),
                SizedBox(height: 8,),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),

                  ),
                  child: Text('Delete Data'),

                  onPressed: () {
                    deleteData();
                  },

                ),
              ],
            ),
          )
      ), //center
    );
  }

  void createData(){
    databaseReference.child("flutterDevsTeam1").set({
      'name': 'Deepak Nishad',
      'description': 'Team Lead'
    });
    databaseReference.child("flutterDevsTeam2").set({
      'name': 'Yashwant Kumar',
      'description': 'Senior Software Engineer'
    });
    databaseReference.child("flutterDevsTeam3").set({
      'name': 'Akshay',
      'description': 'Software Engineer'
    });
    databaseReference.child("flutterDevsTeam4").set({
      'name': 'Aditya',
      'description': 'Software Engineer'
    });
    databaseReference.child("flutterDevsTeam5").set({
      'name': 'Shaiq',
      'description': 'Associate Software Engineer'
    });
    databaseReference.child("flutterDevsTeam6").set({
      'name': 'Mohit',
      'description': 'Associate Software Engineer'
    });
    databaseReference.child("flutterDevsTeam7").set({
      'name': 'Naveen',
      'description': 'Associate Software Engineer'
    });

  }
  void readData(){
     databaseReference.once().then((DatabaseEvent event) {
      print('Data : ${event.snapshot.value}');
    });
  }

  void updateData(){
    databaseReference.child('flutterDevsTeam1').update({
      'description': 'CEO'
    });
    databaseReference.child('flutterDevsTeam2').update({
      'description': 'Team Lead'
    });
    databaseReference.child('flutterDevsTeam3').update({
      'description': 'Senior Software Engineer'
    });
  }

  void deleteData(){
    databaseReference.child('flutterDevsTeam1').remove();
    databaseReference.child('flutterDevsTeam2').remove();
    databaseReference.child('flutterDevsTeam3').remove();

  }
}