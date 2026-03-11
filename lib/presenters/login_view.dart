// lib/presenters/login_view.dart

import '../models/user.dart';

abstract class LoginView {
  void showUser(User user);
  void showError(String message);
  void setLoading(bool value);
}
