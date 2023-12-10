import 'package:e_commerce_app/ui/bottom_nav_pages/cart.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/favourite.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/home.dart';
import 'package:e_commerce_app/ui/bottom_nav_pages/profile.dart';
import 'package:flutter/material.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {

  final _pages = [Home(), Favourite(), Cart(), Profile()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "E-Commerce",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      bottomNavigationBar: BottomNavigationBar(
        //type: BottomNavigationBarType.shifting,


        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.home), label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label:'Favourite',),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label:'Cart',),
          BottomNavigationBarItem(icon: Icon(Icons.person), label:'Profile',),
        ],
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      body: _pages[_currentIndex],
    );
  }
}
