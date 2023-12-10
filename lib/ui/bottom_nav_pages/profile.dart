import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_commerce_app/ui/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/customButton.dart';
import 'package:e_commerce_app/const/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController ?_nameController;
  TextEditingController ?_phoneController;
  TextEditingController ?_ageController;






  setDataToTextField(data){
    return  SingleChildScrollView(
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              AspectRatio(aspectRatio: 3, child: Image.network('https://firebasestorage.googleapis.com/v0/b/flutter-e-commerce-4e5b5.appspot.com/o/images%2FUser-Profile-PNG-Download-Image.png?alt=media&token=508963dc-c9f9-45fb-8013-2b9191a57ce1')),

              SizedBox(height: 20),

              TextFormField(
                controller: _nameController = TextEditingController(text: 'Name: ' + data['name']),
              ),
              TextFormField(
                controller: _phoneController = TextEditingController(text: 'Phone: ' + data['phone']),
              ),
              TextFormField(
                controller: _ageController = TextEditingController(text: 'Age: ' + data['age']),
              ),

              SizedBox(height: 20),
              ElevatedButton(onPressed: ()=>updateData(), child: Text("Update Info"),style: ElevatedButton.styleFrom(
                primary: AppColors.deep_orange,
                elevation: 3,
              ),),




              SizedBox(height: 260),

              SizedBox(
                width: 0.6.sw,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: (){Navigator.push(context, CupertinoPageRoute(builder: (context) => LoginScreen()));},
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.deep_orange,
                    elevation: 3,
                  ),
                ),
              ),




            ],
          );
        }
      ),
    );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "name":_nameController!.text,
          "phone":_phoneController!.text,
          "age":_ageController!.text,

        }
    ).then((value) => Fluttertoast.showToast(msg: "Updated"));
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;
            if(data==null){
              return Center(child: CircularProgressIndicator(),);
            }
            return setDataToTextField(data);
          },

        ),
      )),
    );
  }
}
