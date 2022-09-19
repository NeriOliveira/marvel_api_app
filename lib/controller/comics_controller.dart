import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:marvel_api_app/controller/api_access_controller.dart';
import 'package:marvel_api_app/model/comics_news.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class ComicsController extends BlocBase{
  BehaviorSubject<List<ComicsNews>> blocComics = new BehaviorSubject();

  Sink<List<ComicsNews>> get inComics => blocComics.sink;
  Stream<List<ComicsNews>> get outComics => blocComics.stream;

  late List<ComicsNews> comicsList;
  late ComicsNews comic;

  getComicsById(int idPersonage){
   comicsList = [];
   inComics.add(comicsList);
   String urlEnd = generateUrl("characters/$idPersonage/comics");
   http.get(Uri.parse(urlEnd)).then((value){
     var comicJson = jsonDecode(value.body)["data"]["results"];
     for(var c in comicJson){
       ComicsNews comic = ComicsNews.fromJson(c);
       comicsList.add(comic);
     }
     inComics.add(comicsList);
   });
  }


  @override
  void dispose(){
    // TODO: implement dispose
    //blocComics.close();
  }
}

ComicsController comicsC = new ComicsController();