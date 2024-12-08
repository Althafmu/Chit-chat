import 'package:chit_chat/controller/chat_controller.dart';
import 'package:chit_chat/controller/login_screen_controller.dart';
import 'package:chit_chat/utils/constants/colorconstants.dart';
import 'package:chit_chat/view/chatPage/chat_page.dart';
import 'package:chit_chat/view/home_screen/widgets/UserTile.dart';
import 'package:chit_chat/view/home_screen/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ChatController chatController = ChatController();
  final LoginScreenController loginController = LoginScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstants.whitecolor,
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[700],
      ),
      drawer: const DrawerWidget(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatController.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != loginController.getCurrentUser()!.email) {
      return Usertile(
        text: userData["email"],
        ontap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiveremail: userData["email"],
                        receiverId: userData["uid"],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
