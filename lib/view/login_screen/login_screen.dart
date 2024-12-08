import 'package:chit_chat/controller/login_screen_controller.dart';
import 'package:chit_chat/utils/constants/colorconstants.dart';
import 'package:chit_chat/utils/constants/image_constants.dart';
import 'package:chit_chat/view/home_screen/home_screen.dart';
import 'package:chit_chat/view/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginScreenController>(
        builder: (context, loginController, child) => SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Image.asset(
                      ImageConstants.chitchatlogopng,
                      fit: BoxFit.contain,
                      height: 150,
                      width: 300,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colorconstants.primarycolor,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: emailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        RegExp emailreg = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (!emailreg.hasMatch(value)) {
                          return 'Invalid Email Address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined,
                            color: Colorconstants.greycolor),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colorconstants.greycolor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colorconstants.redcolor),
                        ),
                        filled: true,
                        fillColor: Colorconstants.greycolor.withOpacity(0.1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordcontroller,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (value.length < 6) {
                          return 'Password length must be atleast 6';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline,
                            color: Colorconstants.greycolor),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colorconstants.greycolor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colorconstants.redcolor),
                        ),
                        filled: true,
                        fillColor: Colorconstants.greycolor.withOpacity(0.1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    InkWell(
                      onTap: () async {
                        if (formKey1.currentState!.validate()) {
                          var success = await loginController.loginUser(
                              email: emailcontroller.text,
                              password: passwordcontroller.text,
                              context: context);
                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                            emailcontroller.clear();
                            passwordcontroller.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Login failed. Please check your email and password.',
                                ),
                                backgroundColor: Colorconstants.primarycolor,
                              ),
                            );
                          }
                        }
                      },
                      child: loginController.islogined
                          ? const CircularProgressIndicator()
                          : Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colorconstants.primarycolor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colorconstants.whitecolor,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Don't have an account? Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colorconstants.blackcolor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colorconstants.blackcolor,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    loginController.googleislogined
                        ? const CircularProgressIndicator()
                        : InkWell(
                            onTap: () async {
                              var success =
                                  await loginController.googleSignin();
                              if (success) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                  (route) => false,
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(
                                      'Google Sign-In failed. Please try again.'),
                                  backgroundColor: Colorconstants.primarycolor,
                                ));
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colorconstants.primarycolor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageConstants.googlelogopng,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      color: Colorconstants.whitecolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
