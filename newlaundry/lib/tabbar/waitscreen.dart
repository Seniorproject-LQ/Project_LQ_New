import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WaitScreen extends StatefulWidget {
  final String customerID;
  WaitScreen(this.customerID);
  @override
  WaitScreenState createState() => WaitScreenState();
}

class WaitScreenState extends State<WaitScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[100],
        body: StreamBuilder(
          stream: Firestore.instance
              .collection("Customer")
              .doc(firebaseAuth.currentUser.uid)
              .collection("Confirmation")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('it can connect to firebase');
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot Confirmation =
                        snapshot.data.documents[index];
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 10, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/laundry-basket.png',
                                      height: 70, width: 70),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('ชื่อร้าน : ',
                                          style: TextStyle(
                                              color: Colors.blue[900],
                                              fontFamily: 'Prompt',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis),
                                      Text(Confirmation.data()['LaundryName'],
                                          style: TextStyle(
                                              color: Colors.blue[900],
                                              fontFamily: 'Prompt',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text('บริการ : ',
                                          style: TextStyle(
                                              color: Colors.blue[900],
                                              fontFamily: 'Prompt',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis),
                                      Text(Confirmation.data()['Service'],
                                          style: TextStyle(
                                              color: Colors.blue[900],
                                              fontFamily: 'Prompt',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text('ราคา : ',
                                          style: TextStyle(
                                              color: Colors.blue[900],
                                              fontFamily: 'Prompt',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis),
                                      Text(
                                          Confirmation.data()['Total']
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.blue[900],
                                              fontFamily: 'Prompt',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis),
                                      Text(
                                        '  บาท',
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontFamily: 'Prompt',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text('สถานะ : ',
                                          style: TextStyle(
                                              color: Colors.blue[900],
                                              fontFamily: 'Prompt',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis),
                                      Text(Confirmation.data()['Status'],
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'Prompt',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('ออร์เดอร์ : ',
                                          style: TextStyle(
                                              color: Colors.blue[900],
                                              fontFamily: 'Prompt',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis),
                                      IconButton(
                                          icon: Icon(Icons.list_alt),
                                          onPressed: () {
                                            List orders =
                                                Confirmation.data()['order'];
                                            showAlert(orders);
                                          })
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }

  void showAlert(List orders) {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        height: 400.0,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'คำสั่งออเดอร์',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontFamily: 'Prompt',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            order['Count'].toString() + ' x',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Prompt',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      title: Text(
                        order['Type'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Prompt',
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      trailing: Text(
                        order['Price'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Prompt',
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
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
                              'ปิด',
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
