import 'package:catat/db_process.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CustomDialog extends StatefulWidget {

  final Transaction trans;
  const CustomDialog({Key key, this.trans}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  var formatter = new DateFormat('dd-MM-yyyy');
  bool edit;

  int _groupValueRadio = 1;
  Color _colorContainer = Colors.green[400];
  Color _colorTextButtom = Colors.green;
  TextEditingController _controllerValue = TextEditingController();
  TextEditingController _controllerDesc = TextEditingController();
  TransactionHelper _transHelper = TransactionHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.trans != null){
      print(widget.trans.toString());

      edit = true;
      if(widget.trans.type == "d"){
        _groupValueRadio =2;
        _colorContainer = Colors.red[300];
        _colorTextButtom = Colors.red[300];
      }

      _controllerValue.text = widget.trans.value.toString().replaceAll("-", "");
      _controllerDesc.text = widget.trans.description;
    }else{
      edit = false;
    }
    print(" edit -> $edit");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.050)),
        title: Text(
          "Add Values",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: _colorContainer,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "IDR",
                    style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                  ),
                  Flexible(
                    child: TextField(
                        controller: _controllerValue,
                        maxLength: 8,
                        style: TextStyle(fontSize: width * 0.04),
                        keyboardType: TextInputType.number,
                        //keyboardType: TextInputType.numberWithOptions(decimal: true),
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        decoration: new InputDecoration(
                          hintText: "Input Value",
                          hintStyle: TextStyle(color: Colors.white54),
                          contentPadding:  EdgeInsets.only(
                              left: width * 0.04,
                              top: width * 0.041,
                              bottom: width * 0.041,
                              right: width * 0.04),//15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        )),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    activeColor: Colors.green[900],
                    value: 1,
                    groupValue: _groupValueRadio,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _groupValueRadio = value;
                        _colorContainer = Colors.green[400];
                        _colorTextButtom = Colors.green;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.01),
                    child: Text("Income", style: TextStyle(fontSize: width * 0.04),),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    activeColor: Colors.red[900],
                    value: 2,
                    groupValue: _groupValueRadio,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _groupValueRadio = value;
                        _colorContainer = Colors.red[300];
                        _colorTextButtom = Colors.red[300];
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.01),
                    child: Text("Expenses", style: TextStyle(fontSize: width * 0.04),),
                  )
                ],
              ),
              TextField(
                  controller: _controllerDesc,
                  maxLength: 20,
                  style: TextStyle(fontSize: width * 0.05),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    //hintText: "description",
                    labelText: "Description",
                    labelStyle: TextStyle(color: Colors.white54),
                    //hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding:  EdgeInsets.only(
                        left: width * 0.04,
                        top: width * 0.041,
                        bottom: width * 0.041,
                        right: width * 0.04),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: width * 0.09),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){

                        if(_controllerValue.text.isNotEmpty && _controllerDesc.text.isNotEmpty){
                          Transaction trans = Transaction();
                          String value;
                          if(_controllerValue.text.contains(",")){
                            value = _controllerValue.text.replaceAll( RegExp(","), ".");
                          }else{
                            value = _controllerValue.text;
                          }

                          trans.date = formatter.format(DateTime.now());
                          trans.description = _controllerDesc.text;

                          if(_groupValueRadio == 1){

                            trans.value = double.parse(value);
                            trans.type ="r";
                            if(widget.trans != null){ trans.id = widget.trans.id;}
                            edit == false ? _transHelper.savetransaction(trans) : _transHelper.updatetransaction(trans);
                          }
                          if(_groupValueRadio == 2){
                            trans.value = double.parse("-" + value);
                            trans.type ="d";
                            if(widget.trans != null){ trans.id = widget.trans.id;}
                            edit == false ? _transHelper.savetransaction(trans) : _transHelper.updatetransaction(trans);
                          }
                          Navigator.pop(context);
                          //initState();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: width * 0.02,
                            bottom: width * 0.02,
                            left: width * 0.03,
                            right: width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            edit == false ?"Confirm" : "Edit",
                            style: TextStyle(
                                color: _colorTextButtom,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
