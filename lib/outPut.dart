import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class outPut extends StatefulWidget {
  final interest;
  final years;
  final deposit;
  final purchasePrice;
  final monthlyPayment;

  outPut(
      {this.interest,
      this.purchasePrice,
      this.deposit,
      this.years,
      this.monthlyPayment});

  @override
  _outPutState createState() => _outPutState();
}

class _outPutState extends State<outPut> {
  List<int> years = [];
  List<double> interests = [];
  List<double> capital = [];
  List<charts.Series<PercentagePay, int>> _seriesData;

  @override
  void initState() {
    // TODO: implement initState
    calculateInterests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualisations'),
      ),
      body: ListView(
        shrinkWrap: false,
        children: <Widget>[
          Center(
            child: Text(
              'Monthly Payment Data',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  color: Colors.red),
            ),
          ),
          Divider(
            color: Colors.blue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Bond Years",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(
                width: 30.0,
              ),
              Text(
                widget.years == null ? '  ' : "${widget.years}yrs",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Interest Rate",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(
                width: 30.0,
              ),
              Text(
                widget.interest == null ? '  ' : "${widget.interest}%",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Purchase Price",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(
                width: 30.0,
              ),
              Text(
                widget.purchasePrice == null
                    ? '  '
                    : "R${widget.purchasePrice}",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Paid Deposit",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(
                width: 30.0,
              ),
              Text(
                widget.deposit == null ? '  ' : "R${widget.deposit}",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Montly Payment",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(
                width: 30.0,
              ),
              Text(
                widget.monthlyPayment == null
                    ? '  '
                    : "R${widget.monthlyPayment.toStringAsFixed(2)}",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 25.0),
              interestTable()
            ],
          ),
        ],
      ),
    );
  }

  Widget interestTable() {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height*0.8,
        width: MediaQuery.of(context).size.width*0.8,
        child: ListView.builder(
            itemCount: years.length,
            itemBuilder: (BuildContext context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(years[index].toString()),
                  Text(interests[index].toStringAsFixed(3)),
                  Text(capital[index].toStringAsFixed(3)),
                ],
              );
            }),
      ),
    );
  }

  void calculateInterests() {
    double calInterest;
    double rate;
    double prevcumulativeInterest = 0;
    double yearlyPayable;

    yearlyPayable = widget.years * 12 * widget.monthlyPayment;

    rate = ((widget.interest / 12) / 100);
    calInterest =
        widget.years * 12 * widget.monthlyPayment - widget.purchasePrice;

    for (int i = 1; i <=widget.years; i++) {
      double cumulativeInterest =
          (((widget.purchasePrice * rate) - widget.monthlyPayment) *
                  ((pow((1 + rate), (i * 12)) - 1) / rate)) +
              (widget.monthlyPayment * i * 12);

      double percentageInterest =
          ((cumulativeInterest - prevcumulativeInterest) / yearlyPayable) * 100;
      prevcumulativeInterest = cumulativeInterest;
      interests.add(percentageInterest);
      capital.add(100 - percentageInterest);
      years.add(i);


    }

    print("Interest\n\n");
    print(interests);
    print('\n\nCapital\n\n');
    print(capital);
  }
}

/*class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {this.animate});

  factory GroupedBarChart.withSampleData() {
    return new GroupedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }

  /// Create series list with multiple series
  /*static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }*/
}*/

/// Sample ordinal data type.
class PercentagePay {
  int year;
  double percentage;

  PercentagePay(this.year, this.percentage);
}