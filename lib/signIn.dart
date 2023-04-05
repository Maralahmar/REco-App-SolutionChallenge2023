import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reco/test.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;


GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );

   runApp(const MyApp2());
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
    return Center(
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
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()),
                        ); // return signin();
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
                    // return signin();
                    label: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 18, color: Color(0xFF2C3333)),
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
    );
  }
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  State<SignIn> createState() => _SignInState();
}
class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return
// void signin() {
//     // final formKey = GlobalKey<FormState>();
//     // String? email ;
//     // String? username ;
//     // String? password ;
        MaterialApp(
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
                      ),
                      TextFormField(
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
                          if (value!.length < 7) {
                            return 'Password must be at least 7 characters long';
                          } else {
                            return null;
                          }
                        },
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

                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyApp3())),
                        // return signin();
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
}