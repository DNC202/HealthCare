import 'dart:convert';

import 'package:http/http.dart' as http;

class DioProvider {
  Future<dynamic> getUser(String email, String password) async {
    try {
      String uri = "http://10.0.2.2/healthcareDB/get_user.php";
      var response = await http.post(Uri.parse(uri), body: {
        "Email": email,
        "Password": password,
      });
      jsonDecode(response.body);
    } catch (error) {
      return error;
    }
  }

  // Future<dynamic> getUser(String token) async {
  //   try {
  //     var user = await Dio().get(
  //         "http://10.0.2.2:8080/healthcareDB/get_user.php",
  //         options: Options(headers: {'Authorization': 'Bearer $token'}));
  //     if (user.statusCode == 200 && user.data != '') {
  //       return json.encode(user.data);
  //     }
  //   } catch (error) {
  //     return error;
  //   }
  // }
}
