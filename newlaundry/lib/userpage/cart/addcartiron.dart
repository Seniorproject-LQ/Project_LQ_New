import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newlaundry/navigationbar.dart';

// ignore: must_be_immutable
class AddCartIronPage extends StatefulWidget {
  final String laundryUID;
  final String name;
  final String customerFname;

  List sumtotal = [];

  int total;

  AddCartIronPage(this.laundryUID, this.name, this.customerFname,
      this.sumtotal, this.total);
  @override
  AddCartIronState createState() => AddCartIronState();
}

class AddCartIronState extends State<AddCartIronPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String iron = "รีด";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 35, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  'สรุปรายการ',
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontFamily: 'Prompt',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10, height: 10),
                            Text(
                              widget.name,
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Prompt',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 10, height: 10),
                            Text(
                              widget.customerFname,
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Prompt',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(width: 34, height: 10),
                            Text(
                              iron,
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Prompt',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 420,
                child: ListView.builder(
                    itemCount: widget.sumtotal.length,
                    itemBuilder: (context, index) {
                      final type = widget.sumtotal[index];                      
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
                              type['Count'].toString() + ' x',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Prompt',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        title: Text(
                          type['Type'].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Prompt',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: Text(
                          type['Price'].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Prompt',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            "รวมทั้งหมด",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Prompt',
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 130),
                          child: Text(
                            widget.total.toString() + "    บาท",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Prompt',
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                height: 50,
                width: 200,
                child: RaisedButton(
                  elevation: 0,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: Text(
                    'ส่งรายการ',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Prompt',
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    AlertDialog dialog = new AlertDialog(
      title: Center(
        child: Text(
          "ยืนยันการทำรายการ",
          style: TextStyle(
              color: Colors.red,
              fontFamily: 'Prompt',
              fontSize: 18,
              fontWeight: FontWeight.w400),
        ),
      ),
      content: new Container(
        height: 50,
        child: new Column(
          children: <Widget>[
            Container(
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
                  SizedBox(width: 30),
                  RaisedButton(
                    onPressed: () {
                      insertinformation();
                      alert('ทำรายการสำเร็จแล้ว', 'กลับหน้าแรก');
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
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationBarPage()),
                  );
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

  Future<void> insertinformation() async {
    final databaseReference = Firestore.instance;

    Map<String, dynamic> customer = Map();
    customer['CustomerName'] = widget.customerFname;
    customer['LaundryName'] = widget.name;
    customer['LaundryID'] = widget.laundryUID;
    customer['Total'] = widget.total;
    customer['Service'] = iron;
    customer['Status'] = 'นำผ้าไปส่ง';
    customer['order'] = widget.sumtotal;
    await databaseReference
        .collection('Customer')
        .doc(firebaseAuth.currentUser.uid)
        .collection("Confirmation")
        .doc(firebaseAuth.currentUser.uid)
        .setData(customer)
        .then((value) {
      print('insert Successfully');
    });

    Map<String, dynamic> laundry = Map();
    laundry['CustomerName'] = widget.customerFname;
    laundry['LaundryName'] = widget.name;
    laundry['LaundryID'] = widget.laundryUID;
    laundry['Total'] = widget.total;
    laundry['Service'] = iron;
    laundry['Status'] = 'รอออร์เดอร์';
    laundry['order'] = widget.sumtotal;
    await databaseReference
        .collection("OrderLaundry")
        .doc(widget.laundryUID)
        .collection("Confirmation")
        .doc(firebaseAuth.currentUser.uid)
        .setData(laundry)
        .then((value) {
      print('insert service Successfully');
    });
  }
}