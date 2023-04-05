import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

double recycles = 0;
int recycles2 = 0;
late List<CameraDescription> _cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      title: 'REco',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.hasData) {
            return const HomePage();
          } else {
            return  const MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'REco',
                home: SignUp(),
              );
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  REcoTemplate createState() => REcoTemplate();
}

class REcoTemplate extends State<HomePage> {
  int x = 0;
  int count = 0;
  final _pageViewController = PageController(initialPage: 1);
  int _activePage = 1;
  final user = FirebaseAuth.instance.currentUser;
  final email = FirebaseAuth.instance.currentUser!.email;
  //final name = FirebaseAuth.instance.currentUser!.displayName;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    //var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      //backgroundColor: const Color(0xffFEFAE0),
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
          GestureDetector(
              onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Sign out?"),
                        actions: [
                          TextButton(
                            child: const Text("Yes"),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: const Text("No"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  ),
              child: const Center(
                  child: Text(
                'Sign Out',
                style: TextStyle(
                    color: Color(0xff2C3333),
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ))),
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
                    ),
                  ],
                ),
              ),
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
          Container(
            color: const Color(0xFFFCFFE7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   child:
                Text(
                  "Logged in as $email \n                    Your Progress ",
                  style: const TextStyle(
                    fontSize: 23,
                    color: Color(0xFF2C3333),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                TweenAnimationBuilder(
                  //key: progress,
                  duration: const Duration(seconds: 2),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, _) => SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      color: const Color(0xFFAACB73),
                      value: (recycles / 10),
                      backgroundColor: const Color(0xff90e0c2),
                      strokeWidth: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Text('$recycles2 Recycles'),
                const SizedBox(
                  height: 45,
                ),
              ],
            ),
          ),
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
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    flexibleSpace: Container(
                        alignment: AlignmentDirectional.topStart,
                        margin: const EdgeInsets.only(top: 7),
                        child: const Image(
                          color: Color(0xff2C3333),
                          image: AssetImage('assets/playstore.png'),
                          height: 40,
                          width: 40,
                        )),
                    actions: [
                      GestureDetector(
                          onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Sign out?"),
                                    actions: [
                                      TextButton(
                                        child: const Text("Yes"),
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              ),
                          child: const Center(
                              child: Text(
                            'Sign Out',
                            style: TextStyle(
                                color: Color(0xff2C3333),
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ))),
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
                  body: Container(
                    color: const Color(0xFFFCFFE7),
                    child: ListView(
                      children: <Widget>[
                        Column(
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                const ListTile(
                                  title: Text(
                                    'Coffee Creamer Containers',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  style: ListTileStyle.drawer,
                                ),
                                const ListTile(
                                  title: Text(
                                    'Reuse Your Plastic Coffee Creamer Containers for Snack Storage:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const ListTile(
                                  title: Text(
                                    'Looking for a creative way to recycle your'
                                    ' plastic coffee creamer bottles? Why not try filling '
                                    'the old containers with your favourite small snacks for'
                                    ' the easy ability to pour! Snacks like nuts, small crackers,'
                                    ' and candy are all great options and additionally, you won’t have'
                                    ' to worry about buying any expensive plastic containers for storage!',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FloatingActionButton.extended(
                                    onPressed: () {
                                      recycles += 1;
                                      recycles2 += 1;
                                      log('$recycles');
                                    },
                                    label: const Text('Add to Collection'),
                                    backgroundColor: Colors.brown),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                const ListTile(
                                  title: Text(
                                    'Plastic Bottle Planter',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  style: ListTileStyle.drawer,
                                ),
                                const ListTile(
                                  title: Text(
                                    'Make a Plastic Bottle Planter:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const ListTile(
                                  title: Text(
                                    'Looking to start working on your green thumb? Or do you '
                                    'just want to have access to fresh herbs or other small plants? '
                                    'Why not upcycle your old plastic bottles into small planters. Depending on the'
                                    ' size of the bottle you are using you can plant a variety of different small plants such'
                                    ' as basil, flowers, or cacti! ',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                const ListTile(
                                  title: Text(
                                      'Cut out the bottom third of a 2-liter bottle. \nPaint the bottle white or the color of your choice. \nFill the bottle with seeds and soil'),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FloatingActionButton.extended(
                                    onPressed: () {
                                      recycles += 1;
                                      recycles2 += 1;
                                      log('$recycles');
                                    },
                                    label: const Text('Add to Collection'),
                                    backgroundColor: Colors.brown),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))),
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

class MyApp2 extends StatelessWidget {
  static String title = 'TextFormField';
  const MyApp2({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
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
          body: const SignUp(),
        ),
      );
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    //Image(image:
                    const Image(
                      image: AssetImage('assets/playstore.png'),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: "Enter your Email",
                        icon: Icon(
                          Icons.email,
                        ),
                        iconColor: Color(0xff000000),
                      ),
                      validator: (value) {
                        const pattern =
                            r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                        final regExp = RegExp(pattern);
                        if (value!.isEmpty) {
                          return 'Enter an email';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) => setState(() => email = value!),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: "Enter Username",
                        icon: Icon(
                          Icons.person_2,
                        ),
                        iconColor: Color(0xff000000),
                      ),
                      validator: (value) {
                        if (value!.length < 4) {
                          return 'Enter at least 4 characters';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) => setState(() => username = value!),
                      keyboardType: TextInputType.name,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 7) {
                          return 'Password must be at least 7 characters long';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) => setState(() => password = value!),
                      keyboardType: TextInputType.visiblePassword,
                      maxLength: 16,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: const InputDecoration(
                        hintText: "Enter password",
                        labelText: 'Password',
                        icon: Icon(
                          Icons.lock,
                        ),
                        iconColor: Color(0xff000000),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 300,
                      margin: const EdgeInsets.only(
                        top: 15,
                        left: 32,
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: const Color(0xFFAACB73),
                        ),
                        icon: const Icon(
                          Icons.login,
                          color: Color(0xFF2C3333),
                        ),
                        label: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontFamily: AutofillHints.addressCity,
                              fontSize: 16,
                              color: Color(0xFF2C3333)),
                        ),
                        onPressed: () {
                          var isValid = formKey.currentState!.validate();
                          FocusScope.of(context).unfocus();
                          if (isValid) {
                            formKey.currentState!.save();
                            final message =
                                'Username: $username\nPassword: $password\nEmail: $email';
                            final snackBar = SnackBar(
                              content: Text(
                                message,
                                style: const TextStyle(fontSize: 20),
                              ),
                              backgroundColor: const Color(0xFFAACB73),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text("Do you have an account?"),
                    const SizedBox(height: 15),
                    FloatingActionButton.extended(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn())),
                      label: const Text(
                        'Sign in',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF2C3333)),
                      ),
                      backgroundColor: const Color(0xff90e0c2),
                      icon: const Icon(
                        Icons.check,
                        color: Color(0xFF2C3333),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("Or"),
                    const SizedBox(height: 10),
                    FloatingActionButton.extended(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage())),
                      label: const Text(
                        'Enter as a guest',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF2C3333)),
                      ),
                      backgroundColor: const Color(0xff90e0c2),
                      icon: const Icon(
                        Icons.check,
                        color: Color(0xFF2C3333),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
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
        body: Center(
          child: Form(
            //key: formKey,
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage('assets/playstore.png'),
                        height: 200,
                        width: 300,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: "Enter your Email",
                          icon: Icon(
                            Icons.email,
                          ),
                          iconColor: Color(0xFFAACB73),
                        ),
                        validator: (value) {
                          const pattern =
                              r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                          final regExp = RegExp(pattern);
                          if (value!.isEmpty) {
                            return 'Enter an email';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Enter a valid email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.length < 8) {
                            return 'Password must be at least 8 characters long';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        maxLength: 16,
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: const InputDecoration(
                          hintText: "Enter password",
                          labelText: 'Password',
                          icon: Icon(
                            Icons.lock,
                          ),
                          iconColor: Color(0xFFAACB73),
                        ),
                      ),
                      const SizedBox(height: 15),
                      FloatingActionButton.extended(
                        /// Here button will login to the app ///

                        onPressed: () => signIn(),
                        label: const Text(
                          'Sign in',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFF2C3333)),
                        ),
                        backgroundColor: const Color(0xff90e0c2),
                        icon: const Icon(
                          Icons.login,
                          color: Color(0xFF2C3333),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      log('$e');
    }
    navKey.currentState!.popUntil((route) => route.isFirst);
  }
}
