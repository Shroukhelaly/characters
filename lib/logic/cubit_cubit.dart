import 'package:bloc_test/data/models/character_model.dart';
import 'package:bloc_test/logic/cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/character_repo.dart';

class CharactersCubit extends Cubit<CharactersStates> {
  final CharacterRepo characterRepo;

  CharactersCubit(this.characterRepo) : super(CharactersInitialState());

  List<CharacterModel> characters = [];

  List<CharacterModel> getAllCharacters() {
    characterRepo.getAllCharacters().then((characters) {
      emit(CharactersLoadedState(characters));
      this.characters = characters;

    });
    return characters;
  }
}
