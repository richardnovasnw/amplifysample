import 'dart:async';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplifysample/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'models/UserModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    listenChanges();
    super.initState();
  }

  late StreamSubscription<QuerySnapshot<UserModel>> stream;

  // Initialize a list for storing posts
  List<UserModel> _posts = [];

  // Initialize a boolean indicating if the sync process has completed
  bool _isSynced = false;

  void listenChanges() {
    stream = Amplify.DataStore.observeQuery(UserModel.classType).listen(
      (snapshot) {
        setState(() {
          _posts = snapshot.items;
          _isSynced = snapshot.isSynced;
        });
      },
    );
  }

  final TextEditingController age = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController updatePhone = TextEditingController();

  Future<void> deleteData(UserModel data) async {
    await Amplify.DataStore.delete(data).catchError(print);
  }

  Future<List<UserModel>> queryData() async {
    final userModels = await Amplify.DataStore.query(UserModel.classType);
    setState(() {});
    return userModels;
  }

  Future<void> updateData(String id, String phone) async {
    final postsWithId = await Amplify.DataStore.query(
      UserModel.classType,
      where: UserModel.ID.eq(id),
    );

    final oldPost = postsWithId.first;
    final newPost = oldPost.copyWith(
      id: oldPost.id,
      phone: phone,
    );

    await Amplify.DataStore.save(newPost).then(
      (value) => updatePhone.clear(),
    );

    Navigator.pop(context);
  }

  void stopListeningChanges() {
    stream.cancel();
  }

  @override
  void dispose() {
    stopListeningChanges();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
              onPressed: () {
                Amplify.Auth.signOut()
                    .then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SplashPage(),
                          ),
                        ));
              },
              child: const Text(
                'sign out',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: Column(
        children: [
          for (final data in _posts)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: TextField(
                              decoration: InputDecoration(hintText: 'Phone'),
                              controller: updatePhone,
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () async {
                                    await updateData(
                                      data.id ?? '',
                                      updatePhone.text,
                                    );
                                  },
                                  child: Text('update')),
                            ],
                          );
                        });
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteData(data);
                    },
                  ),
                  title: Text(data.name.toString() ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email : ${data.email.toString()}'),
                      Text('Phone : ${data.phone.toString()}'),
                      Text('Age : ${data.age.toString()}'),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // createAndUploadFile();

          createDataBottomSheet(onPressed: () {
            createData(context);
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }

  Future<void> createAndUploadFile() async {
    // Create a dummy file
    const exampleString = 'Example file contents';
    final tempDir = await getTemporaryDirectory();
    final exampleFile = File(tempDir.path + '/example.txt')
      ..createSync()
      ..writeAsStringSync(exampleString);

    // Upload the file to S3
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: exampleFile,
          key: 'ExampleKeyNew',
          onProgress: (progress) {
            print('Fraction completed: ${progress.getFractionCompleted()}');
          });
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<void> createDataBottomSheet({required VoidCallback onPressed}) async {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white.withOpacity(.8),
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Name'),
                  controller: name,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Age'),
                  controller: age,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Phone'),
                  controller: phone,
                  keyboardType: TextInputType.phone,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      createData(context);
                    },
                    child: const Text('Create'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> createData(BuildContext context) async {
    {
      final getUser = await Amplify.Auth.fetchUserAttributes();
      final email =
          getUser.firstWhere((element) => element.value.contains('@')).value;
      print(email);
      if (name.text.isNotEmpty &&
          age.text.isNotEmpty &&
          phone.text.isNotEmpty) {
        await Amplify.DataStore.save(
          UserModel(
            name: name.text,
            age: int.parse(age.text),
            phone: phone.text,
            email: email,
          ),
        ).then((v) {
          name.clear();
          age.clear();
          phone.clear();
        });
      }
      Navigator.pop(context);
    }
  }
}
