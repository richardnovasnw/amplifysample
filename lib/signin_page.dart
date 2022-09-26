import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplifysample/signup_page.dart';
import 'package:amplifysample/splash_page.dart';
import 'package:amplifysample/verify_user_registration.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                padding: EdgeInsets.only(left: 24),
                alignment: Alignment.topLeft,
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 120,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'email'),
                controller: usernameController,
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'password',
                ),
                obscureText: true,
                controller: passwordController,
              ),
              ElevatedButton(
                onPressed: (usernameController.text.isEmpty ||
                        passwordController.text.isEmpty)
                    ? null
                    : () async {
                        try {
                          SignInResult res = await Amplify.Auth.signIn(
                            username: usernameController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                          if (res.isSignedIn) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SplashPage(),
                              ),
                            );
                          }
                          // setState(() {
                          //   isSignedIn = res.isSignedIn;
                          // });
                        } on UserNotConfirmedException catch (e) {
                          print(e.message);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const VerifyUserRegistration(),
                            ),
                          );
                        } on AuthException catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message.toString())));
                        }
                      },
                child: const Text('Signin'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const SignupPage(),
                    ),
                  );
                },
                child: const Text('Create account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
