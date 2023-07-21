import "dart:io";

import "package:http/http.dart" as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String TODAY = "today";

  getTodayWebtoonList() async {
    final url = Uri.parse("$baseUrl/$TODAY");
    final response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      print(response.body);
    }
  }
}

void main(List<String> args) {
  ApiService().getTodayWebtoonList();
}
