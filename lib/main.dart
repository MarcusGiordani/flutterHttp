import 'package:atividade_dois/page_result.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Http Request',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Http Request'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _idController = TextEditingController();

  String name = "";
  String email = "";
  String avatar = "";
  String mensagemErro = "";

  Future<void> buscarUsuario() async {
    final id = _idController.text.trim();

    if (id.isEmpty) {
      setState(() {
        mensagemErro = "Digite um ID válido!";
        name = "";
        email = "";
        avatar = "";
      });
      return;
    }

    final url = Uri.parse('https://reqres.in/api/users/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          name = '${data['data']['first_name']} ${data['data']['last_name']}';
          email = data['data']['email'];
          avatar = data['data']['avatar'];
          mensagemErro = "";
        });
      } else {
        setState(() {
          mensagemErro = 'Usuário não encontrado!';
          name = "";
          email = "";
          avatar = "";
        });
      }
    } catch (e) {
      setState(() {
        mensagemErro = 'Erro ao buscar usuário!';
        name = "";
        email = "";
        avatar = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Buscar Usuário na API',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Digite o ID do usuário (1-12)',
                prefixIcon: Icon(Icons.person_search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            if (mensagemErro.isNotEmpty)
              Text(
                mensagemErro,
                style: const TextStyle(color: Colors.red, fontSize: 18),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        child: ElevatedButton(
          onPressed: () async {
            await buscarUsuario();

            if (name.isNotEmpty && email.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultadoPage(
                    name: name,
                    email: email,
                    avatar: avatar,
                    id: _idController.text.trim(),
                  ),
                ),
              );
            } else {
              setState(() {
                mensagemErro = "Usuário não encontrado ou ID inválido!";
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 5,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Buscar',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
