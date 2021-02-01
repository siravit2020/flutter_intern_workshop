import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'dart:io';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:url_launcher/url_launcher.dart';

class QRCodeAndBarcode extends StatefulWidget {
  @override
  _QRCodeAndBarcodeState createState() => _QRCodeAndBarcodeState();
}

class _QRCodeAndBarcodeState extends State<QRCodeAndBarcode> {
  bool change = true;
  String url = 'https://youtu.be/5lx9T6RCV3s';

  final urlController = TextEditingController();

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      print("sss");
      print(barcodeScanRes);
      if (barcodeScanRes != null && barcodeScanRes != '-1') {
        //_launchURL(barcodeScanRes);

      }
    });
  }

  _launchURL(String u) async {
    String url = 'https://$u';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  child: SfBarcodeGenerator(
                    value: url,
                    symbology: (change) ? QRCode() : Code128A(),
                  ),
                ),
                 SizedBox(
                  height: 10,
                ),
                Linkify(
                  onOpen: (link) async {
                    if (await canLaunch(link.url)) {
                      await launch(link.url);
                    } else {
                      throw 'Could not launch $link';
                    }
                  },
                  text: "$url",
                  style: TextStyle(color: Colors.black),
                  linkStyle: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        change = true;
                        setState(() {});
                      },
                      color: (change) ? Colors.red : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      textColor: (change) ? Colors.white : Colors.red,
                      child: Text("QRCode"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        change = false;
                        setState(() {});
                      },
                      color: (change) ? Colors.white : Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      textColor: (change) ? Colors.red : Colors.white,
                      child: Text("BarCode"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 9,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                                controller: urlController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  hintText: 'Url',
                                )),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (urlController.text != null &&
                                  urlController.text != "") {
                                url = urlController.text;
                                setState(() {});
                              }
                            },
                            child: Text(
                              "Genarate",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      scanQR();
                    });
                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  textColor: Colors.white,
                  child: Text("Scan"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
