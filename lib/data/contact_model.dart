class ContactsBack4AppModel {
  List<Contact> results = [];

  ContactsBack4AppModel(this.results);

  ContactsBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Contact>[];
      json['results'].forEach((v) {
        results.add(Contact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class Contact {
  String objectId = "";
  String name = "";
  String lastname = "";
  String phoneNumber = "";
  String email = "";
  String imagePath = "";
  String createdAt = "";
  String updatedAt = "";

  Contact(this.objectId, this.name, this.lastname, this.phoneNumber, this.email,
      this.imagePath, this.createdAt, this.updatedAt);

  Contact.create(
    this.name,
    this.lastname,
    this.phoneNumber,
    this.email,
    this.imagePath,
  );

  Contact.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['name'];
    lastname = json['Lastname'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    imagePath = json['imagePath'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['Lastname'] = lastname;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['imagePath'] = imagePath;

    return data;
  }
}
