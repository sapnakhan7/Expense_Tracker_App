import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:expense_tracker/UI/Screens/DeductScreen.dart';
import 'package:expense_tracker/UI/Screens/ProfileScreen.dart';
import 'package:expense_tracker/UI/Screens/homeScreen.dart';
import 'package:flutter/material.dart';

import '../../Utils/app_colors.dart';
import 'AddScreen.dart';
class dashbord extends StatefulWidget {
  const dashbord({super.key});

  @override
  State<dashbord> createState() => _dashbordState();
}

class _dashbordState extends State<dashbord> {
  int index=0;

  final Screens=[
    HomeScreen(),
    AddScreen(),
    DeductScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[index],
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        color: color.mainblue ?? Colors.blue,
        buttonBackgroundColor: color.orange,
        backgroundColor: Colors.transparent,
        height: 50,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        index: index,
        items: <Widget>[
          Icon(Icons.home, size: 30,color: color.white,),
          Icon(Icons.add, size: 30,color: color.white,),
          Icon(Icons.remove_circle_outline, size: 30,color: color.white,),
          Icon(Icons.person, size: 30,color: color.white,),
        ],
        onTap: (index) =>setState(() => this.index = index),
      ),
    );
  }
}