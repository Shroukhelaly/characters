import 'package:bloc_test/constance/colors.dart';
import 'package:bloc_test/data/models/character_model.dart';
import 'package:bloc_test/logic/cubit_cubit.dart';
import 'package:bloc_test/logic/cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<CharacterModel>? allCharacters;
  List<CharacterModel>? searchedCharacter;
  bool isSearched = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  void addSearchesItemToSearchList(String searchCharacter) {
    searchedCharacter = allCharacters!
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearched) {
      return [
        IconButton(
            onPressed: () {
              clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.gray,
            )),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            startSearch();
          },
          icon: const Icon(
            Icons.search_outlined,
            color: MyColors.gray,
          ),
        )
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));

    setState(() {
      isSearched = true;
    });
  }

  void stopSearch() {
    clearSearch();
    setState(() {
      isSearched = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  Widget buildBlocWidget() => BlocBuilder<CharactersCubit, CharactersStates>(
        builder: (context, states) {
          if (states is CharactersLoadedState) {
            allCharacters = (states).characters;
            return buildLoadedListWidget();
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: MyColors.yellow,
              ),
            );
          }
        },
      );

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.gray,
        child: Column(
          children: [
            buildCharacterItem(),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 2 / 3,
        ),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: searchController.text.isEmpty
            ? allCharacters!.length
            : searchedCharacter!.length,
        itemBuilder: (context, index) => CharacterItem(
          characterModel: searchController.text.isEmpty
              ? allCharacters![index]
              : searchedCharacter![index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MyColors.yellow,
          title: isSearched
              ? TextField(
                  controller: searchController,
                  cursorColor: MyColors.gray,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Find a character...',
                      hintStyle: TextStyle(
                        color: MyColors.gray,
                        fontSize: 18,
                      )),
                  onChanged: (searchCharacter) {
                    addSearchesItemToSearchList(searchCharacter);
                  },
                )
              : const Text(
                  'Characters',
                  style: TextStyle(
                    color: MyColors.gray,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          actions: buildAppBarActions(),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            final bool connected =
                !connectivity.contains(ConnectivityResult.none);
            if (connected) {
              return buildBlocWidget();
            } else {
              return buildOfflineWidget();
            }
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}

Widget buildOfflineWidget() {
  return Center(
    child: Container(
      color: MyColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Can\'t Connect... Check Internet',
            style: TextStyle(
              fontSize: 22,
              color: MyColors.gray,
            ),
          ),
          Image.asset('assets/images/offline.png'),
        ],
      ),
    ),
  );
}
