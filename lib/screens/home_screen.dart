// import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:flutter/material.dart';

// * Once the onboarding process is completed you will be taken to this screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // * Getting the AtClientManager instance to use below
    // AtClientManager atClientManager = AtClientManager.getInstance();

    return Scaffold(
      appBar: AppBar(title: const Text('AtSign Keymaker')),
      body: Center(
        child: Column(children: [
          const Text(
            'Welcome to the AtSign Keymaker app!',
            style: TextStyle(
              fontSize: 30,
              color: Colors.blue,
            ),
          ),
        ]),
      ),
    );
  }
}
