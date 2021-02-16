import 'package:flutter/material.dart';

import 'bar_chart.dart';
import 'line_chart.dart';
import 'pie_chart.dart';

class ChartAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: SingleChildScrollView(
          child: Column(
            children: [
              //SynChat()
              LineChartSample2(),
              PieChartSample2(),
              BarChartSample2(),
              // BarChartSample1()
            ],
          ),
        ),
      ),
    );
  }
}
