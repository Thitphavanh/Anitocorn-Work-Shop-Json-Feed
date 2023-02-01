import 'dart:convert';
import 'package:anitocorn_work_shop_json_feed/models/json_test.dart';
import '../models/youtubes.dart';
import 'package:http/http.dart' as http;

class Network {
  static Future<List<JsonTest>> fetchJsonTest() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);

      List<JsonTest> result =
          jsonResponse.map((i) => JsonTest.fromJson(i)).toList();

      for (var item in result) {
        print(item.username);
      }

      return result;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<List<Youtube>> fetchYoutube({final type = "superhero"}) async {
    final url = Uri.parse(
        'http://codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=${type}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      Youtubes youtubeList = Youtubes.fromJson(jsonResponse);

      // for (var item in youtubeList.youtubes) {
      //   print(item.title);
      // }

      return youtubeList.youtubes;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
