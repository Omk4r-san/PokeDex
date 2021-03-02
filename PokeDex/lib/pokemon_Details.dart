import 'package:PokeDex/Api/ApiClass.dart';
import 'package:PokeDex/Models/PokemonDetails_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:PokeDex/Home.dart';

class PokemonDetail extends StatefulWidget {
  final String name, image;
  final Color typeColor;

  const PokemonDetail({Key key, this.name, this.image, this.typeColor})
      : super(key: key);

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  Color background(data) {
    Color typeColor;
    if (data == "fire") {
      typeColor = Color(0xfffE36161);
    } else if (data == "water") {
      typeColor = Color(0xfff8ac4d0);
    } else if (data == "grass") {
      typeColor = Colors.teal;
    } else if (data == "normal") {
      typeColor = Color(0xfff8ac4d0);
    } else if (data == "electric") {
      typeColor = Color(0xfffffbe0f);
    } else if (data == "poison") {
      typeColor = Color(0xfff845ec2);
    } else if (data == "bug") {
      typeColor = Color(0xfffC9E171);
    } else if (data == "ground") {
      typeColor = Color(0xffff85603f);
    } else if (data == "fighting") {
      typeColor = Color(0xfffe1bc91);
    } else if (data == "psychic") {
      typeColor = Color(0xfffee99a0);
    } else if (data == "rock") {
      typeColor = Color(0xfffaaaaaa);
    } else if (data == "ghost") {
      typeColor = Color(0xfff1e212d);
    } else if (data == "ice") {
      typeColor = Color(0xfffa1cae2);
    } else if (data == "dragon") {
      typeColor = Color(0xfff00917c);
    } else {
      typeColor = Colors.grey;
    }
    return typeColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PokemonDetailModel>(
        future: ApiManager().getPokemonDetail(widget.name.toLowerCase()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return //Column(
                //children: [
                //_abilities(snapshot.data.abilities),
                // Container(
                //   height: 30,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: moves,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Text(snapshot.data.moves[index].move.name);
                //     },
                //   ),
                // ),
                // ],
                // );

                mainPage(snapshot.data);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget mainPage(data) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(widget.name), Text("#00" + data.id.toString())],
          ),
          backgroundColor: widget.typeColor,
        ),
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: widget.typeColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              height: 200,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Image(
                        image: AssetImage('assets/pokeball.png'),
                        fit: BoxFit.fill,
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                        colorBlendMode: BlendMode.modulate),
                  ),
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.name,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: ListView.builder(
                itemCount: data.types.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: background(data.types[index].type.name),
                            borderRadius: BorderRadius.circular(23)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data.types[index].type.name),
                        )),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _tabBar(data)
          ],
        ),
      ),
    );
  }

  Widget _tabBar(data) {
    return Container(
        child: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: TabBar(
                      labelColor: widget.typeColor,
                      indicatorColor: widget.typeColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                "About",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text("Basic Stats",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text("Moves",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 350, //height of TabBarView
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5))),
                    child: TabBarView(
                      children: <Widget>[
                        Container(
                          child: Center(child: _about(data)),
                        ),
                        Container(
                          child: Center(
                            child: _baseStat(data),
                          ),
                        ),
                        Container(
                          child: Center(child: _moves(data)),
                        ),
                      ],
                    ),
                  )
                ])));
  }

  Widget _about(data) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListView(
        children: [
          Text(
            "Abilities:",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            height: 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.abilities.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  data.abilities[index].ability.name + ", ",
                  style: TextStyle(color: Colors.grey),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Height:",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            data.height.toString(),
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Weight:",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            data.weight.toString(),
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _baseStat(data) {
    print(
      data.stats[0].baseStat.toDouble(),
    );
    return ListView(
      children: [
        Container(
          height: 80 * data.stats.length.toDouble(),
          child: ListView.builder(
            itemCount: data.stats.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.stats[index].stat.name + ": ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Row(
                      children: [
                        Text(data.stats[index].baseStat.toString()),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbColor: Colors.transparent,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 0.0),
                            trackShape: RoundedRectSliderTrackShape(),
                            trackHeight: 3,
                            activeTrackColor: Colors.red,
                          ),
                          child: Slider(
                            activeColor: Colors.red,
                            onChanged: null,
                            value: data.stats[index].baseStat.toDouble(),
                            min: 0,
                            max: 150,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _moves(data) {
    return ListView.builder(
      itemCount: data.moves.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Container(
            height: 53,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 15),
                  child: Text(
                    data.moves[index].move.name,
                    style: TextStyle(fontSize: 15),
                  ),
                )),
          ),
        );
      },
    );
  }
}
