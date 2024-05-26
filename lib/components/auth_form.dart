import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submit() {
    final isValed = _formKey.currentState?.validate() ?? false;
    if (!isValed) return;

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_formData.isSignup)
                  TextFormField(
                      key: ValueKey('nome'),
                      initialValue: _formData.nome,
                      onChanged: (nome) => _formData.nome = nome,
                      decoration: const InputDecoration(labelText: 'Nome:'),
                      validator: (_nome) {
                        final nome = _nome ?? '';
                        if (nome.trim().length < 4) {
                          return 'Nome com mínimo 4 caracteres';
                        }
                        return null;
                      }),
                TextFormField(
                    key: ValueKey('email'),
                    initialValue: _formData.email,
                    onChanged: (email) => _formData.email = email,
                    decoration: const InputDecoration(labelText: 'Email:'),
                    validator: (_email) {
                      final email = _email ?? '';
                      if (!email.contains('@')) {
                        return 'Informe um email válido!';
                      }
                      return null;
                    }),
                TextFormField(
                    key: ValueKey('password'),
                    initialValue: _formData.password,
                    onChanged: (password) => _formData.password = password,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Senha:'),
                    validator: (_password) {
                      final password = _password ?? '';
                      if (password.length < 6) {
                        return 'Senha deve ter no mínimo 6 caracteres!';
                      }
                      return null;
                    }),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _submit,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  child: Text(
                    _formData.isLogin ? 'Entrar' : 'Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _formData.toggleAuthMode();
                    });
                  },
                  child: Text(
                    _formData.isLogin ? 'Criar Conta' : 'Já possui conta?',
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
