// test/widget_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/services/auth_service.dart';
import 'package:counter_app/utils/error_handler.dart';

void main() {
  group('AuthService', () {
    test('load() возвращает null по умолчанию', () {
      final service = AuthService();
      expect(service.load(), isNull);
    });

    test('login() возвращает пользователя', () async {
      final service = AuthService();
      final user = await service.login('test@mail.com', '1234');
      expect(user.email, 'test@mail.com');
    });
  });

  group('ErrorHandler', () {
    test('validateEmail() кидает ошибку', () {
      expect(
        () => ErrorHandler.validateEmail('bad'),
        throwsA(isA<AppError>()),
      );
    });

    test('validatePassword() кидает ошибку', () {
      expect(
        () => ErrorHandler.validatePassword('123'),
        throwsA(isA<AppError>()),
      );
    });
  });
}
