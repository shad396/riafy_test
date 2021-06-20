import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart';
List<Items> allItems = [];

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<List<Items>> getItems() async {
    var tempUrl = Uri.parse(url);
    var   data = await http.get(tempUrl);
    var value = jsonDecode(data.body);
    print('value $value');
    for (var u in value) {
      Items items = Items(
        channelName: u["channelname"],
        title: u["title"],
        highThumbnail: u["high thumbnail"],
        lowThumbnail: u["low thumbnail"],
        mediumThumbnail: u["medium thumbnail"],
      );
      allItems.add(items);
    }
    return allItems;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading:  IconButton(
          onPressed: () {},
          icon: SizedBox(
              height: 30,
              child: Image.asset("images/instagram.png")),
        ),
        backgroundColor: Colors.white,
        title: SizedBox(
          height: 35.0,
          width: MediaQuery.of(context).size.width/1.5,
          child: Image.asset('images/logo.png'),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              badgeContent: Text('10'),
              child: IconButton(
                onPressed: () {},
                icon: Image.asset("images/send.png"),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Text('empty');
            } else {
              return ListView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      snapshot.data[index].lowThumbnail),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(snapshot.data[index].channelName),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.more_vert))
                              ],
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.8,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image(
                                      image: NetworkImage(snapshot
                                          .data[index].highThumbnail)))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.favorite_border), onPressed: () {  },
                                  ),
                                  Icon(FontAwesomeIcons.comment),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(FontAwesomeIcons.paperPlane),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(FontAwesomeIcons.bookmark),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(snapshot.data[index].channelName,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).textScaleFactor*15,
                    ),),
                              SizedBox(width: 10.0,),
                              Expanded(
                                child: Text(snapshot.data[index].title.toString().length>50?snapshot.data[index].title.toString().substring(0,50):snapshot.data[index].title,maxLines: 1,style: TextStyle(
                                  fontSize: MediaQuery.of(context).textScaleFactor*15,
                                ),),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            }
          },
          future: getItems(),
        ),
      ),

          bottomNavigationBar: BottomAppBar(
            notchMargin: 6.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ), IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add_box_outlined),
                  color: Colors.black,
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.account_box),
                  onPressed: () {},
                )
              ],
            ),
          ),
    ));
  }
}

class Items {
  final channelName;
  final title;
  final highThumbnail;
  final lowThumbnail;
  final mediumThumbnail;
  Items(
      {this.channelName,
      this.title,
      this.highThumbnail,
      this.lowThumbnail,
      this.mediumThumbnail});
}
