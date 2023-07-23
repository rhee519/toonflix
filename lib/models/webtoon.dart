class WebtoonModel {
  final String id; // "812354"
  final String title; // "신혼일기"
  final String
      thumb; // "https://image-comic.pstatic.net/webtoon/812354/thumbnail/thumbnail_IMAG21_f391c11a-9a74-4e0c-b601-2fcebafffd07.jpg"},{"id":"758150","title":"입학용병","thumb":"https://image-comic.pstatic.net/webtoon/758150/thumbnail/thumbnail_IMAG21_4135492154714961716.jpg"

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        thumb = json["thumb"],
        id = json["id"];
}
