import 'package:flutter/material.dart';

class ResultadoPage extends StatelessWidget {
  final String name;
  final String email;
  final String avatar;
  final String id;

  const ResultadoPage({
    super.key,
    required this.name,
    required this.email,
    required this.avatar,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado da Busca'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.blue.shade50,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(avatar),
                  radius: 50,
                ),
                const SizedBox(height: 15),
                Text(
                  name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  email,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                Text(
                  'Id: $id',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
