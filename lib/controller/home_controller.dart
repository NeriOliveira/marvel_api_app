import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:marvel_api_app/controller/api_access_controller.dart';
import 'package:marvel_api_app/model/personage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class HomeController extends BlocBase{
  BehaviorSubject<List<Personage>> blocPersonage = new BehaviorSubject();

  Sink<List<Personage>> get inPerson => blocPersonage.sink;
  Stream<List<Personage>> get outPerson => blocPersonage.stream;

  late List<Personage> personageList;
  late Personage personage;

  HomeController(){
    personageChoice([1009583, 1009368, 1009189, 1009351, 1009610, 1009187, 1010763, 1009562, 1010365, 1009262, 1010801, 1009707, 1009664, 1009220, 1010743, 1010734, 1011062, 1009720, 1010744, 1009494, 1009338, 1010808, 1017300, 1010735, 1009407]);
  }

  personageChoice(List<int> ids){
    personageList = [];
    for (var id in ids){
      getPersonageById(id);
    }
  }

  getPersonageById(int id){
    String urlEnd = generateUrl("characters/$id");
    print(urlEnd);
    http.get(Uri.parse(urlEnd)).then((v) {
      var personages = jsonDecode(v.body)["data"]["results"];
      for (var personageTemp in personages){
        personage = Personage.fromJson(personageTemp);
        personageList.add(personage);

        inPerson.add(personageList);
      }
    });
  }

  updatePage(Personage perso){
    for(var a in personageList){
      a.clicked = false;
      }
      perso.clicked = true;
      inPerson.add(personageList);
  }

  @override
  void dispose(){
    blocPersonage.close();
  }
}

HomeController homeC = new HomeController();