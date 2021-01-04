import 'dart:ui';
import 'package:catat/Widgets/CustomDialog.dart';
import 'package:catat/Widgets/ItemTransaction.dart';
import 'package:catat/db_process.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String current = "";
  var total;
  var width;
  var height;
  bool recDesp = false;
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  TransactionHelper transHelper = TransactionHelper();
  TextEditingController _valueController = TextEditingController();
  CalendarController calendarController;
  TransactionHelper transactionHelper = TransactionHelper();
  List<Transaction> listtransaction = List();
  List<Transaction> remove = List();

  var currentDate = new DateTime.now();
  var formatDate = new DateFormat('dd-MM-yyyy');
  var calendarFormat = new DateFormat('MM-yyyy');
  String dateFormat;

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  _addValue() {
    String value = _valueController.text;
    setState(() {
      current = value;
    });
  }

  _totalValue(String content) {
    if (content.length > 8) {
      return width * 0.08;
    } else {
      return width * 0.1;
    }
  }

  _save() {
    dateFormat = formatDate.format(currentDate);
    Transaction trans = Transaction();
    trans.value = 20.50;
    trans.type = "r";
    trans.date = "10-03-2020"; //dateFormat;
    trans.description = "CashBack";
    TransactionHelper transactionHelper = TransactionHelper();
    transactionHelper.savetransaction(trans);
    trans.toString();
  }

  _allTrans() {
    transactionHelper.getAllTransaction().then((list) {
      setState(() {
        listtransaction = list;
      });
      print("All Transactions: $listtransaction");
    });
  }

  _allTransByMonth(String data) {
    transactionHelper.getAllTransactionByMonth(data).then((list) {
      if (list.isNotEmpty) {
        setState(() {
          listtransaction = list;
          //total =listtransaction.map((item) => item.value).reduce((a, b) => a + b);
        });
        total =
            listtransaction.map((item) => item.value).reduce((a, b) => a + b);
        current = format(total).toString();
      } else {
        setState(() {
          listtransaction.clear();
          total = 0;
          current = total.toString();
        });
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calendarController = CalendarController();
    // ignore: unrelated_type_equality_checks
    if (DateTime.now().month != false) {

    }
    dateFormat = calendarFormat.format(currentDate);
    print(dateFormat);
    _allTransByMonth(dateFormat);

    //_allMov();
  }

  _dialogAddRecDesp() {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    _allTransByMonth(dateFormat);
    return Scaffold(
      key: _scafoldKey,
      body: SingleChildScrollView(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        //physics: ClampingScrollPhysics(),
        //height: height,
        //width: width,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: height * 0.335, //300,
                  color: Colors.white,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      width: double.infinity,
                      height: height * 0.28, //250,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[700], //Colors.indigo[400],
                      )),
                ),
                Positioned(
                  top: width * 0.18, //70
                  left: width * 0.07, //30,
                  child: Text(
                    "Catat",
                    style: TextStyle(
                        color: Colors.white, fontSize: width * 0.070 //30
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: width * 0.06, // 30,
                  right: width * 0.06, // 30,
                  child: Container(
                    height: height * 0.16, //150,
                    width: width * 0.1, // 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 5,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.05,
                            top: width * 0.04,
                            bottom: width * 0.02,
                          ),
                          child: Text(
                            "Total",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: width * 0.05),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.05),
                              child: Container(
                                width: width * 0.6,

                                child: Text(
                                  current,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.lightBlue[700], //Colors.indigo[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: _totalValue(current),
                                    //width * 0.1
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.04),
                              child: GestureDetector(
                                onTap: () {
                                  _dialogAddRecDesp();
                                },
                                child: Container(
                                  width: width * 0.12,
                                  height: width * 0.12, //65,
                                  decoration: BoxDecoration(
                                      color: Colors
                                          .lightBlue[700], //Colors.indigo[400],
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7,
                                          offset: Offset(2, 2),
                                        )
                                      ]),
                                  child: Icon(
                                    Icons.add,
                                    size: width * 0.07,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.008,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            TableCalendar(
              calendarController: calendarController,
              headerStyle: HeaderStyle(
                formatButtonShowsNext: false,
                formatButtonVisible: false,
                centerHeaderTitle: true,
              ),
              calendarStyle: CalendarStyle(outsideDaysVisible: false),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.transparent),
                weekendStyle: TextStyle(color: Colors.transparent),
              ),
              rowHeight: 0,
              initialCalendarFormat: CalendarFormat.month,
              onVisibleDaysChanged: (dateFirst, dateLast, CalendarFormat cf) {
                print(dateFirst);

                dateFormat = calendarFormat.format(dateFirst);
                _allTransByMonth(dateFormat);

                print("DATE FORMAT $dateFormat");

              },
            ),
            Padding(
                padding:
                EdgeInsets.only(left: width * 0.04, right: width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Transactions",
                      style: TextStyle(
                          color: Colors.grey[600], fontSize: width * 0.04),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.02),
                      child: Icon(
                        Icons.sort,
                        size: width * 0.07,
                        color: Colors.grey[400],
                      ),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.04, right: width * 0.04, top: 0),
              child: SizedBox(
                width: width,
                height: height * 0.47,
                child: ListView.builder(
                  itemCount: listtransaction.length,
                  itemBuilder: (context, index) {
                    Transaction trans = listtransaction[index];
                    Transaction ulttrans = listtransaction[index];
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        //_dialogConfirm(context, width, mov,index);

                        setState(() {
                          listtransaction.removeAt(index);
                        });
                        transactionHelper.deletetransaction(trans);
                        final snackBar = SnackBar(
                          content: Container(
                            padding: EdgeInsets.only(bottom: width * 0.025),
                            alignment: Alignment.bottomLeft,
                            height: height * 0.05,
                            child: Text(
                              "Undo Action",
                              style: TextStyle(
                                  color: Colors.white,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: width * 0.05),
                            ),
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.orange[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          action: SnackBarAction(
                            label: "Undo",
                            textColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                listtransaction.insert(index, ulttrans);
                              });

                              transactionHelper.savetransaction(ulttrans);
                            },
                          ),
                        );
                        _scafoldKey.currentState.showSnackBar(snackBar);
                      },
                      key: ValueKey(trans.id),
                      background: Container(
                        padding: EdgeInsets.only(right: 10 ,top: width * 0.04),
                        alignment: Alignment.topRight,
                        color: Colors.red,
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: width * 0.07,
                        ),
                      ),
                      child: ItemTransaction(
                        trans: trans,
                        lastItem: listtransaction[index] == listtransaction.last? true : false,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text( "EEEEEEEEE"),
            )
          ],
        ),
      ),
    );
  }
}
