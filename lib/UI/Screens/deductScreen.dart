import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import '../../Custom_widgets/custom savebutton.dart';
import '../../Custom_widgets/custom_textfield.dart';
import '../../Utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeductScreen extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();

  void saveExpenseToFirestore(BuildContext context) {
    final amount = double.tryParse(amountController.text.trim());

    if (amount == null || amount <= 0) {
      Fluttertoast.showToast(
        msg: "Enter a valid amount",
        backgroundColor: color.red,
        textColor: color.white,
      );
      return;
    }

    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    // if (userId == null) {
    //   Fluttertoast.showToast(
    //     msg: "User not logged in",
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //   );
    //   return;
    // }

    FirebaseFirestore.instance.collection('transactions').add({
      'type': 'expense',
      'amount': amount,
      'date': DateTime.now().toIso8601String(),
      'userId': userId,
    }).then((_) {
      Fluttertoast.showToast(
        msg: "Expense added successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.pop(context, amount);
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "Error adding expense: $error",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.mainblue,
        title: Text(
          'Deduct Screen',
          style: TextStyle(fontSize: 20, color: color.white, fontWeight: FontWeight.bold),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset('assets/unnamed-Photoroom.png'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  "Deduct Expense",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Lottie.asset(
                  'assets/add expense.json',
                  width: 200.w,
                  height: 200.w,
                  fit: BoxFit.cover,
                ),
              ),
              // Using CustomTextField for Amount Input
              CustomTextField(
                controller: amountController,
                labelText: "Expense",
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 80.h),
              // Using CustomSaveButton
              Center(
                child: CustomSaveButton(
                  onTap: () => saveExpenseToFirestore(context),
                  label: "DEDUCT",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
