import 'dart:async';
import 'dart:convert';

import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:http/http.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;

  CharactersRepositoryImpl(this.client);

  @override
  Future<List<Character>?> getCharacters(int page) async {
    var client = Client();
    final charResult = await client.get(
      Uri.parse("https://rickandmortyapi.com/api/character/?page=$page"),
    );
    if (charResult.statusCode == 200) {
      final json = jsonDecode(charResult.body);
      print(charResult.body);
      final characters = json['results']
          .map<Character>((character) => Character.fromJson(character))
          .toList();

      return characters;
    } else {
      throw Exception("Error occurred with response ${charResult.statusCode}");
    }
  }
}
