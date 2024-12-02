import 'package:bloc_test/data/models/character_model.dart';
import 'package:bloc_test/data/web_services/characters_web_services.dart';

class CharacterRepo {
  final CharactersWebServices charactersWebServices;

  CharacterRepo(this.charactersWebServices);

  Future<List<CharacterModel>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((e) => CharacterModel.fromJson(e)) // e for element from json or each character
        .toList();
  }
}
