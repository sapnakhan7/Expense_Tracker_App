import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Utils/app_colors.dart';
import '../Auth/LogIn/Login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.mainblue,
        title: Text(
          'Add Screen',
          style: TextStyle(fontSize: 20, color:color.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Icon(Icons.arrow_back, color: color.white),
          ),
        ),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Image.asset('assets/unnamed-Photoroom.png'),
        ),],
      ),
     body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [

            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpeg'),
            ),
            SizedBox(height: 16),

            Text(
              'Sapna Fazal',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: color.black),
            ),
            Text(
              'sapna@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),
            // Options List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileOptionItem(
                  icon: Icons.person,
                  title: 'Profile details',
                  onTap: () {},
                ),
                ProfileOptionItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  onTap: () {},
                ),
                ProfileOptionItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {},
                ),
                ProfileOptionItem(
                  icon: Icons.support,
                  title: 'Support',
                  onTap: () {},
                ),
                ProfileOptionItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    FirebaseAuth.instance.signOut().then((v) {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  ProfileOptionItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: color.mainblue),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
