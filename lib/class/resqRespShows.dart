// To parse this JSON data, do
//
//     final shows = showsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Shows> showsFromMap(String str) =>
    List<Shows>.from(json.decode(str).map((x) => Shows.fromMap(x)));

String showsToMap(List<Shows> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Shows {
  Shows({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    required this.image,
    required this.summary,
  });

  final int id;
  final String url;
  final String name;
  final Type? type;
  final Language? language;
  final List<Genre> genres;
  final Status? status;

  final Image image;
  final String summary;

  factory Shows.fromMap(Map<String, dynamic> json) => Shows(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        type: typeValues.map[json["type"]],
        language: languageValues.map[json["language"]],
        genres: List<Genre>.from(json["genres"].map((x) => genreValues.map[x])),
        status: statusValues.map[json["status"]],
        image: Image.fromMap(json["image"]),
        summary: json["summary"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "url": url == null ? null : url,
        "name": name == null ? null : name,
        "type": type == null ? null : typeValues.reverse[type],
        "language": language == null ? null : languageValues.reverse[language],
        "genres": genres == null
            ? null
            : List<dynamic>.from(genres.map((x) => genreValues.reverse[x])),
        "status": status == null ? null : statusValues.reverse[status],
        "image": image == null ? null : image.toMap(),
        "summary": summary == null ? null : summary,
      };
}

enum Genre {
  DRAMA,
  SCIENCE_FICTION,
  THRILLER,
  ACTION,
  CRIME,
  HORROR,
  ROMANCE,
  ADVENTURE,
  ESPIONAGE,
  MUSIC,
  MYSTERY,
  SUPERNATURAL,
  FANTASY,
  FAMILY,
  ANIME,
  COMEDY,
  HISTORY,
  MEDICAL,
  LEGAL,
  WESTERN,
  WAR,
  SPORTS
}

final genreValues = EnumValues({
  "Action": Genre.ACTION,
  "Adventure": Genre.ADVENTURE,
  "Anime": Genre.ANIME,
  "Comedy": Genre.COMEDY,
  "Crime": Genre.CRIME,
  "Drama": Genre.DRAMA,
  "Espionage": Genre.ESPIONAGE,
  "Family": Genre.FAMILY,
  "Fantasy": Genre.FANTASY,
  "History": Genre.HISTORY,
  "Horror": Genre.HORROR,
  "Legal": Genre.LEGAL,
  "Medical": Genre.MEDICAL,
  "Music": Genre.MUSIC,
  "Mystery": Genre.MYSTERY,
  "Romance": Genre.ROMANCE,
  "Science-Fiction": Genre.SCIENCE_FICTION,
  "Sports": Genre.SPORTS,
  "Supernatural": Genre.SUPERNATURAL,
  "Thriller": Genre.THRILLER,
  "War": Genre.WAR,
  "Western": Genre.WESTERN
});

class Image {
  Image({
    required this.medium,
    required this.original,
  });

  final String medium;
  final String original;

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        medium: json["medium"] == null ? null : json["medium"],
        original: json["original"] == null ? null : json["original"],
      );

  Map<String, dynamic> toMap() => {
        "medium": medium == null ? null : medium,
        "original": original == null ? null : original,
      };
}

enum Language { ENGLISH, JAPANESE }

final languageValues =
    EnumValues({"English": Language.ENGLISH, "Japanese": Language.JAPANESE});

enum Status { ENDED, RUNNING }

final statusValues =
    EnumValues({"Ended": Status.ENDED, "Running": Status.RUNNING});

enum Type { SCRIPTED, REALITY, ANIMATION, TALK_SHOW, DOCUMENTARY }

final typeValues = EnumValues({
  "Animation": Type.ANIMATION,
  "Documentary": Type.DOCUMENTARY,
  "Reality": Type.REALITY,
  "Scripted": Type.SCRIPTED,
  "Talk Show": Type.TALK_SHOW
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
