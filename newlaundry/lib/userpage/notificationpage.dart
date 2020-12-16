import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String comment;
  String laundryID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'ประวัติการใช้งาน',
              style: TextStyle(
                  color: Colors.blue[900],
                  fontFamily: 'Prompt',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: Colors.blue[100],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 570,
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection("Customer")
                      .doc(firebaseAuth.currentUser.uid)
                      .collection("History")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print('it can connect to firebase');
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot History =
                                snapshot.data.documents[index];
                            laundryID = History.data()['LaundryID'];
                            return Card(
                              child: ListTile(
                                title: Container(
                                  margin: EdgeInsets.only(
                                      left: 0, right: 0, bottom: 0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('ชื่อร้าน : ',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue[900],
                                                          fontFamily: 'Prompt',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  Text(
                                                      History.data()[
                                                          'LaundryName'],
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue[900],
                                                          fontFamily: 'Prompt',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('บริการ : ',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue[900],
                                                          fontFamily: 'Prompt',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  Text(
                                                      History.data()['Service'],
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue[900],
                                                          fontFamily: 'Prompt',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('ราคา : ',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue[900],
                                                          fontFamily: 'Prompt',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  Text(
                                                      History.data()['Total']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue[900],
                                                          fontFamily: 'Prompt',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  Text('  บาท',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue[900],
                                                          fontFamily: 'Prompt',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('สถานะ : ',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue[900],
                                                          fontFamily: 'Prompt',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  Text(History.data()['Status'],
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontFamily: 'Prompt',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8, left: 200),
                                                    child: Container(
                                                      height: 30,
                                                      width: 105,
                                                      child: RaisedButton(
                                                        elevation: 0,
                                                        onPressed: () {
                                                          showAlert();
                                                        },
                                                        color: Colors.blue,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'ให้คะแนน',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Prompt',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> alert(String title, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Prompt',
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          );
        });
  }

  Future<void> createData(String comment) async {
    final databaseReference = Firestore.instance;

    await databaseReference
        .collection("Laundry")
        .document(laundryID)
        .collection("Review")
        .document()
        .setData({"Comment": comment}).then((value) {
      print('insert Successfully');
    });
  }

  void showAlert() {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 200.0,
        height: 300.0,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      'แสดงความคิดเห็น',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'Prompt',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TextFormField(
                  onChanged: (String string) {
                    comment = string.trim();
                    print('insert comment done');
                  },
                  decoration: InputDecoration(
                    filled: false,
                    contentPadding: EdgeInsets.only(left: 10.0, top: 10.0),
                    hintText: 'แสดงความคิดเห็น',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontFamily: 'Prompt',
                    ),
                    icon: Icon(Icons.comment, color: Colors.blue[900]),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      elevation: 0,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ยกเลิก',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Prompt',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    RaisedButton(
                      onPressed: () async {
                        if (comment == null) {
                          alert('Wrong', 'กรุณาแสดงความคิดเห็น');
                        } else {
                          createData(comment);
                          Navigator.pop(context);
                        }
                      },
                      elevation: 0,
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'บันทึก',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Prompt',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(context: context, child: dialog);
  }
}
