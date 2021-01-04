import 'package:catat/Screens/Calculator.dart';
import 'package:catat/Widgets/AnimatedBottomNavBar.dart';
import 'package:catat/Screens/Expenses.dart';
import 'package:catat/Screens/Homepage.dart';
import 'package:catat/Screens/Income.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class InitialPage extends StatefulWidget {

  final List<BarItem> barItems = [

    BarItem(
      text: "Expenses",
      iconData: Icons.remove_circle_outline,
      color: Colors.pinkAccent,
    ),

    BarItem(
      text: "Home",
      iconData:  Icons.home,
      color: Colors.indigo,
    ),

    BarItem(
      text: "Calculator",
      iconData: Icons.assignment,
      color: Colors.grey.shade900,
    ),

    BarItem(
      text: "Income",
      iconData: Icons.add_circle_outline,
      color: Colors.teal,
    ),

  ];

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  int selectedBarIndex = 1;




  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light // status bar color
    ));

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


    List<Widget> screen =[

      Expenses(),
      Homepage(),
      Calculator(),
      Income(),

    ];

    return Scaffold(
      body: screen[selectedBarIndex],
      bottomNavigationBar: AnimatedBottomBar(
        barItems: widget.barItems,
        animationDuration: const Duration(milliseconds: 150),
        barStyle: BarStyle(
            fontSize: width * 0.045,
            iconSize: width * 0.07
        ),
        onBarTap: (index){
          setState(() {
            selectedBarIndex = index;
          });
        },
      ),

    );
  }
}
