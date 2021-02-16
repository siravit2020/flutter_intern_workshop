import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 100, 70);
    final barGroup2 = makeGroupData(1, 200, 170);
    final barGroup3 = makeGroupData(2, 110, 50);
    final barGroup4 = makeGroupData(3, 60, 20);
    final barGroup5 = makeGroupData(4, 57, 42);
    final barGroup6 = makeGroupData(5, 146, 100);
    final barGroup7 = makeGroupData(6, 198, 140);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
            color: Color(0xff232d37)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  makeTransactionsIcon(),
                  const SizedBox(
                    width: 38,
                  ),
                  const Text(
                    'Frame per secound',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BarChart(
                    BarChartData(
                      maxY: 200,
                      barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                              tooltipPadding: EdgeInsets.all(0),
                              tooltipBottomMargin: 4,
                              tooltipBgColor: Colors.transparent,
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                    'AVG \n ${(rod.y - 1)}',
                                    TextStyle(
                                        color: Colors.yellow[300], fontSize: 14));
                              }),
                          touchCallback: (response) {
                            if (response.spot == null) {
                              print(response.spot);
                              setState(() {
                                touchedGroupIndex = -1;
                                showingBarGroups = List.of(rawBarGroups);
                              });
                              return;
                            }
                            
                            print(response.spot.touchedBarGroupIndex);
                            touchedGroupIndex =
                                response.spot.touchedBarGroupIndex;

                            setState(() {
                              
                              if (response.touchInput is FlLongPressEnd ||
                                  response.touchInput is FlPanEnd) {
                                print(response.touchInput);
                                touchedGroupIndex = -1;
                                showingBarGroups = List.of(rawBarGroups);
                              } else {
                                print(response.touchInput);
                                showingBarGroups = List.of(rawBarGroups);
                                if (touchedGroupIndex != -1) {
                                  double sum = 0;
                                  for (BarChartRodData rod
                                      in showingBarGroups[touchedGroupIndex]
                                          .barRods) {
                                    sum += rod.y;
                                  }
                                  final avg = sum /
                                      showingBarGroups[touchedGroupIndex]
                                          .barRods
                                          .length;

                                  showingBarGroups[touchedGroupIndex] =
                                      showingBarGroups[touchedGroupIndex]
                                          .copyWith(
                                    barRods: showingBarGroups[touchedGroupIndex]
                                        .barRods
                                        .map((rod) {
                                      return rod.copyWith(y: avg);
                                    }).toList(),
                                  );
                                }
                              }
                            });
                          }),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 20,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return 'GTA';
                              case 1:
                                return 'BTF';
                              case 2:
                                return 'PUBG';
                              case 3:
                                return 'FIFA';
                              case 4:
                                return 'APEX';
                              case 5:
                                return 'GOW';
                              case 6:
                                return 'FN';
                              default:
                                return 'PB';
                            }
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 32,
                          reservedSize: 14,
                          getTitles: (value) {
                            if (value == 0) {
                              return '0';
                            } else if (value == 50) {
                              return '50';
                            } else if (value == 100) {
                              return '100';
                            } else if (value == 150) {
                              return '150';
                            } else if (value == 200) {
                              return '200';
                            } else {
                              return '';
                            }
                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
