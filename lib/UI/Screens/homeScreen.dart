import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Utils/app_colors.dart';
import '../Auth/LogIn/Login_screen.dart';
import 'AddScreen.dart';
import 'DeductScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalBalance = 0.0;
  double totalIncome = 0.0;
  double totalExpenses = 0.0;
  List<Map<String, dynamic>> transactions = [];
  final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    fetchTransactionsFromFirestore();
  }

  void fetchTransactionsFromFirestore() {
    if (currentUserId == null) {
      Fluttertoast.showToast(
        msg: "User not logged in",
        backgroundColor: color.red,
        textColor: color.white,
      );
      return;
    }

    FirebaseFirestore.instance
        .collection('transactions')
        .where('userId', isEqualTo: currentUserId)
        .snapshots()
        .listen((snapshot) {
      double newTotalIncome = 0.0;
      double newTotalExpenses = 0.0;
      List<Map<String, dynamic>> newTransactions = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final type = data['type'];
        final amount = data['amount'] ?? 0.0;

        if (type == 'income') {
          newTotalIncome += amount;
        } else if (type == 'expense') {
          newTotalExpenses += amount;
        }

        newTransactions.add({
          "title": type == 'income' ? "Income" : "Expense",
          "amount": amount,
          "type": type,
          "time": data['date'] ?? DateTime.now().toString().split('.')[0],
        });
      }

      setState(() {
        totalIncome = newTotalIncome;
        totalExpenses = newTotalExpenses;
        totalBalance = totalIncome - totalExpenses;
        transactions = newTransactions;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.mainblue,
        title: Text(
          'Home',
          style: TextStyle(fontSize: 20, color: color.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Image.asset('assets/unnamed-Photoroom.png'),
        ),
        actions: [
          IconButton(
            color: color.white,
            onPressed: () {
              FirebaseAuth.instance.signOut().then((v) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            // Gradient Container
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, color.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${totalBalance.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('Income', style: TextStyle(color: Colors.white)),
                          SizedBox(height: 5),
                          Text('${totalIncome.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Expenses', style: TextStyle(color: Colors.white)),
                          SizedBox(height: 5),
                          Text('${totalExpenses.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddScreen()),
                    );
                  },
                  child: Text(
                    'Add Income',
                    style: TextStyle(color: color.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DeductScreen()),
                    );
                  },
                  child: Text(
                    'Deduct Expense',
                    style: TextStyle(color: color.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Transaction List
            Expanded(
              child: ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (_, __) => Divider(height: 20),
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: transaction['type'] == 'income' ? color.green : color.red,
                      child: Icon(
                        transaction['type'] == 'income' ? Icons.arrow_downward : Icons.arrow_upward,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(transaction['title']),
                    subtitle: Text(transaction['time']),
                    trailing: Text(
                      '${transaction['type'] == 'income' ? '+' : '-'}${transaction['amount'].toStringAsFixed(2)}',
                      style: TextStyle(
                        color: transaction['type'] == 'income' ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
