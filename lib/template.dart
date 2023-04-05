import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REco',
      home: MyState(),
    );
  }
}

class MyState extends StatefulWidget {
  const MyState({super.key});
  @override
  REcoTemplate createState() => REcoTemplate();
}

class REcoTemplate extends State<MyState> {
  final tabs = [
    Container(
      color: Colors.black,
      child: const Center(
        child:
            SizedBox(height: 550, width: double.maxFinite,
             //   child: CameraApp(),
            ),
      ),
    ),
    Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 100),
      color: const Color(0xFFFCFFE7),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(12, (index) {
          index += 1;
          return Card(
            color: Colors.white,
            child: Center(
              child: Text(
                'Item $index',
              ),
            ),
          );
        }),
      ),
    ),
    Container(
      color: const Color(0xFFFCFFE7),
      child: const Center(child: Text('Recycling Page')),
    )
  ];
  final _pageViewController = PageController(initialPage:1);
  int _activePage = 1;
  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      //backgroundColor: const Color(0xffFEFAE0),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
        backgroundColor: const Color(0xFFAACB73),
        title: const Text(
          'REco',
          style: TextStyle(
            color: Color(0xFF2C3333),
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: PageView(
        controller: _pageViewController,
        children: tabs,
        onPageChanged: (index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activePage,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: (index) {
                _pageViewController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.bounceOut);
        },
        items: const [
          BottomNavigationBarItem(
              label: 'Camera',
              activeIcon: Icon(Icons.camera_alt,color: Colors.white),
              icon: Icon(Icons.camera_alt),
              backgroundColor: Colors.black /* , tooltip: ''*/),
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
              backgroundColor: Color(0xFFAACB73) /* , tooltip: ''*/),
          BottomNavigationBarItem(
              label: 'Collection',
              icon: Icon(Icons.collections_bookmark),
              backgroundColor: Colors.brown /* , tooltip: ''*/),
        ],
      ),
    );
  }
}



