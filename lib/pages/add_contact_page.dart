import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_contatos_app/Data/contact_model.dart';
import 'package:lista_contatos_app/repositories/contact_repository.dart';
import 'package:lista_contatos_app/shared/widgets/form_field_custom.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final contactModel = ContactsBack4AppModel([]);
  String name = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  XFile? imageProfile;

  final _formKey = GlobalKey<FormState>();

  cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio5x4,
      ],
      cropStyle: CropStyle.circle,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      await GallerySaver.saveImage(croppedFile.path);
      imageProfile = XFile(croppedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple.shade100,
        title: const Text("Adicione Contato"),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height) *
                  0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                TextButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Wrap(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text("Camera"),
                                  onTap: () async {
                                    imageProfile = await picker.pickImage(
                                        source: ImageSource.camera);
                                    if (imageProfile != null) {
                                      String path = (await path_provider
                                              .getApplicationDocumentsDirectory())
                                          .path;
                                      String imageName =
                                          basename(imageProfile!.path);
                                      imageProfile!.saveTo("$path/$imageName");
                                      await GallerySaver.saveImage(
                                          imageProfile!.path);
                                      cropImage(imageProfile!);
                                      Navigator.pop(context);
                                      setState(() {});
                                    }
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo_album),
                                  title: const Text("Galeria"),
                                  onTap: () async {
                                    imageProfile = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    if (imageProfile != null) {
                                      cropImage(imageProfile!);
                                    }
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: (imageProfile != null)
                            ? Image.file(
                                File(imageProfile!.path),
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              )
                            : const Icon(Icons.person),
                      ),
                    )),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormFieldCustom(
                          labelText: "Nome",
                          isObscured: false,
                          onChanged: (value) {
                            name = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) "Este campo é obrigatorio";
                          },
                        ),
                        FormFieldCustom(
                          labelText: "Sobrenome",
                          isObscured: false,
                          onChanged: (value) {
                            lastName = value;
                          },
                        ),
                        FormFieldCustom(
                          labelText: "Telefone",
                          isObscured: false,
                          onChanged: (value) {
                            phoneNumber = value;
                          },
                        ),
                        FormFieldCustom(
                          labelText: "Email",
                          isObscured: false,
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.grey)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancela",
                                  style: TextStyle(color: Colors.white),
                                )),
                            ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.deepPurple),
                                ),
                                onPressed: () async {
                                  _formKey.currentState!.validate();
                                  if (_formKey.currentState!.validate()) {
                                    await ContactsBack4AppRepository
                                        .createContact(Contact.create(
                                            name,
                                            lastName,
                                            phoneNumber.toString(),
                                            email,
                                            (imageProfile != null)
                                                ? imageProfile!.path
                                                : ""));
                                    Navigator.pop(context);
                                  }
                                  setState(() {});
                                },
                                child: const Text(
                                  "Salva",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
