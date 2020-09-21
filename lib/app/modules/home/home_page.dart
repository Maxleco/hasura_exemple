import 'package:flutter/material.dart';

import 'repository/home_repository.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = HomeRepository();

  @override
  void dispose() {
    super.dispose();
    repository.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("HomePage"),
          bottom: TabBar(tabs: [
            Tab(
              text: "Future",
            ),
            Tab(
              text: "Stream",
            )
          ]),
        ),
        body: TabBarView(children: [
          //* Future
          FutureBuilder<List<Map>>(
              future: repository.getTarefas(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Erro aconteceu"));
                } else if (snapshot.hasData) {
                  final list = snapshot.data;
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) => ListTile(
                            title: Text(list[index]['name']),
                          ));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          //* Stream
          StreamBuilder<List<Map>>(
              stream: repository.streamTarefas(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Erro aconteceu"));
                } else if (snapshot.hasData) {
                  final list = snapshot.data;
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) => ListTile(
                            title: Text(list[index]['name']),
                          ));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
        ),
      ),
    );
  }
}
