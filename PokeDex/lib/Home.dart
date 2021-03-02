import 'package:PokeDex/Api/ApiClass.dart';
import 'package:PokeDex/Models/PokemonModel.dart';
import 'package:PokeDex/pokemon_Details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: AppBar(
        backgroundColor: Color(0xfffe40017),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            'assets/pokeball.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Title(
          color: Color(0xffffa1e0e),
          child: Text(
            "PokeDex",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
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
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: background(data[index].type[0]),
                    ),
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Image(
                      height: 140,
                      image: AssetImage(
                        'assets/pokeball.png',
                      ),
                      fit: BoxFit.contain,
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                  Center(
                      child: CachedNetworkImage(
                    imageUrl: data[index].img,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10),
                    child: Text(data[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Colors.white)),
                  )
                ],
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
      typeColor = Color(0xffffffbe0f);
    } else if (data == Type.POISON) {
      typeColor = Color(0xfff845ec2);
    } else if (data == Type.BUG) {
      typeColor = Color(0xfffffC9E171);
    } else if (data == Type.GROUND) {
      typeColor = Color(0xffff85603f);
    } else if (data == Type.FIGHTING) {
      typeColor = Color(0xfffe1bc91);
    } else if (data == Type.PSYCHIC) {
      typeColor = Color(0xfffee99a0);
    } else if (data == Type.ROCK) {
      typeColor = Color(0xfffaaaaaa);
    } else if (data == Type.GHOST) {
      typeColor = Color(0xfff1e212d);
    } else if (data == Type.ICE) {
      typeColor = Color(0xfffa1cae2);
    } else if (data == Type.DRAGON) {
      typeColor = Color(0xfff00917c);
    } else {
      typeColor = Colors.grey;
    }
    return typeColor;
  }
}
