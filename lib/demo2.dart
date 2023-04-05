import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("StartUpTemplate"),
        ),
        body: const Template(),
      ),
    ));

class Template extends StatefulWidget {
  const Template({Key? key}) : super(key: key);

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('$count'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const LoginButton(),
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
            )
          ],
        )
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.zero),
        shadowColor: Colors.grey[200],
        elevation: 5.0,
        child: const MaterialButton(
          minWidth: 200.0,
          height: 60.0,
          onPressed: null,
          color: Colors.grey,
          child: Text(
            'LOG IN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
