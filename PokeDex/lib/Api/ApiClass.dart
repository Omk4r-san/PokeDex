import 'package:PokeDex/Models/PokemonDetails_model.dart';
import 'package:PokeDex/Models/PokemonModel.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  Future<PokemonModel> getPokemon() async {
    String url =
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        final pokemon = pokemonModelFromJson(jsonString.toString());
        return pokemon;
      }
    } catch (Exception) {
      print(Exception.toString());
    }
    return null;
  }

  Future<PokemonDetailModel> getPokemonDetail(String name) async {
    String url = "https://pokeapi.co/api/v2/pokemon/$name";
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        // print(jsonString);
        final pokemonDetail = pokemonDetailModelFromJson(jsonString.toString());
        return pokemonDetail;
      }
    } catch (Exception) {
      print(Exception.toString());
    }
    return null;
  }
}
