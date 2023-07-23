import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;
import "package:toonflix/models/webtoon_model.dart";

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String TODAY = "today";

  Future<List<WebtoonModel>> getTodayWebtoonList() async {
    final url = Uri.parse("$baseUrl/$TODAY");
    final response = await http.get(url);
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
  ApiService().getTodayWebtoonList();
}
