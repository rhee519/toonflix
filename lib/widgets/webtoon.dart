import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon.dart';
import 'package:toonflix/services/api_services.dart';

class Webtoon extends StatelessWidget {
  const Webtoon({
    super.key,
    required this.webtoon,
  });

  final WebtoonModel webtoon;

  @override
  Widget build(BuildContext context) {
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
  }
}
