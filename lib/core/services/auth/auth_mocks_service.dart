import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';

class AuthMocksService implements AuthService {
  static final _defaultUser = ChatUser(
    id: '456',
    nome: 'User2',
    email: 'user2@gmail.com',
    imageUrl: 'assets/images/avatar.png',
  );
  static Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });
  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
    String nome,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      nome: nome,
      email: email,
      imageUrl: image?.path ?? 'assets/images/avatar.png',
    );
    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
