import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/components/consts.dart';
import 'package:messenger/pages/chat_page.dart';
import 'package:messenger/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut(){
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'),
      actions: [
        IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
      ],
      backgroundColor: bgColor,
      ),
      body: _userList(),
    );
  }

  Widget _userList () {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text('error');
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('loading...');
        }

        return ListView(
          children: snapshot.data!.docs
          .map<Widget>((doc) => _buildUser(doc))
          .toList(),
          
        );
      },
      );
  } 

  Widget _buildUser (DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if(_auth.currentUser!.email != data['email']){
      return Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(data['email']),
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ChatPage(
                receiverUserEmail: data['email'],
                receiverUserId: data['uid'],
              )));
            },
          ),
          const Divider()
        ],
      );
    }else{
    return Container();
  
  }}
}