
import 'package:marvel_api_app/model/series.dart';
import 'package:marvel_api_app/model/stories.dart';
import 'package:marvel_api_app/model/events.dart';

import 'comics.dart';
import 'thumbnail.dart';

class Personage {
  var id;
  String? name;
  String? description;
  String? modified;
  Thumbnail? thumbnail;
  String? resourceURI;
  Comics? comics;
  Series? series;
  Stories? stories;
  Events? events;
  bool clicked = false;

  Personage(
      {this.id,
      this.name,
      this.description,
      this.modified,
      this.thumbnail,
      this.resourceURI,
      this.comics,
      this.series,
      this.stories,
      this.events,
      });

  Personage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    modified = json['modified'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    resourceURI = json['resourceURI'];
    comics =
        json['comics'] != null ? new Comics.fromJson(json['comics']) : null;
    series =
    json['series'] != null ? new Series.fromJson(json['series']) : null;
    stories =
    json['stories'] != null ? new Stories.fromJson(json['stories']) : null;
    events =
    json['events'] != null ? new Events.fromJson(json['events']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['modified'] = this.modified;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    data['resourceURI'] = this.resourceURI;
    if (this.comics != null) {
      data['comics'] = this.comics!.toJson();
    }
    if (this.series != null) {
      data['series'] = this.series!.toJson();
    }
    if (this.stories != null) {
      data['stories'] = this.stories!.toJson();
    }
    if (this.events != null) {
      data['events'] = this.events!.toJson();
    }
    return data;
  }
}
