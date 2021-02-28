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
  Color customcolor = Colors.white;
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
          child: Text("PokeDex"),
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
                          image: data[index].img,
                          typeColor: background(data[index].type[0]),
                        ))),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: background(data[index].type[0]),
                ),
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 140,
                      child: CachedNetworkImage(
                        imageUrl: data[index].img,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Text(
                      data[index].name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, letterSpacing: 1),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Color background(data) {
    Color typeColor;
    if (data == Type.FIRE) {
      typeColor = Color(0xfffE36161);
    } else if (data == Type.WATER) {
      typeColor = Colors.blue;
    } else if (data == Type.GRASS) {
      typeColor = Colors.teal;
    } else if (data == Type.NORMAL) {
      typeColor = Color(0xfff8ac4d0);
    } else if (data == Type.ELECTRIC) {
      typeColor = Colors.yellow;
    } else if (data == Type.POISON) {
      typeColor = Color(0xfff845ec2);
    } else if (data == Type.BUG) {
      typeColor = Color(0xfffffC9E171);
    } else {
      typeColor = Colors.grey;
    }
    return typeColor;
  }
}
