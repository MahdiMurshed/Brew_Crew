import 'package:brew/model/user.dart';
import 'package:brew/screens/authentication/authenticate.dart';
import 'package:brew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    //return either home or authenticate
    return user == null ? Authenticate() : Home();
  }
}
