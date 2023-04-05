import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reco/login_page.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
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
  int x = 0;
  final tabs = [];
  final _pageViewController = PageController(initialPage: 1);
  int _activePage = 1;
  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final c1 = [Colors.white, Colors.green, Colors.red];
    Color getColor(index) {
      return c1[index];
    }

    return Scaffold(
      //backgroundColor: const Color(0xffFEFAE0),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Template()));
            },
          )
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
        children: [
          Container(
            color: Colors.black,
            child: const Center(
              child: SizedBox(
                height: 550,
                width: double.maxFinite,
                child: CameraApp(),
              ),
            ),
          ),
          Container(
            //padding: const EdgeInsets.only(top: 80, bottom: 15, left: 30, right: 30),
            color: const Color(0xFFFCFFE7),
            child: SizedBox(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  13,
                  (index) {
                    index += 1;
                    return GestureDetector(
                      onTap: () {
                        if (x < 2) {
                          x += 1;
                        } else {
                          x = 0;
                        }
                        setState(() {
                          c1[x] = c1[x];
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        color: Colors.green,
                        elevation: 0.15,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: const Image(
                                  image: NetworkImage(
                                      'https://picsum.photos/200/300'),
                                  height: 50,
                                  width: 25,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: const Image(
                                  image: NetworkImage(
                                      'https://picsum.photos/200/300'),
                                  height: 100,
                                  width: 50,
                                  fit: BoxFit.fill,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            color: const Color(0xFFFCFFE7),
            child: const Center(child: Text('Recycling Page')),
          )
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
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceOut);
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

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [Icon(Icons.add)],
        backgroundColor: const Color(0xFFAACB73),
        centerTitle: true,
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
      body: const Template(),
    );
  }
}
