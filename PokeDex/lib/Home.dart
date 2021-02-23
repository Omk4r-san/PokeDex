import 'package:PokeDex/Api/ApiClass.dart';
import 'package:PokeDex/Models/PokemonModel.dart';
import 'package:PokeDex/pokemon_Details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color customcolor = Color(0xffffffff);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Title(
          color: Colors.teal,
          child: Center(child: Text("PokeDex")),
        ),
      ),
      body: FutureBuilder<PokemonModel>(
        future: ApiManager().getPokemon(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return mainPage(snapshot.data.pokemon);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget mainPage(data) {
    return GridView.builder(
        itemCount: data.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (2)),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokemonDetail(
                          name: data[index].name,
                        ))),
            child: Card(
              shape: RoundedRectangleBorder(),
              elevation: 5,
              child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      child: CachedNetworkImage(
                        imageUrl: data[index].img,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Text(data[index].name)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
