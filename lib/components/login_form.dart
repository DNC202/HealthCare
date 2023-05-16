import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthcare/components/button.dart';
import 'package:healthcare/utils/config.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  Map<String, dynamic>? user;

  Future<dynamic> getUser() async {
    try {
      String uri = "http://10.0.2.2/healthcareDB/get_user.php";
      var response = await http.get(Uri.parse(uri));
      // body: {
      //   "Email": _emailController.text,
      //   "Password": _passController.text,}
      // );
      setState(() {
        user = jsonDecode(response.body);
      });
    } catch (error) {
      return error;
    }
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: "Email Address",
              labelText: "Email",
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: "Password",
              labelText: "Password",
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecurePass = !obsecurePass;
                  });
                },
                icon: obsecurePass
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black38,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: Config.primaryColor,
                      ),
              ),
            ),
          ),
          Config.spaceSmall,
          // login button
          Button(
            width: double.infinity,
            title: "Sign In",
            onPressed: () {
              print(user);
              Navigator.of(context).pushNamed('main', arguments: user);
            },
            disable: false,
          ),
        ],
      ),
    );
  }
}
