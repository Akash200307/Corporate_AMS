// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:titans/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "welcome to ",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: "kendice",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 28,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: "\nLogin",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 40,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _studentIdController,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                child: MaterialButton(
                  onPressed: () async {
                    String id = _studentIdController.text.trim();
                    String password = _passwordController.text.trim();
                    if (id.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: Colors.white,
                            content: Container(
                              height: 80,
                              padding: const EdgeInsets.all(26),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Color.fromARGB(255, 255, 73, 73),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Enter the id",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.circleXmark,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )),
                      );
                    } else if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: Colors.white,
                            content: Container(
                              height: 80,
                              padding: const EdgeInsets.all(26),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: const Color.fromARGB(255, 255, 73, 73),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Enter the password",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.circleXmark,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )),
                      );
                    } else {
                      try {
                        Login();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: Colors.white,
                              content: Container(
                                height: 80,
                                padding: const EdgeInsets.all(26),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: const Color.fromARGB(255, 255, 73, 73),
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Check the details again",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.faceSadTear,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              )),
                        );
                      }

                      // Add your logic here to handle the snapshot
                    }
                  },
                  minWidth: double.infinity,
                  height: 60,
                  color: primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Login",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Login() async {
    final auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: _studentIdController.text, password: _passwordController.text);
  }
}
