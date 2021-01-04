import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {


  double _invAmount = 0.0;
  int _years = 0;
  int _percentage = 0;
  double _earning = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.blueAccent.shade100,
                borderRadius: BorderRadius.circular(12.0),

              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total Investment", style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: Colors.white
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("${calculateTotalInvestment(_invAmount, _years, _percentage, _earning)}", style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on),
                    ),
                    onChanged: (String value) {
                      try {
                        _invAmount = double.parse(value);
                      } catch (exception) {
                        _invAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Years", style: TextStyle(
                          color: Colors.grey.shade700
                      ),),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_years > 1) {
                                  _years--;
                                } else {

                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.blueAccent.shade100,
                              ),
                              child: Center(
                                child: Text(
                                  "-", style: TextStyle(
                                    color: Colors.blueAccent.shade400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0
                                ),
                                ),
                              ),
                            ),
                          ),
                          Text("$_years", style: TextStyle(
                              color: Colors.blueAccent.shade400,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0
                          ),),
                          InkWell(
                            onTap: () {
                              setState(() {
                                {
                                  _years++;
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.blueAccent.shade100,
                              ),
                              child: Center(
                                child: Text(
                                  "+", style: TextStyle(
                                    color: Colors.blueAccent.shade400,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold
                                ),
                                ),
                              ),
                            ),
                          ),
                          //Percentage

                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Earning", style: TextStyle(
                        color: Colors.grey.shade700,
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("${calculateTotalEarning(_percentage, _invAmount, _earning, _years)}",
                          style: TextStyle(
                              color: Colors.blueAccent.shade400,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold
                          ),),
                      )
                    ],
                  ),
                  //Slider
                  Column(
                    children: <Widget>[
                      Text("$_percentage%", style: TextStyle(
                          color: Colors.blueAccent.shade400,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                      ),),

                      Slider(
                          min: 0,
                          max: 20,
                          activeColor: Colors.blueAccent.shade400,
                          inactiveColor: Colors.grey,
                          divisions: 20,
                          value: _percentage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _percentage = newValue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalInvestment( double invAmount, int years, int percentage, double earning) {
    var totalInvestment = (calculateTotalEarning(percentage, invAmount, earning, years)) + invAmount;

    return totalInvestment;
  }

  calculateTotalEarning(int percentage, double invAmount, double earning, int years) {
  double totalEarning = 0.0;

  if (invAmount < 0 || invAmount.toString().isEmpty || invAmount == null){

  }else{
    totalEarning = ((percentage / 100 / 12)*(years * 12)*invAmount);
  }
  return totalEarning;
  }
}