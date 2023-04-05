import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reco/startuptemplate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';


late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp3());
}

class MyApp3 extends StatelessWidget {
  const MyApp3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'REco',
        home: MyState(),
      ),
    );
  }
}

class MyState extends StatefulWidget {
  const MyState({super.key});
  @override
  REcoTemplate createState() => REcoTemplate();
}

class REcoTemplate extends State<MyState> {
  int x = 0;
  int count = 0;
  final _pageViewController = PageController(initialPage: 1);
  int _activePage = 1;
  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      //backgroundColor: const Color(0xffFEFAE0),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      appBar: AppBar(
        flexibleSpace: Container(
            alignment: AlignmentDirectional.topStart,
            margin: const EdgeInsets.only(top: 7, left: 5),
            child: const Image(
              color: Color(0xff2C3333),
              image: AssetImage('assets/playstore.png'),
              height: 40,
              width: 40,
            )),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Color(0xff2C3333),
            ),
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
        backgroundColor: const Color(0xFFAACB73),
        title: const Text(
          '    REco',
          style: TextStyle(
            color: Color(0xFF2C3333),
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: PageView(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        controller: _pageViewController,
        children: [
          Container(
            color: Colors.black,
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width,
                child: const CameraApp(),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                  color: const Color(0xFFFCFFE7),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Text(
                        '   Recycle Me',
                        style: GoogleFonts.shadowsIntoLight(
                            textStyle: const TextStyle(
                                fontSize: 60,
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      )
                    ],
                  )),
              Container(
                padding: const EdgeInsets.only(
                    top: 0, left: 15, right: 15, bottom: 0),
                color: const Color(0xFFFCFFE7),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.3304,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      customCard('assets/plastic.jpg', 'Plastic', Colors.grey,
                          null, context),
                      customCard('assets/glass.jpg', 'Glass',
                          Colors.lightBlueAccent, null, context),
                      customCard('assets/clothes.jpg', 'Clothes',
                          Colors.yellowAccent, null, context),
                      customCard('assets/batteries.jpg', 'Batteries',
                          Colors.black38, null, context),
                      customCard('assets/wood.jpg', 'Wood', Colors.green, null,
                          context),
                      customCard('assets/food.jpg', 'Food', Colors.deepOrange,
                          null, context),
                      customCard('assets/appliances.jpg', 'Appliances',
                          Colors.blue, null, context),
                      customCard('assets/metals.webp', 'Metals', Colors.black,
                          Colors.white, context),
                      customCard('assets/rubber.webp', 'Rubber',
                          Colors.greenAccent, null, context),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Template1(),
        ],
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
              duration: const Duration(milliseconds: 700),
              curve: Curves.fastOutSlowIn);
        },
        items: const [
          BottomNavigationBarItem(
              label: 'Camera',
              activeIcon: Icon(Icons.camera_alt, color: Colors.white),
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

class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraPreview(controller),
    );
  }
}

Widget customCard(
    String url, String text, Color color, Color? color1, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Template1())),
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      elevation: 0.15,
      color: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: AssetImage(url),
              height: 143,
              fit: BoxFit.cover,
            ),
          ),
          Center(
              child: Text(
            text,
            style: TextStyle(color: color1),
          ))
        ],
      ),
    ),
  );
}
