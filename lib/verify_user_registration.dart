import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplifysample/splash_page.dart';
import 'package:flutter/material.dart';

class VerifyUserRegistration extends StatefulWidget {
  const VerifyUserRegistration({Key? key}) : super(key: key);

  @override
  State<VerifyUserRegistration> createState() => _VerifyUserRegistrationState();
}

class _VerifyUserRegistrationState extends State<VerifyUserRegistration> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        onChanged: () {
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 24),
                alignment: Alignment.topLeft,
                child: const Text(
                  'Verify Email',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'email'),
                controller: usernameController,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'otp'),
                controller: otpController,
              ),
              ElevatedButton(
                onPressed: confirmUser,
                child: const Text('Verify'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> confirmUser() async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: usernameController.text,
        confirmationCode: otpController.text,
      );
      if (result.isSignUpComplete) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const SplashPage(),
          ),
        );
      }
      // setState(() {
      //   isSignUpComplete = result.isSignUpComplete;
      // });

    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }
}
