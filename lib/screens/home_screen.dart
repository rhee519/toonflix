import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodayWebtoonList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<WebtoonModel> webtoons = snapshot.data!;
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: WebtoonList(webtoons),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        },
        future: webtoons,
      ),
    );
  }

  ListView WebtoonList(List<WebtoonModel> webtoons) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: webtoons.length,
      itemBuilder: (context, index) {
        final webtoon = webtoons[index];
        return Column(
          children: [
            Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(10, 10),
                      color: Colors.black.withOpacity(0.3),
                    )
                  ]),
              child: Image.network(
                webtoon.thumb,
                headers: ApiService.headers,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              webtoon.title,
              style: const TextStyle(
                fontSize: 22,
                // fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
