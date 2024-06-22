import 'package:assignment_reposoft/screens/home_screen.dart';
import 'package:assignment_reposoft/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      //signed in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return HomeScreen();
        }),
      );
    } catch (e) {
      print('Failed to sign in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                "Sign In",
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
                  "Sign In your account",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5E6278)),
                ),
              ),
              SizedBox(height: 40),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      Text(
                        "  Remember Me ",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF5E6278)),
                      ),
                    ],
                  ),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF1F7F8B)),
                  ),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: _signIn,
                  child: Text(
                    "Sign In",
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
                    "Don't have an account ? ",
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
                          return SignUp();
                        }),
                      );
                    },
                    child: Text(
                      "Sign Up",
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
      obscureText: (hintText == "Password") ? true : false,
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
