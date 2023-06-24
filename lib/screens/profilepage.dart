import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../utils/fire_auth.dart';


class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   String? _imagePath;
  bool _isSendingVerification = false;
  bool isLoading = false;
  late User _currentUser;
   Future getImage() async {
    PickedFile? image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      _imagePath =  image!.path;
      print('Image_Path $_imagePath');
    });
  }


 setImageUser(){

 }
  @override
  void initState() {
    _currentUser = widget.user;
    _imagePath =  _currentUser.photoURL;
    print("Image_Path");
    print(_imagePath);
    super.initState();
  }

   bool isURl ()      {

      return Validator.checkIfUrlIsValid(url: _imagePath!);
 }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Edit Profile'),
        ),
        body:   SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Color(0xff476cfb),
                        child: ClipOval(
                          child: SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_imagePath!=null)  ? Image.file(
                              File(_imagePath!),
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.camera,
                          size: 30.0,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                  ],
                ),
             const   SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child:   Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Username',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('${_currentUser.displayName}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Icon(
                          FontAwesomeIcons.pen,
                          color: Color(0xff476cfb),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('EMAIL',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('${_currentUser.email}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Icon(
                          FontAwesomeIcons.pen,
                          color: Color(0xff476cfb),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      style:  ElevatedButton.styleFrom(
                        elevation: 4.0,
                        backgroundColor: Color(0xff476cfb),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },

                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff476cfb),
                        elevation: 4.0,
                      ),
                      onPressed: () {
                        uploadPic(context);
                      },


                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 16.0),
                _currentUser.emailVerified
                    ? Text(
                  'Email verified',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.green),
                )
                    : Text(
                  'Email not verified',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.red),
                ),

                SizedBox(height: 16.0),
                _isSendingVerification
                    ? CircularProgressIndicator()
                    : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isSendingVerification = true;
                        });
                        await _currentUser.sendEmailVerification();
                        setState(() {
                          _isSendingVerification = false;
                        });
                      },
                      child: Text('Verify email'),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () async {
                        User? user = await FireAuth.refreshUser(_currentUser);

                        if (user != null) {
                          setState(() {
                            _currentUser = user;
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.0),


              ],
            ),
        ),
      
      
        );
  }

   Future uploadPic(BuildContext context) async{
     String fileName = basename(_imagePath!);
     Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
     File imageFile = File(_imagePath!);
     UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
     uploadTask.snapshotEvents.listen((taskSnapshot) async {
       switch (taskSnapshot.state)  {
         case TaskState.running:
           break;
         case TaskState.paused:

           break;
         case TaskState.success:

           final String downloadUrl =
           await uploadTask.snapshot.ref.getDownloadURL();
           await FirebaseFirestore.instance
               .collection("images").doc(_currentUser.uid)
               .set({"url": downloadUrl, "name": fileName});
           setState(() {
             isLoading = false;
           });
           final snackBar =
           SnackBar(content: Text('Yay! Success'));
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
           break;
         case TaskState.canceled:

           break;
         case TaskState.error:

           break;
       }
     });



     // setState(() {
     //   print("Profile Picture uploaded");
     //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
     // });
   }
}
