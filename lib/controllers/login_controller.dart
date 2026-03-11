// lib/controllers/login_controller.dart

import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../utils/error_handler.dart';

class LoginController extends ChangeNotifier {
  final AuthService _auth;

  LoginController(this._auth) {
    load();
  }

  User? _user;
  String? _error;
  bool _loading = false;

  User? get user => _user;
  String? get error => _error;
  bool get loading => _loading;

  void load() {
    try {
      _user = _auth.load();
    } catch (e) {
      _error = ErrorHandler.handle(e, context: 'Controller.load');
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _error = null;
    _loading = true;
    notifyListeners();
    try {
      _user = await _auth.login(email, password);
    } catch (e) {
      _error = ErrorHandler.handle(e, context: 'Controller.login');
    } finally {
      _loading = false;
    }
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
