import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp2());

}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REco',
      home: Template(),
    );
  }
}

class Template extends StatefulWidget {
  const Template({Key? key}) : super(key: key);
  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions:  const [],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: "Enter your Email",
                        icon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: "Enter Username",
                        icon: Icon(
                          Icons.person_2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (String? value) {
                        if (value.toString().trim().isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      maxLength: 16,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: const InputDecoration(
                        hintText: "Enter password",
                        labelText: 'Password',
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {},
                    label: const Text('Sign in'),
                    backgroundColor: Colors.cyan,
                    icon: const Icon(Icons.check),
                  ),
                  const SizedBox(width: 40),
                  FloatingActionButton.extended(
                    onPressed: () {},
                    label: const Text('Sign Up'),
                    backgroundColor: Colors.cyan,
                    icon: const Icon(Icons.check_box_sharp),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FloatingActionButton.extended(
                onPressed: () {},
                label: const Text('Enter as a guest'),
                icon: const Icon(Icons.directions_walk),
              ),
            ],
          ),
        ),
      ),
    );



  }
}
