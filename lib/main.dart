import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplifysample/splash_page.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(const MyApp());
}

Future<void> configureAmplify() async {
  AmplifyDataStore dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
  final api = AmplifyAPI();
  final storage = AmplifyStorageS3();

  await Amplify.addPlugins([
    authPlugin,
    dataStorePlugin,
    api,
    storage,
  ]);

  try {
    await Amplify.configure(amplifyconfig);
  } catch (e) {
    print(e);
    print("Tried to reconfigure Amplify");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme:
            InputDecorationTheme(border: OutlineInputBorder()),
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}
