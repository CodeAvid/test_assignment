import 'dart:typed_data';

import 'package:casino_test/src/data/models/character.dart';

abstract class CharactersRepository {
  Future<List<Character>?> getCharacters(int page);
  Future<Uint8List> removeImageBg(String imagePath);
}
