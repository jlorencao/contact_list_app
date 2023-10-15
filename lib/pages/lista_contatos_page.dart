import 'package:flutter/material.dart';

class ListaContatosPage extends StatefulWidget {
  const ListaContatosPage({super.key});

  @override
  State<ListaContatosPage> createState() => _ListaContatosPageState();
}

class _ListaContatosPageState extends State<ListaContatosPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Contatos"),
      ),
      body: const Column(),
    ));
  }
}
