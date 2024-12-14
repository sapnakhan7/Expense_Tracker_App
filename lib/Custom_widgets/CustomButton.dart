 import 'package:expense_tracker/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final isloading;

  const CustomButton({Key? key, required this.text, required this.onPressed, required this.isloading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.mainblue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 18.h),
      ),
      child: isloading
          ? Center(
          child: Container(
              height: 35.h,
              width: 40.w,
              child: CircularProgressIndicator(
                color: color.green,
              )))
          : Center(
        child:  Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),

    );
  }
}