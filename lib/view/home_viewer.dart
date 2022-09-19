import 'package:flutter/material.dart';
import 'package:marvel_api_app/controller/comics_controller.dart';
import 'package:marvel_api_app/controller/home_controller.dart';
import 'package:marvel_api_app/model/comics_news.dart';
import 'package:marvel_api_app/model/personage.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewer extends StatefulWidget {
  const HomeViewer({Key? key}) : super(key: key);

  @override
  State<HomeViewer> createState() => _HomeViewerState();
}

class _HomeViewerState extends State<HomeViewer> with TickerProviderStateMixin {

  late TabController tabController;

  late Size _screen;



  @override
  void initState(){
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screen = MediaQuery.of(context).size;

    List<Widget> pages = [

      _personages(context, _screen),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF353A40),Color(0xFF16171B)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                child: Column(
                  children: [
                    Icon(
                      Icons.code,
                      size: 200,
                      color: Colors.white,
                    ),
                  Text('Click Here to Visit\nsome projects by Patrick Neri',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                    textAlign: TextAlign.center,
                    ),
                  ],
                ),
                onTap: () async {
                  print('Link page');
                   await launch('https://drive.google.com/drive/folders/1S-zP-5n3HfI1PkGB3dixD-qhb9VgPzqj', forceSafariVC: false, forceWebView: false);
                   },
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      body: TabBarView(
        controller: tabController,
          children: pages,
      ),
      bottomNavigationBar: TabBar(
        controller: tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.description,
                color: Colors.black,
              ),
            ),
          ],
      ),
    );
  }

   _personages(BuildContext context, screen){

      return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: _screen.height*0.9,
                    child: _containerPersonages(context),
                  ),
                  _comics(context)
                ],
              ),
            ),
          );
    }

    _containerPersonages(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          StreamBuilder<List<Personage>>(
            stream: homeC.outPerson,
              builder: (BuildContext context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator(color: Colors.black54,);
                }else if(!snapshot.hasData){
                  return Text("Sem Dados!", style: TextStyle(color: Colors.red, fontSize: 20));
                }
                return Expanded(
                    child: Container(
                      width: double.infinity,
                      child: GridView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1),
                          itemBuilder: (context, int index){
                          Personage perso = snapshot.data![index];
                          return GestureDetector(
                            onTap: (){
                                print(perso.name);
                                homeC.updatePage(perso);
                                comicsC.getComicsById(perso.id);
                            },
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.white38, perso.clicked ? Colors.black87: Colors.red],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      child: Text(
                                          perso.name.toString(),
                                        style: TextStyle(
                                          fontSize: _screen.width*0.05,
                                          fontFamily: 'AvangersRegular',
                                          color: perso.clicked ? Colors.red: Colors.black87,
                                        ),
                                      ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        child: Image.network(
                                            "${perso.thumbnail!.path}.${perso.thumbnail!.extension}",
                                          ),
                                     ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                    "Availables Comics: ${perso.comics!.available}",
                                    style: TextStyle(
                                        color: perso.clicked ? Colors.red: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: _screen.width*0.05,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "Availables Series: ${perso.series!.available}",
                                      style: TextStyle(
                                        color: perso.clicked ? Colors.red: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: _screen.width*0.05,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "Availables Stories: ${perso.stories!.available}",
                                      style: TextStyle(
                                        color: perso.clicked ? Colors.red: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: _screen.width*0.05,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: _screen.width*0.02,)
                                ],
                              ),
                            ),
                          );
                          }
                      ),
                    ),
                );
              },
          ),
        ],
      ),
    );
  }
  _comics(BuildContext context){
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        StreamBuilder<List<Personage>>(
          stream: homeC.outPerson,
          builder: (BuildContext context, snapshot){
              if(!snapshot.hasData) {
                return Text("Choose a personage.");
              }else if(snapshot.connectionState == ConnectionState.waiting){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.black54,),
                  ],
                );
              }
              return Card(
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        color: Colors.black87,
                        child: Center(
                          child: Text(
                            "Hero Description",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: _screen.width * .05,
                                fontFamily: 'AvangersRegular',
                            ),
                          ),
                        )),
                    Padding(padding: EdgeInsets.only(bottom: _screen.width * .01)),
                    ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, int index) {
                          Personage perso = snapshot.data![index];
                          return Container(
                                      width: _screen.width * .02,
                                      child: Text(
                                        perso.clicked ? "${perso.name!.toString()}\n\n${perso.description!.toString()}" : "",
                                      ),
                                    );
                        },
                    ),
                  ],
                ),
              );
            },
        ),
      ],
    );
  }
}
