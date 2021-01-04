import 'package:catat/db_process.dart';
import 'package:catat/Widgets/TimelineItem.dart';
import 'package:flutter/material.dart';

class Income extends StatefulWidget {
  @override
  _IncomeState createState() => _IncomeState();
}

class _IncomeState extends State<Income> {

  TransactionHelper transactionHelper = TransactionHelper();
  List<Transaction> listtransaction = List();

  _allTransByType() {
    transactionHelper.getAllTransactionByType("r").then((list) {
      setState(() {
        listtransaction = list;
      });
      print("All transaction(s): $listtransaction");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allTransByType();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.7),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: width * 0.05,top: width * 0.2),
              child: Text("Incomes",style: TextStyle(
                  color: Colors.white ,//Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.08
              ),),

            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.03, top: width * 0.08),
              child: SizedBox(
                width: width,
                height: height * 0.74,
                child: ListView.builder(
                  itemCount: listtransaction.length,
                  itemBuilder: (context, index){
                    List transReverse = listtransaction.reversed.toList();
                    Transaction trans = transReverse[index];


                    if(transReverse[index] == transReverse.last){
                      return TimelineItem(trans: trans, colorItem: Colors.green[900],isLast: true,);
                    }else{
                      return TimelineItem(trans: trans,colorItem: Colors.green[900],isLast: false,);
                    }

                  },
                ),
              ),

            ),

          ],
        ),
      ),

    );
  }
}