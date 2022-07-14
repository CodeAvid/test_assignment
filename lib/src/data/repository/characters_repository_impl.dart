import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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

  @override
  Future<Uint8List> removeImageBg(String imagePath) async {
    final request = MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));
    request.files.add(await MultipartFile.fromPath("image_url", imagePath));
    request.headers.addAll(
        {"X-API-Key": "gQSa9oiv431hQW8dt2dqD8ix"}); //Put Your API key HERE
    final response = await request.send();
    if (response.statusCode == 200) {
      print(response.statusCode);
      Response imgRes = await Response.fromStream(response);
      print(imgRes);
      return imgRes.bodyBytes;
    } else {
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }
}
