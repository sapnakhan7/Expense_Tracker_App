import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import '../../Custom_widgets/custom savebutton.dart';
import '../../Custom_widgets/custom_textfield.dart';
import '../../Utils/app_colors.dart';

class AddScreen extends StatelessWidget {
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void saveToFirestore(BuildContext context) {
    final income = double.tryParse(incomeController.text.trim());
    final description = descriptionController.text.trim();

    if (income == null || description.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill in all fields",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    FirebaseFirestore.instance.collection('transactions').add({
      'type': 'income',
      'amount': income,
      'description': description,
      'date': DateTime.now().toIso8601String(),
      'userId': FirebaseAuth.instance.currentUser?.uid,
    }).then((_) {
      Fluttertoast.showToast(
        msg: "Income added successfully!",
        backgroundColor: color.green,
        textColor: color.white,
      );
      Navigator.pop(context, income);
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "Error adding income: $error",
        backgroundColor: color.red,
        textColor: color.white,
      );
    });
  }

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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Text(
                "Add Income",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Lottie.asset(
                'assets/add expense.json',
                width: 200.w,
                height: 200.w,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 5.h),
              CustomTextField(
                controller: incomeController,
                labelText: "Income",
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: descriptionController,
                labelText: "Description",
              ),
              SizedBox(height: 50.h),
              CustomSaveButton(
                onTap: () => saveToFirestore(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
