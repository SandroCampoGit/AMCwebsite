import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
  await Firebase.initializeApp(
  options: const FirebaseOptions(apiKey: "AIzaSyD7cO51Q4SKqS7BgXoN1d5ogGvaqyKBzns"
  , appId: "1:191439383511:web:c48182c824eb26f3443992", messagingSenderId: "191439383511", projectId: "amc-online")
);
  }else{
    await Firebase.initializeApp();
  }

  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SamsungSharpSans', // Set the global font family to SamsungSharpSans
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomePage(), // Set the WelcomePage as the home page
    );
  }
}