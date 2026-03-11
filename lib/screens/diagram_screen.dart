// lib/screens/diagram_screen.dart

import 'package:flutter/material.dart';

class DiagramScreen extends StatelessWidget {
  const DiagramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Слои')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _layer('Model', [
              'User — данные пользователя',
              'AuthService — логика авторизации',
            ]),
            _arrow(),
            _layer('Controller / Presenter', [
              'Принимает действия из UI',
              'Вызывает AuthService',
              'Обрабатывает ошибки через ErrorHandler',
            ]),
            _arrow(),
            _layer('View', [
              'Только UI',
              'Не содержит бизнес-логики',
            ]),
            const SizedBox(height: 12),
            const Text('MVC проще, MVP требует интерфейс View, но легче тестировать.'),
          ],
        ),
      ),
    );
  }

  Widget _layer(String title, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          ...items.map((i) => Text('- $i')),
        ],
      ),
    );
  }

  Widget _arrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Center(child: Icon(Icons.arrow_downward, size: 18)),
    );
  }
}
