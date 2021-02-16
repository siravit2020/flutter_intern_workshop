/// Package import
import 'package:flutter/material.dart';


/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';


/// Local imports


/// Render the default doughnut chart.
class DoughnutDefault extends StatefulWidget{
  /// Creates the default doughnut chart.
 

  @override
  _DoughnutDefaultState createState() => _DoughnutDefaultState();
}

/// State class of doughnut chart.
class _DoughnutDefaultState extends State<DoughnutDefault>{
  _DoughnutDefaultState();

  @override
  Widget build(BuildContext context) {
    return _getDefaultDoughnutChart();
  }

  /// Return the circular chart with default doughnut series.
  SfCircularChart _getDefaultDoughnutChart() {
    return SfCircularChart(
      title: ChartTitle(text: 'Composition of ocean water'),
      legend: Legend(
          isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: _getDefaultDoughnutSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the doughnut series which need to be render.
  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'Chlorine', y: 55, text: '55%'),
      ChartSampleData(x: 'Sodium', y: 31, text: '31%'),
      ChartSampleData(x: 'Magnesium', y: 7.7, text: '7.7%'),
      ChartSampleData(x: 'Sulfur', y: 3.7, text: '3.7%'),
      ChartSampleData(x: 'Calcium', y: 1.2, text: '1.2%'),
      ChartSampleData(x: 'Others', y: 1.4, text: '1.4%'),
    ];
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          radius: '80%',
          explode: true,
          explodeOffset: '10%',
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: DataLabelSettings(isVisible: true))
    ];
  }
}
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color pointColor;

  /// Holds size of the datapoint
  final num size;

  /// Holds datalabel/text value mapper of the datapoint
  final String text;

  /// Holds open value of the datapoint
  final num open;

  /// Holds close value of the datapoint
  final num close;

  /// Holds low value of the datapoint
  final num low;

  /// Holds high value of the datapoint
  final num high;

  /// Holds open value of the datapoint
  final num volume;
}