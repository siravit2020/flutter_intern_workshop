import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
            color: Color(0xff232d37)),
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: PieChart(
                PieChartData(
                    pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex = pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections()),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Color(0xff0293ee), shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Work",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: touchedIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: touchedIndex == 0
                            ? Colors.white
                            : Color(0xff67727d),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Color(0xfff8b250), shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Game",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: touchedIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: touchedIndex == 1
                            ? Colors.white
                            : Color(0xff67727d),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Color(0xff845bef), shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Netflix",
                     style: TextStyle(
                        fontSize: 16,
                        fontWeight: touchedIndex == 2
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: touchedIndex == 2
                            ? Colors.white
                            : Color(0xff67727d),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Color(0xff13d38e), shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Anime",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: touchedIndex == 3
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: touchedIndex == 3
                            ? Colors.white
                            : Color(0xff67727d),
                      ),
                    )
                  ],
                ),
                // Indicator(
                //   color: Color(0xff0293ee),
                //   text: 'First',
                //   isSquare: true,
                // ),
                // SizedBox(
                //   height: 4,
                // ),
                // Indicator(
                //   color: Color(0xfff8b250),
                //   text: 'Second',
                //   isSquare: true,
                // ),
                // SizedBox(
                //   height: 4,
                // ),
                // Indicator(
                //   color: Color(0xff845bef),
                //   text: 'Third',
                //   isSquare: true,
                // ),
                // SizedBox(
                //   height: 4,
                // ),
                // Indicator(
                //   color: Color(0xff13d38e),
                //   text: 'Fourth',
                //   isSquare: true,
                // ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 70 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
