// lib/presenters/login_presenter.dart

import '../models/user.dart';
import '../presenters/login_view.dart';
import '../services/auth_service.dart';
import '../utils/error_handler.dart';

class LoginPresenter {
  final LoginView _view;
  final AuthService _auth;

  LoginPresenter(this._view, this._auth) {
    load();
  }

  void load() {
    try {
      final user = _auth.load();
      if (user != null) {
        _view.showUser(user);
      }
    } catch (e) {
      _view.showError(ErrorHandler.handle(e, context: 'Presenter.load'));
    }
  }

  Future<void> login(String email, String password) async {
    _view.setLoading(true);
    try {
      final user = await _auth.login(email, password);
      _view.showUser(user);
    } catch (e) {
      _view.showError(ErrorHandler.handle(e, context: 'Presenter.login'));
    } finally {
      _view.setLoading(false);
    }
  }
}
