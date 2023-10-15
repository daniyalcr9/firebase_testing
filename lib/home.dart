import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formkey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Text("Firebase Testing")),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.only(left: 40, right: 40, top: 58),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome !!",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Text(
                "Sign up now!",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: _usernameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Enter your Name",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-z A-Z]+$").hasMatch(value)) {
                    return "Enter correct Name please";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Enter your Email",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}")
                          .hasMatch(value)) {
                    return "Enter correct Email please";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Enter your Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-z A-Z]+$").hasMatch(value)) {
                    return "Enter a valid Password please";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 65,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          UserCredential? userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                          await userCredential.user!
                              .updateDisplayName(_usernameController.text);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            "Form Submitted",
                            style: TextStyle(color: Colors.white),
                          )));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(16),
                      ),
                      child: Icon(Icons.arrow_right_alt_outlined))
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    "Forgot Passowrd?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
