import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newlaundry/userpage/cart/addcartfold.dart';

class DetailServiceFoldPage extends StatefulWidget {
  final String laundryUID;
  final String name;
  final String customerFname;

  DetailServiceFoldPage(this.laundryUID, this.name, this.customerFname);

  @override
  DetailServiceFoldState createState() => DetailServiceFoldState();
}

class DetailServiceFoldState extends State<DetailServiceFoldPage> {
  List<int> sum = [];
  List<String> productID = [];
  //add this valuse
  List totalproduct = [];
  List typeofproductList = [];
  Set typeofproduct = new Set();
  List<dynamic> totalproductList = [];
  List<dynamic> sumtotal = [];

  var choose = Map();
  var order = new Map();

  String type;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  int count = 0, price = 0, total = 0, count2 = 0;

  @override
  void initState() {
    super.initState();
  }

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
                  'รายการซักพับ',
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontFamily: 'Prompt',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 40, left: 40),
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
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 500,
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection("Laundry")
                        .document(widget.laundryUID)
                        .collection("TypeOfService")
                        .document("typeofservice")
                        .collection("Fold")
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
                              DocumentSnapshot TypeOfService =
                                  snapshot.data.documents[index];
                              print(TypeOfService.documentID);
                              return Stack(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
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
                                                TypeOfService.data()['Type'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Prompt',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                TypeOfService.data()['Price'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Prompt',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (count != 0) {
                                                        setState(() {
                                                          if (!choose.containsKey(
                                                              TypeOfService
                                                                      .data()[
                                                                  'Type'])) {
                                                            count = choose[
                                                                TypeOfService
                                                                    .documentID] = 1;
                                                          } else {
                                                            count = choose[
                                                                TypeOfService
                                                                    .documentID] -= 1;
                                                          }
                                                          print(
                                                              'test2 ==>${choose[TypeOfService.documentID]}');
                                                          typeofproduct.add(
                                                              TypeOfService
                                                                          .data()[
                                                                      'Type']
                                                                  .toString());
                                                          print(typeofproduct
                                                              .toList());

                                                          print(
                                                              'sumtotal ==> $sumtotal');
                                                          sumtotal.removeLast(
                                                              // TypeOfService.data()['Type']
                                                              //  count,
                                                              //  int.parse(TypeOfService.data()['Price'])
                                                              );
                                                          print(
                                                              'sumtotal ==> $sumtotal');
                                                          print(
                                                              'typeofproductList ==> $typeofproductList');

                                                          print(
                                                              'totalproduct ==> $totalproduct');
                                                          print(
                                                              'totalproductList ==>$totalproductList');

                                                          sum.remove(int.parse(
                                                              TypeOfService
                                                                      .data()[
                                                                  'Price']));

                                                          total = sum.reduce(
                                                              (value, element) =>
                                                                  value +
                                                                  element);
                                                          print('sum ==> $sum');
                                                          print(
                                                              'total ==> $total');
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
                                                    choose[TypeOfService
                                                                .documentID] !=
                                                            null
                                                        ? "${choose[TypeOfService.documentID]}"
                                                        : 0.toString(),
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
                                                      setState(() {
                                                        if (!choose.containsKey(
                                                            TypeOfService
                                                                .documentID)) {
                                                          count = choose[
                                                              TypeOfService
                                                                  .documentID] = 1;
                                                        } else {
                                                          count = choose[
                                                              TypeOfService
                                                                  .documentID] += 1;
                                                        }
                                                        productID.add(
                                                            TypeOfService
                                                                .documentID);

                                                        typeofproduct.add(
                                                            TypeOfService
                                                                        .data()[
                                                                    'Type']
                                                                .toString());
                                                        totalproduct.add({
                                                          "Type": TypeOfService
                                                                      .data()[
                                                                  'Type']
                                                              .toString(),
                                                          "Count": count,
                                                          "Price": int.parse(
                                                              TypeOfService
                                                                      .data()[
                                                                  'Price'])
                                                        });
                                                        print(typeofproduct
                                                            .toList());
                                                        List totalproductList =
                                                            [];
                                                        typeofproductList =
                                                            typeofproduct
                                                                .toList();
                                                        for (var i = 0;
                                                            i <
                                                                typeofproductList
                                                                    .length;
                                                            i++) {
                                                          List temp = [];
                                                          List price = [];
                                                          for (var j = 0;
                                                              j <
                                                                  totalproduct
                                                                      .length;
                                                              j++) {
                                                            if (totalproduct[j]
                                                                    ["Type"] ==
                                                                typeofproductList[
                                                                    i]) {
                                                              temp.add(
                                                                  totalproduct[
                                                                          j][
                                                                      "Count"]);
                                                              price.add(
                                                                  totalproduct[
                                                                          j][
                                                                      "Price"]);
                                                            }
                                                          }
                                                          totalproductList.add({
                                                            "Type":
                                                                typeofproductList[
                                                                    i],
                                                            "Count": temp
                                                                .reduce((curr,
                                                                        next) =>
                                                                    curr > next
                                                                        ? curr
                                                                        : next),
                                                            "Price": price
                                                                .reduce((value,
                                                                        element) =>
                                                                    value +
                                                                    element)
                                                          });
                                                        }
                                                        sumtotal =
                                                            totalproductList
                                                                .toList();
                                                        print(
                                                            'sumtotal ==>$sumtotal');
                                                        print(
                                                            'totalproductList ==> $totalproductList');
                                                        print(
                                                            'totalproduct ==> $totalproduct');

                                                        sum.add(int.parse(
                                                            TypeOfService
                                                                    .data()[
                                                                'Price']));
                                                        TypeOfService.data()[
                                                            'Type'];

                                                        total = sum.reduce(
                                                            (value, element) =>
                                                                value +
                                                                element);
                                                        print('sum ==> $sum');
                                                        print(
                                                            'total ==> $total');
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
                    }),
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
                          "$total บาท",
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
                          "ยืนยัน",
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
                                builder: (context) => AddCartFoldPage(
                                    widget.laundryUID,
                                    widget.name,
                                    widget.customerFname,
                                    sumtotal,
                                    total)),
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
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
