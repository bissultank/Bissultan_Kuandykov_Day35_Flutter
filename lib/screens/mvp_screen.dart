// lib/screens/mvp_screen.dart

import 'package:flutter/material.dart';
import '../models/user.dart';
import '../presenters/login_presenter.dart';
import '../presenters/login_view.dart';
import '../services/auth_service.dart';
import '../widgets/ui_widgets.dart';

class MvpScreen extends StatefulWidget {
  const MvpScreen({super.key});

  @override
  State<MvpScreen> createState() => _MvpScreenState();
}

class _MvpScreenState extends State<MvpScreen> implements LoginView {
  late final LoginPresenter _presenter;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  User? _user;
  String? _error;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this, AuthService());
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    _presenter.login(_email.text, _password.text);
  }

  @override
  void showUser(User user) {
    setState(() => _user = user);
  }

  @override
  void showError(String message) {
    setState(() => _error = message);
  }

  @override
  void setLoading(bool value) {
    setState(() => _loading = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MVP')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_error != null)
              ErrorBanner(
                message: _error!,
                onDismiss: () => setState(() => _error = null),
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
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Войти'),
              ),
            ),
            if (_user != null) ...[
              const SizedBox(height: 12),
              Text('Вы вошли как: ${_user!.email}'),
            ],
          ],
        ),
      ),
    );
  }
}
