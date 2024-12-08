import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
          color: isCurrentUser
              ? Colors.blue
              : const Color.fromARGB(255, 17, 198, 23),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isCurrentUser ? const Radius.circular(20) : Radius.zero,
            bottomRight:
                isCurrentUser ? Radius.zero : const Radius.circular(20),
          )),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
