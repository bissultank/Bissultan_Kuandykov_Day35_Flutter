// lib/utils/error_handler.dart

class AppError implements Exception {
  final String message;
  final String context;

  const AppError(this.message, {this.context = ''});

  @override
  String toString() => context.isNotEmpty ? '[$context] $message' : message;
}

class ErrorHandler {
  static String handle(Object error, {String context = ''}) {
    if (error is AppError) return error.toString();
    final msg = error.toString().replaceAll('Exception:', '').trim();
    return context.isNotEmpty ? '[$context] $msg' : msg;
  }

  static void validateEmail(String email) {
    final cleaned = email.trim();
    if (cleaned.isEmpty) {
      throw const AppError('Email пустой', context: 'Validation');
    }
    if (!cleaned.contains('@')) {
      throw const AppError('Некорректный email', context: 'Validation');
    }
  }

  static void validatePassword(String password) {
    if (password.isEmpty) {
      throw const AppError('Пароль пустой', context: 'Validation');
    }
    if (password.length < 4) {
      throw const AppError('Пароль слишком короткий', context: 'Validation');
    }
  }
}
