import 'package:assignment_reposoft/screens/home_screen.dart';
import 'package:assignment_reposoft/screens/sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      print("Passwords do not match");
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('Signed up: ${userCredential.user?.email}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return HomeScreen();
        }),
      );
    } catch (e) {
      print('Failed to sign up: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1F7F8B)),
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Create account and enjoy all services",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF5E6278)),
                  ),
                ),
                SizedBox(height: 40),
                CustomTextField(
                  hintText: "Full Name",
                  icon: "assets/images/user.png",
                  controller: _fullNameController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Email",
                  icon: "assets/images/mail.png",
                  controller: _emailController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Password",
                  icon: "assets/images/lock.png",
                  controller: _passwordController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Confirm password",
                  icon: "assets/images/lock.png",
                  controller: _confirmPasswordController,
                ),
                SizedBox(height: 40),
                SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF23213D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ? ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF5E6278)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return SignIn(); // Replace with the name of your desired page
                          }),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F7F8B)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String icon;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFFA1A5B7)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF5E6278), width: 1)),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Image.asset(
            icon,
            height: 20,
          ),
        ),
        suffixIcon: (icon == "assets/images/lock.png")
            ? Padding(
                padding: const EdgeInsets.all(14.0),
                child: Image.asset(
                  "assets/images/eye-off.png",
                  height: 20,
                ),
              )
            : null,
      ),
    );
  }
}
