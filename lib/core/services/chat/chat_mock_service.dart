import 'dart:async';
import 'dart:math';

import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Bom dia!',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'User1',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Bom dia, podemos iniciar?',
      createdAt: DateTime.now(),
      userId: '456',
      userName: 'User2',
      userImageURL: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Sim, podemos',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'User1',
      userImageURL: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  Stream<List<ChatMessage>> messsageStream() {
    return _msgStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMassage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.nome,
      userImageURL: user.imageUrl,
    );
    _msgs.add(newMassage);
    _controller?.add(_msgs);
    return newMassage;
  }
}
