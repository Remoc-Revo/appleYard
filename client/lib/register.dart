import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:client/provider/auth_provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  late String id, yop, breed, row, column, location;
  late String confirmedPassword;
  var errorMessage = "";
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext Context) {
    return Material(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Register Apple",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 34,
                )),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ID',
                  hintText: '',
                ),
                onChanged: (val) {
                  id = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'YOP',
                    hintText: '',
                  ),
                  onChanged: (val) {
                    yop = val;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Breed',
                    hintText: '',
                  ),
                  onChanged: (val) {
                    breed = val;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Row',
                    hintText: '',
                  ),
                  onChanged: (val) {
                    row = val;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Column',
                    hintText: '',
                  ),
                  onChanged: (val) {
                    column = val;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Geo-Location',
                    hintText: '',
                  ),
                  onChanged: (val) {
                    location = val;
                  },
                  onTap: () async {
                    Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high,
                    );
                    setState(() {
                      _locationController.text =
                          '${position.latitude}, ${position.longitude}';
                    });
                  }),
            ),
            Text(errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                )),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 85,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      //initialize the errorMessage to ensure previous error messages
                      //are not displayed when they reoccur on proceeding submits
                      errorMessage = '';

                      if (errorMessage == '') {
                        Provider.of<AuthProvider>(context, listen: false)
                            .registerApple(id, yop, breed, row, column,
                                _locationController.text);
                      }
                      print(AuthProvider.signup_authMessage);
                      if (AuthProvider.signup_authMessage == 'success') {
                        Navigator.pushNamed(context, "/home");
                      }

                      setState(() {
                        errorMessage += AuthProvider.errorMessage;
                      });
                    },
                    child: const Text('submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        )),
                  )),
            ),
          ]),
    );
  }
}
