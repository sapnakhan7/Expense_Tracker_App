import 'package:expense_tracker/UI/Screens/dashbord.dart';
import 'package:expense_tracker/UI/Screens/homeScreen.dart';
import 'package:expense_tracker/Utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Custom_widgets/CustomButton.dart';
import '../../../Custom_widgets/custom_TextFormField_button.dart';
import '../../../Utils/toas.dart';
import '../SignUp/Signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isloading = false;

  loginFunction() {
    isloading = true;
    setState(() {});
    if (_formKey.currentState!.validate()) {
      print("Login Successful");
    }
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim())
        .then((v) {
      fluttertoas().showpopup(color.green, 'Login successfully');

      isloading = false;
      setState(() {});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => dashbord()));
    }).onError((error, stackTrace) {
      fluttertoas().showpopup(color.red, error.toString());
      isloading = false;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Proper disposal of controllers
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                        SizedBox(height: 25.h),
                        Center(
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: color.mainblue,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        // Custom Name Field
                        CustomTextFormField(
                          controller: emailController,
                          label: 'Email',
                          hintText: 'Enter your email',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        // Custom Password Field
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
                        SizedBox(height: 24.h),
                        // Custom Button
                        CustomButton(
                            isloading: isloading,
                          text: "Log In",
                          onPressed: loginFunction
                        ),
                        SizedBox(height: 16.h),
                        // Signup text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "I’m a new user. ",
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
                                  MaterialPageRoute(builder: (context) => SignupScreen()),
                                );
                              },
                              child: Text(
                                "SIGN UP",
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