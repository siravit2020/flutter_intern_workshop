import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_intern_workshop/another_chart/default_doughnut_chart.dart';
import 'package:flutter_intern_workshop/another_chart/sam1.dart';
import 'package:flutter_intern_workshop/chart/chart.dart';

import 'package:flutter_intern_workshop/chart/sanmeple4.dart';
import 'package:flutter_intern_workshop/fingerprint/fingerprint.dart';
import 'package:flutter_intern_workshop/pdf/pdf_gen_and_read.dart';
import 'package:flutter_intern_workshop/qrcod_barcode/qrcode.dart';
import 'package:flutter_intern_workshop/sqlite/sql.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Total(),
    );
  }
}

class PageRoute {
  String title;
  Widget widget;
  PageRoute(this.title, this.widget);
}

List pageList = [
  PageRoute(
    'SQLite',
    SQLite(),
  ),
  PageRoute(
    'QRCode And BarCode',
    QRCodeAndBarcode(),
  ),
  PageRoute(
    'Fingerprint',
    Fingerprint(),
  ),
  PageRoute(
    'Chart',
    ChartAll(),
  ),
  PageRoute(
    'PDF',
    PDFReadAndWrite(),
  ),
];

class Total extends StatelessWidget {
  const Total({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Workshop",
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (PageRoute item in pageList)
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => item.widget),
                          );
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 9,
                                  offset:
                                      Offset(0, 2), // changes position of shadow
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Text(
                              item.title,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
