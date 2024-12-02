import 'package:bloc_test/constance/constance.dart';
import 'package:bloc_test/data/models/character_model.dart';
import 'package:bloc_test/data/repo/character_repo.dart';
import 'package:bloc_test/logic/cubit_cubit.dart';
import 'package:bloc_test/views/screens/character_details_screen.dart';
import 'package:bloc_test/views/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/web_services/characters_web_services.dart';

class AppRouter {
  late CharacterRepo characterRepo;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepo = CharacterRepo(CharactersWebServices());
    charactersCubit = CharactersCubit(characterRepo);
  }

  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => charactersCubit,
                  child: const CharactersScreen(),
                ));

      case characterDetailsScreen:
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
          builder: (context) =>
              CharacterDetailsScreen(characterModel: character),
        );
    }
    return null;
  }
}
