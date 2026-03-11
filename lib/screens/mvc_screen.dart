// lib/screens/mvc_screen.dart

import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import '../services/auth_service.dart';
import '../widgets/ui_widgets.dart';

class MvcScreen extends StatefulWidget {
  const MvcScreen({super.key});

  @override
  State<MvcScreen> createState() => _MvcScreenState();
}

class _MvcScreenState extends State<MvcScreen> {
  late final LoginController _controller;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = LoginController(AuthService());
  }

  @override
  void dispose() {
    _controller.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    _controller.login(_email.text, _password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MVC')),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (_controller.error != null)
                  ErrorBanner(
                    message: _controller.error!,
                    onDismiss: _controller.clearError,
                  ),
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _controller.loading ? null : _submit,
                    child: _controller.loading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Войти'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
