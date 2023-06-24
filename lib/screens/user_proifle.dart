import 'package:firebase_example/utils/app_color.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class UserProilfe extends StatefulWidget {
  final User user;

  const UserProilfe({super.key, required this.user});
  @override
  _UserProifleState createState() => _UserProifleState();
}
class _UserProifleState extends State<UserProilfe>{
   String? _imagePath ;
   bool isUloading = false ;
   UploadTask?   uploadTaskImageOne;
   UploadTask?   uploadTaskImageTwo;
   final storageRef =  FirebaseStorage.instance.ref();

   getImage() async{
    PickedFile?  pickedFile =  await ImagePicker.platform.pickImage(source: ImageSource.gallery);
     setState(() {
       _imagePath = pickedFile!.path;
     });


  }

   uploadMuiltImages() async {
     final List<XFile> images = await ImagePicker().pickMultiImage();
     for(int i =0 ; i <images.length ; i++){
       XFile file = images[i];
       UploadTask uploadTask = storageRef.child("images/$i").putFile(File(file.path));
       uploadTask.snapshotEvents.listen((taskState)  async {
         if( taskState.state == TaskState.success){
         }  else if  (taskState.state == TaskState.error){
         }else if (taskState.state == TaskState.running){

         }

       });
     }

   }


  uploadToStorage() async{
  final storageRef =  FirebaseStorage.instance.ref();
  uploadTaskImageOne = storageRef.child("images/image1.png").putFile(File(_imagePath!));

  uploadTaskImageOne!.snapshotEvents.listen((taskState)  async {
    if( taskState.state == TaskState.success){

      setState(()  async {
        _imagePath  = await uploadTaskImageOne!.snapshot.ref.getDownloadURL();
        isUloading = false;
      });


    }  else if  (taskState.state == TaskState.error){
      setState(() {
        isUloading = false;
      });


    }else if (taskState.state == TaskState.running){
      setState(() {
        isUloading = true;
      });



    }

 });


   }
  
  @override
  Widget build(BuildContext context) {

     return Scaffold(
       appBar:  AppBar(
         title: Text("user profile"),
       ),


       body: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Row(
             children: [

       Align(
       alignment: Alignment.center,

                 child: CircleAvatar(
                   radius: 100,
                   backgroundColor: Color(0xff476cfb),
                   child: ClipOval(
                     child: SizedBox(
                       width: 180.0,
                       height: 180.0,
                       child:
                       _imagePath== null ?
                       Image.network(
                         _imagePath! ,
                         fit: BoxFit.fill,
                       ) :
                       Image.file(File(_imagePath! )  ,
                         height: 100 , width: 100  ,
                         fit: BoxFit.fill,)

                       // Image.network(
                       //   "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                       //   fit: BoxFit.fill,
                       // ),
                     ),
                   ),
                 ),
               ),
               Padding(
                 padding: EdgeInsets.only(top: 60.0),
                 child: IconButton(
                   icon: Icon(
                     FontAwesomeIcons.camera,
                     size: 30.0,
                   ),
                   onPressed: () {
                      print("shaimaa");
                     getImage();
                   },
                 ),
               ),

             ],
           ) ,
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              AppColors.myThem = ThemeMode.dark;
              uploadToStorage();


            }, child: Text("upload")),
           SizedBox(height: 20,),
           ElevatedButton(onPressed: (){
             if(isUloading== true){
               uploadTaskImageOne!.cancel();
             }
           }, child: Text("Cancel uploading"))

         ],
       ) ,

     );
  }

}
