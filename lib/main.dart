import 'package:chit_chat/controller/login_screen_controller.dart';
import 'package:chit_chat/controller/signup_screen_controller.dart';
import 'package:chit_chat/firebase_options.dart';
import 'package:chit_chat/view/isuserlogined_screen/isuserlogined_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignupScreenController()),
        ChangeNotifierProvider(create: (context) => LoginScreenController())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IsuserloginedScreen(),
      ),
    );
  }
}
