import 'package:flutter/material.dart';

import 'add_contact_page.dart';

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
        title: const Text("Contatos"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.cyan,
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 50,
        child: ElevatedButton(
            onPressed: () {
              //navigate to input page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext bc) => const AddContactPage()));
            },
            child: const Text(
              "Adicione um contato",
              style: TextStyle(fontSize: 16),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
