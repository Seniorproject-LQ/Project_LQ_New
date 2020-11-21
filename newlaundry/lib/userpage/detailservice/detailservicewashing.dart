import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newlaundry/userpage/cart/addcart.dart';
import 'package:newlaundry/userpage/menu/menuservice.dart';

class DetailServiceWashingPage extends StatefulWidget {
  final Map map;
  const DetailServiceWashingPage({Key key, this.map}) : super(key: key);

  @override
  DetailServiceWashingState createState() => DetailServiceWashingState();
}

class DetailServiceWashingState extends State<DetailServiceWashingPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String type;
  int count = 0, sum = 0, price = 0;
  Map map;

  @override
  void initState() {
    map = widget.map;
  }

  void add() {
    setState(() {
      count++;
    });
  }

  void minus() {
    setState(() {
      if (count != 0) count--;
    });
  }

  /*void total() {
    setState(() {
      if (count != 0) {
        sum = price * count;
      }
    });
  }*/

  // DocumentReference laundtyID = Firestore.instance
  //     .collection("Laundry")
  //     .document('laundtyID.documentID')
  //     .collection("TypeOfService")
  //     .document();

  // DocumentSnapshot docSnap = await laundtyID.get();
  // var doc_id2 = docSnap.reference.documentID;

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuServicePage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  'รายการซักรีด',
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontFamily: 'Prompt',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 500,
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("Laundry")
                      .document(firebaseAuth.currentUser.uid)
                      .collection("TypeOfService")
                      .document("typeofservice")
                      .collection("Washing")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text('Some Error');
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print('it can connect to firebase of service');
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot typeOfClothes =
                                snapshot.data.documents[index];
                            //print(typeOfClothes.data());
                            print(typeOfClothes.documentID);
                            return Stack(
                              children: [
                                Container(
                                  // decoration: BoxDecoration(
                                  //   color: Colors.white,
                                  //   borderRadius: BorderRadius.circular(20),
                                  // ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          //color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          child: Image.asset(
                                              'assets/laundry-basket.png'),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 40),
                                        child: Column(
                                          children: [
                                            Text(
                                              typeOfClothes
                                                  .data()['Type']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Prompt',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              typeOfClothes
                                                  .data()['Price']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Prompt',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (count > 1) {
                                                      setState(() {
                                                        count--;
                                                        price = int.parse(
                                                            typeOfClothes
                                                                    .data()[
                                                                'Price']);
                                                        sum = price * count;

                                                        print(sum);
                                                        print(typeOfClothes
                                                            .data()['Price']);
                                                        print(
                                                            'count ==> $count');
                                                      });
                                                    }
                                                  },
                                                  child: Image.asset(
                                                      'assets/minus.png',
                                                      width: 30,
                                                      height: 30),
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                  '$count',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Prompt',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                SizedBox(width: 20),
                                                InkWell(
                                                  onTap: () {
                                                    // add();
                                                    setState(() {
                                                      count++;
                                                      price = int.parse(
                                                          typeOfClothes
                                                              .data()['Price']);
                                                      sum = price * count;
                                                      print(sum);
                                                      print(typeOfClothes
                                                          .data()['Price']);
                                                      print('sum  ==> $price');
                                                      print('count ==> $count');
                                                    });
                                                  },
                                                  child: Image.asset(
                                                      'assets/add.png',
                                                      width: 30,
                                                      height: 30),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    }
                  },
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 15),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "รวมทั้งหมด",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Prompt',
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "$sum บาท",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Prompt',
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          "ใส่ตระกร้า",
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontFamily: 'Prompt',
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCartPage()),
                          );
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
