import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/provider/auth_provider.dart';
// import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  //encapsulates all the  fields required to login into the system
  //and functions required to authenticate the login details before
  //sending them to the server for authentication

  const LoginPage({Key? key}) : super(key: key);
  // constuctor for the class, used for instantiating the class

  @override
  State<LoginPage> createState() =>
      LoginPageState(); // create  state of login page
}

class LoginPageState extends State<LoginPage> {
  //state of login page

  //entered email and password
  late String _email, _password;

  String errorMessage = "";
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext Context) {
    //Context is a link to the location of a widget in the tree structure of widgets

    return Material(
      //Material is a convenience widget that wraps a number of widgets
      // that are commonly required for applications implementing Material Design
      child: Column(
          //for column, main axis is the vertical axis
          //cross axis is horizontal axis
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("AppleYard",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 34,
                )),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter  valid email',
                  ),
                  onChanged: (val) {
                    _email = val;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                obscureText: _obscurePassword,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your secure Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      child: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    )),
                onChanged: (val) {
                  _password = val;
                },
              ),
            ),
            Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            // TextButton(
            //   onPressed: () {},
            //   child: Text('Forgot Password',
            //       style: TextStyle(
            //         color: Colors.green,
            //       )),
            // ),
            Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    // Navigator.pushNamed(context, "/home");
                    Provider.of<AuthProvider>(context, listen: false)
                        .signinUser(_email, _password)
                        .then((_) {
                      if (AuthProvider.signin_authMessage == 'success') {
                        Navigator.pushNamed(context, "/home");
                      } else {
                        setState(() {
                          _isLoading = false;
                          errorMessage = AuthProvider.errorMessage;
                        });
                      }
                    });

                    print("signinAuth:${AuthProvider.signin_authMessage}");
                    //if the server authenticates the login, redirect to the main page
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text('login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                          )),
                )),
            const SizedBox(
              height: 130,
            ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, "/signUp");
            //   },
            //   child: Text(
            //     'New User? Create Account',
            //   ),
            // ),
          ]),
    );
  }

  Future<Object?> login() {
    return Navigator.pushNamed(context, "/home");
  }
}
