import 'package:bloc_test/data/models/character_model.dart';

abstract class CharactersStates {}

class CharactersInitialState extends CharactersStates{}

class CharactersLoadedState extends CharactersStates {
  final List<CharacterModel> characters;

  CharactersLoadedState(this.characters);
}
