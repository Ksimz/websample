import 'package:flutter/material.dart';
import 'dart:math';

import 'package:websample/outPut.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double _interestRate;
  double _purchasePrice;
  double _depositPaid;
  int _bondYears;

  final _formKey = new GlobalKey<FormState>();

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Mortgage Calculator"))),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(25.0),
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  (MediaQuery.of(context).size.width) * 0.30,
                  0.0,
                  (MediaQuery.of(context).size.width) * 0.30,
                  0.0),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.attach_money),
                    hintText: 'Enter Purchase Price',
                    labelText: 'Price'),
                validator: (value) =>
                    value.isEmpty ? 'Value Can Not Be Empty' : null,
                onSaved: (value) => _purchasePrice = double.parse(value),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  (MediaQuery.of(context).size.width) * 0.30,
                  0.0,
                  (MediaQuery.of(context).size.width) * 0.30,
                  0.0),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    hintText: 'Enter Deposit Paid',
                    labelText: 'Deposit'),
                validator: (value) =>
                    value.isEmpty ? 'Value Can Not Be Empty' : null,
                onSaved: (value) => _depositPaid = double.parse(value),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  (MediaQuery.of(context).size.width) * 0.30,
                  0.0,
                  (MediaQuery.of(context).size.width) * 0.30,
                  0.0),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.rate_review),
                    hintText: 'Enter Interest Rate',
                    labelText: 'Rate'),
                validator: (value) =>
                    value.isEmpty ? 'Value Can Not Be Empty' : null,
                onSaved: (value) => _interestRate = double.parse(value),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  (MediaQuery.of(context).size.width) * 0.30,
                  0.0,
                  (MediaQuery.of(context).size.width) * 0.30,
                  0.0),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.timeline),
                    hintText: 'Enter Bond Years',
                    labelText: 'Years'),
                validator: (value) =>
                    value.isEmpty ? 'Value Can Not Be Empty' : null,
                onSaved: (value) => _bondYears = int.parse(value),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  (MediaQuery.of(context).size.width) * 0.35,
                  0.0,
                  (MediaQuery.of(context).size.width) * 0.35,
                  0.0),
              child: RaisedButton(
                child: Text("Calculate"),
                onPressed: () {
                  if (_validateAndSave()) {
                    double monthlyRate=CalculateMonthly();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => outPut(
                                interest: _interestRate,
                                deposit: _depositPaid,
                                purchasePrice: _purchasePrice,
                                years: _bondYears,
                                monthlyPayment: monthlyRate,
                              )),
                    );
                  }
                },
                color: Colors.blue,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                elevation: 5.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  double CalculateMonthly() {
    double rate = ((_interestRate / 12) / 100);
    int numberMonths = _bondYears * 12;

    if (rate != 0.0) {
      return ((rate *
              (_purchasePrice - _depositPaid) *
              pow((1 + rate), numberMonths)) /
          ((pow((1 + rate), numberMonths)) - 1));
    } else {
      return (_purchasePrice / numberMonths);
    }
  }
}
