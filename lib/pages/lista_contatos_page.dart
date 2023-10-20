import 'package:flutter/material.dart';
import 'package:lista_contatos_app/Data/contact_model.dart';
import 'package:lista_contatos_app/repositories/contact_repository.dart';

import '../shared/widgets/list_view_custom.dart';
import 'add_contact_page.dart';

class ListaContatosPage extends StatefulWidget {
  const ListaContatosPage({super.key});

  @override
  State<ListaContatosPage> createState() => _ListaContatosPageState();
}

class _ListaContatosPageState extends State<ListaContatosPage> {
  var contactModel = ContactsBack4AppModel([]);
  bool loadingListView = false;
  List<Contact> contactList = [];

  @override
  void initState() {
    getContactListFromAPI();

    super.initState();
  }

  void getContactListFromAPI() async {
    setState(() {
      loadingListView = true;
    });
    contactModel = await ContactsBack4AppRepository.getContactsList();
    contactList = contactModel.results;
    setState(() {
      loadingListView = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple.shade100,
        title: const Text("Contatos"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            if (loadingListView) const CircularProgressIndicator(),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListViewCustom(results: contactList))),
          ],
        ),
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
