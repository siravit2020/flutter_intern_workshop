import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:intl/intl.dart';

import 'DBHelper2.dart';
import 'note.dart';

class SQLite extends StatefulWidget {
  final String title;

  SQLite({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SQLiteState();
  }
}

class _SQLiteState extends State<SQLite> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Future<List<Note>> note;
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  int curUserId;
  bool isUpdate = false;
  Animatable<Color> background = TweenSequence<Color>(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Color(0xff515BD4).withOpacity(0.4),
          end: Color(0xff8134AF).withOpacity(0.4),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Color(0xff8134AF).withOpacity(0.4),
          end: Color(0xffDD2A7B).withOpacity(0.4),
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Color(0xffDD2A7B).withOpacity(0.4),
          end: Color(0xff515BD4).withOpacity(0.4),
        ),
      ),
    ],
  );
  final formKey = new GlobalKey<FormState>();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper2();
    refreshList();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    print(DateTime.now());
  }

  @override
  dispose() {
    _animationController.dispose(); // you need this
    super.dispose();
  }

  refreshList() {
    setState(() {
      note = dbHelper.getNotes();
    });
  }

  clearText() {
    titleController.text = '';
    messageController.text = '';
  }

  void insert() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM kk:mm').format(now);
    Note e =
        Note(null, titleController.text, messageController.text, formattedDate);
    dbHelper.save(e);
    clearText();
    refreshList();
  }

  void update() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM kk:mm').format(now);
    Note e = Note(
        curUserId, titleController.text, messageController.text, formattedDate);
    dbHelper.update(e);
    isUpdate = false;
    setState(() {});
    clearText();
    refreshList();
  }

  form() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextField(
              controller: titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
            ),
            Divider(
              height: 0,
              thickness: 1,
            ),
            TextField(
              controller: messageController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Message',
                border: InputBorder.none,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: (isUpdate) ? update : insert,
                  child: Text((isUpdate) ? 'UPDATE' : 'ADD'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {});
                    clearText();
                  },
                  child: Text('CANCEL'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListView listItem(List<Note> note) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: note.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        note[index].title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              curUserId = note[index].id;
                              // update();
                              titleController.text = note[index].title;
                              messageController.text = note[index].message;
                              isUpdate = true;
                              setState(() {});
                            },
                            child: Icon(Icons.edit,
                                size: 16, color: Colors.black.withOpacity(0.7)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              curUserId = note[index].id;
                              dbHelper.delete(note[index].id);
                              refreshList();
                            },
                            child: Icon(Icons.delete,
                                size: 16, color: Colors.black.withOpacity(0.7)),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(note[index].message,
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(0.7))),
                  SizedBox(
                    height: 10,
                  ),
                  Text(note[index].date,
                      style: TextStyle(fontSize: 12, color: Colors.black38)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: note,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listItem(snapshot.data);
          }
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              color: background
                  .evaluate(AlwaysStoppedAnimation(_animationController.value)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'SQLite test',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    form(),
                    SizedBox(
                      height: 8,
                    ),
                    list(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
