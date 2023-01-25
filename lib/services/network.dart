import 'dart:convert';

import '../models/youtubes.dart';
import 'package:http/http.dart' as http;

class Network {
  static Future<List<Youtube>> fetchYoutube({final type = "superhero"}) async {
    final url = Uri.parse(
        'http://codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=${type}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      Youtubes youtubeList = Youtubes.fromJson(jsonResponse);

      for (var item in youtubeList.youtubes) {
        print(item.title);
      }

      return youtubeList.youtubes;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
