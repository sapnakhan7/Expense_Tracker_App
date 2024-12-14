import 'package:expense_tracker/UI/Auth/SignUp/Signup_screen.dart';
import 'package:expense_tracker/UI/Screens/dashbord.dart';
import 'package:expense_tracker/Utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'Screens/homeScreen.dart';


class SplashScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                height: 250.w,
                width: 250.w,
                decoration: BoxDecoration(
                  color: color.lightblue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Lottie.asset(
                    'assets/wallet.json',
                    width: 120.w,
                    height: 120.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              // Title
              Text(
                "Save your money with Expense Tracker",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.h),
              // Subtitle
              Text(
                "Save money! The more your money works for you, "
                    "the less you have to work for money.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: 0.8.sw,
                child: ElevatedButton(
                  onPressed: () {
                    if (user == null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignupScreen()));
                    } else {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) =>  dashbord()));
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color.mainblue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    "Let's Start",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // CustomButton(
              //   text: "Log In",
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => LoginScreen()),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
