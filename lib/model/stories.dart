import 'package:marvel_api_app/model/comics.dart';
import 'package:marvel_api_app/model/creators.dart';
import 'package:marvel_api_app/model/events.dart';
import 'package:marvel_api_app/model/original_issue.dart';
import 'package:marvel_api_app/model/personage.dart';
import 'package:marvel_api_app/model/series.dart';
import 'package:marvel_api_app/model/thumbnail.dart';

class Stories {
  int? id;
  int? available;
  String? title;
  String? description;
  String? resourceURI;
  String? type;
  String? modified;
  Thumbnail? thumbnail;
  Creators? creators;
  Personage? personagem;
  Series? series;
  Comics? comics;
  Events? events;
  OriginalIssue? originalIssue;

  Stories(
      {
        this.id,
        this.available,
        this.title,
        this.description,
        this.resourceURI,
        this.type,
        this.modified,
        this.thumbnail,
        this.creators,
        this.personagem,
        this.series,
        this.comics,
        this.events,
        this.originalIssue,
      });

  Stories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    available = json['available'];
    title = json['title'];
    description = json['description'];
    resourceURI = json['resourceURI'];
    type = json['type'];
    modified = json['modified'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    creators = json['creators'] != null
        ? new Creators.fromJson(json['creators'])
        : null;
    personagem = json['personagem'] != null
        ? new Personage.fromJson(json['personagem'])
        : null;
    series =
        json['series'] != null ? new Series.fromJson(json['series']) : null;
    comics =
        json['comics'] != null ? new Comics.fromJson(json['comics']) : null;
    events =
        json['events'] != null ? new Events.fromJson(json['events']) : null;
    originalIssue = json['originalIssue'] != null
        ? new OriginalIssue.fromJson(json['originalIssue'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['available'] = this.available;
    data['title'] = this.title;
    data['description'] = this.description;
    data['resourceURI'] = this.resourceURI;
    data['type'] = this.type;
    data['modified'] = this.modified;
    data['thumbnail'] = this.thumbnail;
    if (this.creators != null) {
      data['creators'] = this.creators!.toJson();
    }
    if (this.personagem != null) {
      data['personagem'] = this.personagem!.toJson();
    }
    if (this.series != null) {
      data['series'] = this.series!.toJson();
    }
    if (this.comics != null) {
      data['comics'] = this.comics!.toJson();
    }
    if (this.events != null) {
      data['events'] = this.events!.toJson();
    }
    if (this.originalIssue != null) {
      data['originalIssue'] = this.originalIssue!.toJson();
    }
    return data;
  }
}
