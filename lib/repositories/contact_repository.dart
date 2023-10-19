import 'package:dio/dio.dart';

import '../Data/contact_model.dart';

class ContactsBack4AppRepository {
  static final _instance = ContactsBack4AppRepository();

  static var baseUrl = "https://parseapi.back4app.com/classes";
  static var _dio = Dio();

  factory ContactsBack4AppRepository() {
    return _instance;
  }

  static Future<ContactsBack4AppModel> getContactsList() async {
    _dio = Dio();
    _dio.options.headers["X-Parse-Application-Id"] =
        "XEeuSkjAEKBwdwOXl1vgGAwvqHwyNKDwodKkRDCg";
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "0qCVuUtvMFNItVxfmdlrPhTxPhXKblUd3XWu3fWK";
    _dio.options.headers["content-type"] = "application/json";
    _dio.options.baseUrl = baseUrl;
    var url = "/Contacts";

    //call to back4app API
    var response = await _dio.get(url);

    //get json from response
    final jsonString = response.data;

    //convert json to list
    final contactList = ContactsBack4AppModel.fromJson(jsonString);

    //return a list of contacts
    return contactList;
  }

  static Future<void> createContact(Contact contact) async {
    _dio = Dio();
    _dio.options.headers["X-Parse-Application-Id"] =
        "XEeuSkjAEKBwdwOXl1vgGAwvqHwyNKDwodKkRDCg";
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "0qCVuUtvMFNItVxfmdlrPhTxPhXKblUd3XWu3fWK";
    _dio.options.headers["content-type"] = "application/json";

    var url = "$baseUrl/Contacts";

    try {
      //call to back4app API
      await _dio.post(url.toString(), data: contact.toJson());
    } catch (e) {
      throw e;
    }
  }
}
