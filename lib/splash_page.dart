import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplifysample/signin_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1), () async {
      final isSignedIn = await isUserSignedIn();
      if (isSignedIn) {
        if (mounted) {}
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const MyHomePage(title: 'title'),
          ),
        );
      } else {
        if (mounted) {}

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const SignInPage(),
          ),
        );
      }
    });

    super.initState();
  }

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Center(
        //   child: Text(
        //     '⚡',
        //     style: TextStyle(fontSize: 100),
        //   ),
        // ),
        );
  }
}
