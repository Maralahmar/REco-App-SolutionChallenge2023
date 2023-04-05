import 'dart:math';

import 'package:flutter/material.dart';

import 'login_page.dart';

void main() => runApp(const Template1());

class Template1 extends StatefulWidget {
  const Template1({Key? key}) : super(key: key);

  @override
  State<Template1> createState() => _Template1State();
}

class _Template1State extends State<Template1> with AutomaticKeepAliveClientMixin {
  int count = 0;

  @override
  bool get wantKeepAlive=>true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('$count'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      setState(() {
                        count = 0;
                      });
                    },
                    label: const Text('Reset'),
                    icon: const Icon(Icons.refresh),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      setState(() {
                        count = count + 1;
                      });
                    },
                    label: const Text('Add'),
                    icon: const Icon(Icons.add),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
