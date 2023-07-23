import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon.dart';
import 'package:toonflix/services/api_services.dart';
import 'package:toonflix/widgets/webtoon.dart';

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
        return Webtoon(webtoon: webtoon);
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
