import 'dart:io';

import 'package:flutter/material.dart';

import '../../Data/contact_model.dart';

class ListViewCustom extends StatelessWidget {
  final List<Contact> results;

  const ListViewCustom({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext bc, int index) {
          var contact = results[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: (contact.imagePath != null &&
                            File("${contact.imagePath}").existsSync())
                        ? Builder(
                            builder: (BuildContext context) {
                              try {
                                return Image.file(
                                  File("${contact.imagePath}"),
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill,
                                );
                              } catch (e) {
                                // Handling the PathNotFoundException here
                                return Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'Image Not Found',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ));
                              }
                            },
                          )
                        : Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.person)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${contact.name} ${(contact.lastname.isNotEmpty) ? contact.lastname : ""}",
                      style: const TextStyle(
                          fontSize: 16, color: Colors.deepPurpleAccent),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (contact.email.isNotEmpty)
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.email_outlined,
                          color: Colors.deepPurple,
                          size: 16,
                        )),
                  if (contact.phoneNumber.isNotEmpty)
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.phone_enabled,
                          color: Colors.deepPurple,
                          size: 16,
                        )),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.deepPurple,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade200,
              )
            ],
          );
        });
  }
}
