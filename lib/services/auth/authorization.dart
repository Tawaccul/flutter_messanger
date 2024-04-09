import 'package:flutter/material.dart';
import 'package:messenger/pages/login.dart';
import 'package:messenger/pages/register.dart';

class Authorization extends StatefulWidget {
  const Authorization({super.key});

  @override
  State<Authorization> createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {

  bool showLoginPage = true; 

  void togglePages(){
    setState((){
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
      if(showLoginPage){
        return LoginPage(onTap: togglePages);
      } else {
        return RegisterPage(onTap: togglePages);
      }
  }
}