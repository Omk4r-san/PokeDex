import 'package:PokeDex/Api/ApiClass.dart';
import 'package:PokeDex/Models/PokemonDetails_model.dart';
import 'package:flutter/material.dart';

class PokemonDetail extends StatefulWidget {
  final String name;

  const PokemonDetail({Key key, this.name}) : super(key: key);

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  Widget build(BuildContext context) {
    print(widget.name);
    return Scaffold(
      body: FutureBuilder<PokemonDetailModel>(
        future: ApiManager().getPokemonDetail(widget.name),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return mainPage();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget mainPage() {
    return null;
  }
}
