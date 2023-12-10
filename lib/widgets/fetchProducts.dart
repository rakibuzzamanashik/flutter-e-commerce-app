import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_commerce_app/ui/product_details_screen.dart';





Widget fetchData (String collectionName){
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .snapshots(),
    builder:
        (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text("Something is wrong"),
        );
      }

      return ListView.builder(
          itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot =
            snapshot.data!.docs[index];

            return Column(
              children: [
                Card(
                  elevation: 3,
                  child: ListTile(
                    //leading: Text(_documentSnapshot['name'],style: TextStyle(fontSize: 17,)),
                    leading: Image.network(_documentSnapshot['images']),
                    subtitle: Text(_documentSnapshot['name'],style: TextStyle(fontSize: 17,)),
                    //subtitleTextStyle: ,
                    title: Align(alignment: Alignment.centerRight,
                      child: Text(
                        " ${_documentSnapshot['price']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red,fontSize: 17),
                      ),
                    ),

                    trailing: GestureDetector(
                      child: Icon(Icons.remove_circle, color: Colors.red,),
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection(collectionName)
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("items")
                            .doc(_documentSnapshot.id)
                            .delete()
                            .then((value) => Fluttertoast.showToast(msg: "Item Removed"));
                      },
                    ),

                  ),

                ),
                SizedBox(height: 15,),
              ],
            );
          });
    },
  );
}