import 'package:catat/db_process.dart';
import 'package:flutter/material.dart';
import 'CustomDialog.dart';

class ItemTransaction extends StatelessWidget {

  final Transaction trans;
  final bool lastItem;


  const ItemTransaction({Key key, this.trans,this.lastItem=false}) : super(key: key);

  _dialogConfirmation(BuildContext context, double width){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
              title: Text("Remove Transaction",textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightBlue[700]),),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.050)),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 20,),

                    Text("${trans.description}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: width * 0.045,color:trans.type.toString() =="r" ?Colors.green[600] : Colors.red[600])),
                    Text("IDR ${trans.value}",style: TextStyle(fontWeight: FontWeight.bold,color: trans.type.toString() =="r" ?Colors.green[600] : Colors.red[600])),


                    SizedBox(height: 40,),
                    Divider(color: Colors.grey[400],height: 2,),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            TransactionHelper transHelper = TransactionHelper();
                            transHelper.deletetransaction(trans);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: width * 0.02,
                                bottom: width * 0.02,
                                left: width * 0.03,
                                right: width * 0.03),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red[700],
                            ),
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.04),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
          );
        }
    );
  }

  _dialogEdit(BuildContext context, double width, Transaction transaction){
    print(transaction.toString());
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(trans: transaction,);
        });
  }
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;



    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            _dialogEdit(context, width, trans);
            //(context, width);
          },
          child: Container(
            //padding: EdgeInsets.all(width * 0.005),
            width: width,
            height: height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 10,
                              offset: Offset(2, 3)
                          )]
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(width * 0.03),
                          child:trans.type == "r"
                              ? Icon(Icons.arrow_downward,color: Colors.green,size: width * 0.06,)
                              : Icon(Icons.arrow_upward,color: Colors.red, size:width * 0.06)
                      ),
                    ),
                    Padding(
                        padding:  EdgeInsets.only(left: width * 0.03),
                        child: Container(
                          width: width * 0.4,
                          child: Text(trans.description,overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: TextStyle(
                            color:trans.type == "r" ? Colors.green[700]:Colors.red[700],
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.044,
                          ),),
                        )
                    ),
                  ],
                ),
                Text(trans.type == "r" ? "+ ${trans.value}" :" ${trans.value}", style: TextStyle(
                  color: trans.type == "r" ? Colors.green[700] : Colors.red[700],
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.044,

                ),),
              ],
            ),
          ),
        ),
        lastItem ==true ? Container(height:80,) : Container()
      ],
    );

  }
}