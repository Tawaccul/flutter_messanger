import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/model/message.dart';

class ChatService extends ChangeNotifier {
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiveId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentEmail,
      receiverId: receiveId,
      message: message,
      timestamp: timestamp
    );

    List<String> ids = [currentUserId, receiveId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _firebaseFirestore
    .collection('chat_rooms')
    .doc(chatRoomId)
    .collection('message')
    .add(newMessage.toMap());

   
  }
   Stream<QuerySnapshot> getMessages(String userId, String otherUserId){
      List<String> ids = [userId, otherUserId];
      ids.sort();

      String chatRoomId = ids.join('_');

      return _firebaseFirestore
      .collection('chat_rooms')
      .doc(chatRoomId)
      .collection('message')
      .orderBy('timestamp', descending: false)
      .snapshots();
    }
}