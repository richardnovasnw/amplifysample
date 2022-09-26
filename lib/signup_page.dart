import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplifysample/signin_page.dart';
import 'package:amplifysample/verify_user_registration.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

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
                  'Sign Up',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'email'),
                controller: emailController,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'password'),
                controller: password,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    Map<CognitoUserAttributeKey, String> userAttributes = {
                      CognitoUserAttributeKey.email: emailController.text,
                    };

                    SignUpResult res = await Amplify.Auth.signUp(
                        username: emailController.text,
                        password: password.text,
                        options: CognitoSignUpOptions(
                            userAttributes: userAttributes));

                    if (res.nextStep.signUpStep == 'CONFIRM_SIGN_UP_STEP') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const VerifyUserRegistration(),
                        ),
                      );
                    }
                  } on AuthException catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.message.toString()),
                      ),
                    );
                  }
                },
                child: const Text('Signup'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const SignInPage(),
                    ),
                  );
                },
                child: const Text('Signin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
