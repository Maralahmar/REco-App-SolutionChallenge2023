
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REco'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.lightGreen,
              child: Text('profile!'),
              elevation: 5,
            ),
          ),
          //  Container(
          //   width: double.infinity,
          //   child: Image(
          //     color: Colors.lightGreen,

          //   ),
          // ),
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Name',icon: Icon(Icons.person),),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Email', icon: Icon(Icons.email),
                  ),),
                  TextField(
                    decoration: InputDecoration(labelText: 'Phone',icon: Icon(Icons.phone),),
                ),

                    TextField(
                    decoration: InputDecoration(labelText: 'About'),
                    ),

                ],
              ),
            ),
          ),
          Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'save',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                    ),]
                     ),
                 ],
                ),
    );
  }
}
