import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  final List<String> data = [];

  ListViewBuilder() {
    for (int i = 0; i < 5; i++) {
      data.add(i.toString());
    }
  }

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(  'Report'),
//                 backgroundColor: Config.main_colors,
        elevation: 0.0,
      ),
      resizeToAvoidBottomPadding: true,
      body:
      new ListView(
        shrinkWrap: true,
        reverse: false,
        children: <Widget>[
       new SizedBox(height: 20.0,),
       new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        new Padding(
        padding: const EdgeInsets.all(16.0),
         child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            SizedBox(
                height: 320.0,
                child: SimpleSeriesLegend.withSampleData('test')),

            SizedBox(
              height: 200.0,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) =>
                      Center(
                       child: new AnimatedCircularChart(
//                      key: _chartKey,
                      size: Size(100.0, 100.0),
                      initialChartData: <CircularStackEntry>[
                        new CircularStackEntry(
                          <CircularSegmentEntry>[
                            new CircularSegmentEntry(
                              50.33,
                              Colors.green[400],
                              rankKey: 'completed',
                            ),
                            new CircularSegmentEntry(
                              66.67,
                              Colors.blueGrey[600],
                              rankKey: 'remaining',
                            ),
                          ],
                          rankKey: 'progress',
                        ),
                      ],
                      chartType: CircularChartType.Radial,
                      percentageValues: true,
                      holeLabel: '1.5/3',
                      labelStyle: new TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),

                ),

              ),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) =>
                    Container(
                      padding: const EdgeInsets.all(10.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[

                           new AnimatedCircularChart(
//                      key: _chartKey,
                             size: Size(100.0, 100.0),
                             initialChartData: <CircularStackEntry>[
                               new CircularStackEntry(
                                 <CircularSegmentEntry>[
                                   new CircularSegmentEntry(
                                     50.33,
                                     Colors.green[400],
                                     rankKey: 'completed',
                                   ),
                                   new CircularSegmentEntry(
                                     66.67,
                                     Colors.blueGrey[600],
                                     rankKey: 'remaining',
                                   ),
                                 ],
                                 rankKey: 'progress',
                               ),
                             ],
                             chartType: CircularChartType.Radial,
                             percentageValues: true,
                             holeLabel: '1.5/3',
                             labelStyle: new TextStyle(
                               color: Colors.black,
                               fontWeight: FontWeight.bold,
                               fontSize: 24.0,
                             ),
                           ),
                           new Text('item number'+index.toString(),
                             style: new TextStyle(
                                 fontSize: 20.0,
                                 color: Colors.lightBlueAccent),
                           ),
                         ],
                       ),
                  ),

                ),

              ),
            SizedBox(
              height: 120.0,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) =>
                      Center(
                       child:new AnimatedCircularChart(
//                      key: _chartKey,
                       size: const Size(90.0, 90.0),
                       initialChartData: [
                        new CircularStackEntry(
                          <CircularSegmentEntry>[
                            new CircularSegmentEntry(74.0, Colors.greenAccent, rankKey: 'Q1'),
                            new CircularSegmentEntry(26.0,  const Color.fromRGBO(0, 0, 0, 0.5),
                                rankKey: 'Q2'),
                          ],
                          rankKey: 'Quarterly Profits',
                        ),
                      ],
                      holeLabel: '50 %',
                      labelStyle: new TextStyle(
                        color: Colors.black,
                      ),
                      chartType: CircularChartType.Radial,
                    ),
                  ),
                ),
              ),

          ],
        ),
      )),
    ]
    )]));
  }
}
class SimpleSeriesLegend extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleSeriesLegend(this.seriesList, {this.animate});

  factory SimpleSeriesLegend.withSampleData(test) {
    return new SimpleSeriesLegend(
      _createSampleData(test),
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
        customSeriesRenderers: [
          new charts.BarRendererConfig(
            // ID used to link series to this renderer.
              customRendererId: 'customBar')
        ] ,
      defaultRenderer: new charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(30)),
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      behaviors: [
        new charts.SlidingViewport(),
        new charts.PanAndZoomBehavior(),
        new charts.SeriesLegend(),
      ],
    domainAxis: new charts.OrdinalAxisSpec(
          viewport: new charts.OrdinalViewport('', 2)),
    );
  }
  static List<charts.Series<OrdinalSales, String>> _createSampleData(test) {
    print('test is $test');
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
      new OrdinalSales('20171', 75),
      new OrdinalSales('20173', 75),
      new OrdinalSales('20172', 75),
      new OrdinalSales('201733', 75),
      new OrdinalSales('201722', 75),
      new OrdinalSales('20175', 75),
    ];

    final tabletSalesData = [
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

    final otherSalesData = [
      new OrdinalSales('2014', 20),
      new OrdinalSales('2015', 35),
      new OrdinalSales('2016', 15),
      new OrdinalSales('2017', 10),
    ];
    final otherSalesData1 = [
      new OrdinalSales('2014', 20),
      new OrdinalSales('2015', 35),
      new OrdinalSales('2016', 15),
      new OrdinalSales('2017', 10),
    ];
    final otherSalesData11 = [
      new OrdinalSales('2014', 20),
      new OrdinalSales('2015', 35),
      new OrdinalSales('2016', 15),
      new OrdinalSales('2017', 10),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tabletSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Other',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: otherSalesData1,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Other',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: otherSalesData11,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Other',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: otherSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
