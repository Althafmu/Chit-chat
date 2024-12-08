import 'package:chit_chat/controller/chat_controller.dart';
import 'package:chit_chat/controller/login_screen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiveremail;
  final String receiverId;
  ChatPage({super.key, required this.receiveremail, required this.receiverId});

  final TextEditingController _messageController = TextEditingController();

  final ChatController _chatService = ChatController();
  final LoginScreenController _loginService = LoginScreenController();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverId, _messageController.text,
          _loginService.getCurrentUser()!.uid);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(receiveremail),
        ),
        body: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildUserInput(),
          ],
        ));
  }

  Widget _buildMessageList() {
    String senderId = LoginScreenController().getCurrentUser()!.uid;
    return StreamBuilder(
        stream: ChatController().getMessages(receiverId, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser =
        data['senderId'] == LoginScreenController().getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(data['message']),
          ],
        ));
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: const InputDecoration(
                labelText: 'Type your message...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 111, 176, 228)))),
          ),
        ),
        Container(
          decoration:
              const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          child: IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: sendMessage,
          ),
        ),
      ]),
    );
  }
}
