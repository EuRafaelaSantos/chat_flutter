import 'package:chat/core/services/auth/auth_mocks_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chat page!'),
            TextButton(
                onPressed: () {
                  AuthMocksService().logout();
                },
                child: Text('LogOut'))
          ],
        ),
      ),
    );
  }
}
