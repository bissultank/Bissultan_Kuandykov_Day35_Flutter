// lib/services/auth_service.dart

import '../models/user.dart';
import '../utils/error_handler.dart';

class AuthService {
  User? _lastUser;

  // МЕТОД 1: load — вернуть последнего пользователя (если есть)
  User? load() => _lastUser;

  // МЕТОД 2: login — базовая валидация и вход
  Future<User> login(String email, String password) async {
    ErrorHandler.validateEmail(email);
    ErrorHandler.validatePassword(password);

    // Заглушка логики авторизации
    final user = User(email: email.trim(), name: 'User');
    _lastUser = user;
    return user;
  }
}
