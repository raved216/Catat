import 'package:catat/Screens/InitialPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

main() {


  initializeDateFormatting().then((_){
    runApp(MaterialApp(
      home: InitialPage(),
      debugShowCheckedModeBanner: false,
    ));
  });

}


























//class Person {
//  String name, lastName, nationality;
//  int age;
//
//  void showName(){
//    print(this.name);
//    print(this.lastName);
//
//  }
//
//  void sayHello(){
//    print("Hello!");
//  }
//}
//
//class Vico extends Person{
//  String profession;
//
//  void showProfession() => print(profession);
//}
//
//class Krystal extends Person{
//  String profession;
//
//  void showProfession() => print(profession);
//  @override
//  void sayHello() {
//    // TODO: implement sayHello
//    print("Annyeong!");
//  }
//}
//
//main(List<String> arguments) {
//
//  var vico = new Vico();
//  vico.name = "Ravico";
//  vico.lastName = "Edward";
//  vico.profession = "Student";
//  vico.age = 24;
//  vico.sayHello();
//  vico.showName();
//  vico.showProfession();
//
//  var krystal = new Krystal();
//  krystal.name = "Jung Soo Jung";
//  krystal.profession = "Artist";
//  krystal.age = 26;
//  krystal.sayHello();
//  krystal.showName();
//  krystal.showProfession();
//
//}