import 'dart:io';

import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:file_picker/file_picker.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PDFReadAndWrite extends StatefulWidget {
  @override
  _PDFReadAndWriteState createState() => _PDFReadAndWriteState();
}

class _PDFReadAndWriteState extends State<PDFReadAndWrite> {
  TextEditingController _controller = TextEditingController();
  void staty() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              pw.Header(
                level: 0,
                child: pw.Text("Test"),
              ),
              pw.Paragraph(text: _controller.text)
            ];
          }),
    );
    final String dir = (await getTemporaryDirectory()).path;

    print(dir);
    // final file = File("$dir/example.pdf");
    // await file.writeAsBytes(await pdf.save());
    await Printing.sharePdf(
        bytes: await pdf.save(), filename: 'my-document.pdf');
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PreviewPDF(
                doc: pdf,
              )),
    );
  }

  Future<void> _pickDir(BuildContext context) async {
    String path = await FilePicker.platform.getDirectoryPath();

    print('path $path');

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              pw.Header(
                level: 0,
                child: pw.Text("Test"),
              ),
              pw.Paragraph(text: _controller.text)
            ];
          }),
    );
    final file = File("$path/example.pdf");
    await file.writeAsBytes(await pdf.save());
  }

  void open(File file) async {
    PDFDocument doc = await PDFDocument.fromFile(file);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ShowPDF(
                doc: doc,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    BuildContext ctx = context;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "PDF",
              style: TextStyle(color: Colors.red, fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Text',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    _pickDir(ctx);
                  },
                ),
                FlatButton(
                  child: Text("Genarate"),
                  onPressed: () {
                    staty();
                  },
                ),
                FlatButton(
                  child: Text("Open form file"),
                  onPressed: () async {
                    FilePickerResult result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );
                    if (result != null) {
                      File file = File(result.files.single.path);

                      open(file);
                      print(file.path);
                    } else {
                      // User canceled the picker
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PreviewPDF extends StatelessWidget {
  final doc;

  const PreviewPDF({Key key, this.doc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) => doc.save(),
    );
  }
}

class ShowPDF extends StatelessWidget {
  final PDFDocument doc;

  const ShowPDF({Key key, this.doc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PDFViewer(
      document: doc,
    );
  }
}
