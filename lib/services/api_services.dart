import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;
import 'package:toonflix/models/webtoon.dart';

class ApiService {
  static const headers = {
    "User-Agent":
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"
  };

  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String TODAY = "today";

  static Future<List<WebtoonModel>> getTodayWebtoonList() async {
    final url = Uri.parse("$baseUrl/$TODAY");
    final response = await http.get(url, headers: headers);
    if (response.statusCode != HttpStatus.ok) {
      throw Error();
    }

    final List<dynamic> webtoons = jsonDecode(response.body);
    final List<WebtoonModel> webtoonList =
        webtoons.map((json) => WebtoonModel.fromJson(json)).toList();
    return webtoonList;
  }
}

void main(List<String> args) {
  ApiService.getTodayWebtoonList();
}
