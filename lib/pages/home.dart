import 'package:chat_app_flutter/components/my_user_tile.dart';
import 'package:chat_app_flutter/pages/chat_page.dart';
import 'package:chat_app_flutter/services/auth/auth_service.dart';
import 'package:chat_app_flutter/components/my_drawer.dart';
import 'package:chat_app_flutter/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat and authservice
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  //build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text('Error');
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }

          //return list
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          //tapped on a user -> goto chat page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      receiverId: userData['uid'],
                      receiverEmail: userData['email'],
                    )),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
