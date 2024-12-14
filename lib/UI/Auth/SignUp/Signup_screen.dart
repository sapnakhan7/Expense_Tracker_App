import 'package:expense_tracker/UI/Auth/LogIn/Login_screen.dart';
import 'package:expense_tracker/UI/Screens/homeScreen.dart';
import 'package:expense_tracker/Utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Custom_widgets/CustomButton.dart';
import '../../../Custom_widgets/custom_TextFormField_button.dart';
import '../../../Utils/toas.dart';
import '../../Screens/dashbord.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isloading = false;

  signupFunction() {
    isloading = true;
    setState(() {});
    if (_formKey.currentState!.validate()) {
      print("Sign Up Successful");
    }
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim())
        .then((v) {
      fluttertoas().showpopup(color.green, 'sigup successfully');
      isloading = false;
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => dashbord()));
      });
    }).onError((error, Stack) {
      fluttertoas().showpopup(color.red, error.toString());
      isloading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13.r),
                topRight: Radius.circular(13.r),
              ),
              child: Image.asset(
                'assets/expense-tracking-app (1).webp',
                height: 300.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Bottom container
          Positioned(
            top: 280.h,
            left: 0.w,
            right: 0.w,
            bottom: 0.h,
            child: Container(
              decoration: BoxDecoration(
                color: color.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 3.h),
                        Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: color.mainblue,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        // Name Field
                        CustomTextFormField(
                          controller: nameController,
                          label: 'Name',
                          hintText: 'Enter your name',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12.h),
                        // Email Field
                        CustomTextFormField(
                          controller: emailController,
                          label: 'Email',
                          hintText: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12.h),
                        // Password Field
                        CustomTextFormField(
                          controller: passwordController,
                          label: 'Password',
                          hintText: 'Enter your password',
                          keyboardType: TextInputType.visiblePassword,
                          isObscure: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 17.h),
                        // Sign Up Button
                        CustomButton(
                          isloading: isloading,
                          text: "Sign Up",
                          onPressed: signupFunction
                        ),
                        SizedBox(height: 14.h),
                        // Log In Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account. ",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              },
                              child: Text(
                                "LOG IN",
                                style: TextStyle(
                                  color: color.mainblue,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
