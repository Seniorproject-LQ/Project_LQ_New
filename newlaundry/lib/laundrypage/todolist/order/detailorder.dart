import 'package:flutter/material.dart';

class DetailOrder extends StatefulWidget {
  final List order;
  DetailOrder({Key key, @required this.order}) : super(key: key);
  @override
  DetailOrderState createState() => DetailOrderState();
}

class DetailOrderState extends State<DetailOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 50, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                'คำสั่งออเดอร์',
                style: TextStyle(
                    color: Colors.blue[900],
                    fontFamily: 'Prompt',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 500,
              child: ListView.builder(
                  itemCount: widget.order.length,
                  itemBuilder: (context, index) {
                    final order = widget.order[index];
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
            )
          ]),
        ),
      ),
    );
  }
}
