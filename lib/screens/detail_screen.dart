import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon.dart';
import 'package:toonflix/models/webtoon_detail.dart';
import 'package:toonflix/models/webtoon_episode.dart';
import 'package:toonflix/services/api_services.dart';
import 'package:toonflix/widgets/episode_nav_button.dart';

class DetailScreen extends StatefulWidget {
  final WebtoonModel webtoon;

  const DetailScreen({
    super.key,
    required this.webtoon,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> detail;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    detail = ApiService.getDetailById(widget.webtoon.id);
    episodes = ApiService.getLatestEpisodesById(widget.webtoon.id);

    initPrefs();
  }

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedWebtoons = prefs.getStringList("likedWebtoons");
    if (likedWebtoons != null) {
      if (likedWebtoons.contains(widget.webtoon.id)) {
        setState(() {
          liked = true;
        });
      }
    } else {
      prefs.setStringList("likedWebtoons", []);
    }
  }

  onHeartTap() async {
    final likedWebtoons = prefs.getStringList("likedWebtoons");
    if (likedWebtoons != null) {
      if (liked) {
        likedWebtoons.remove(widget.webtoon.id);
      } else {
        likedWebtoons.add(widget.webtoon.id);
      }
      await prefs.setStringList("likedWebtoons", likedWebtoons);
      setState(() {
        liked = !liked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(liked
                ? Icons.favorite_outlined
                : Icons.favorite_outline_outlined),
          )
        ],
        elevation: 1,
        title: Text(
          widget.webtoon.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 50,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.webtoon.id,
                    child: Container(
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
                        widget.webtoon.thumb,
                        headers: ApiService.headers,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    WebtoonDetailModel detail = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${detail.genre} / ${detail.age}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text("loading...");
                },
                future: detail,
              ),
              const SizedBox(
                height: 50,
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<WebtoonEpisodeModel> episodes = snapshot.data!;
                    return Column(
                      children: [
                        for (var episode in episodes)
                          EpisodeNavButton(
                            webtoon: widget.webtoon,
                            episode: episode,
                          )
                      ],
                    );
                  }
                  return Container();
                },
                future: episodes,
              )
            ],
          ),
        ),
      ),
    );
  }
}
