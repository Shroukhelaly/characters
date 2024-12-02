import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_test/constance/colors.dart';
import 'package:bloc_test/data/models/character_model.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({
    super.key,
    required this.characterModel,
  });

  final CharacterModel characterModel;

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      backgroundColor: MyColors.gray,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          '${characterModel.nikName}',
          style: const TextStyle(
            color: MyColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Hero(
            tag: characterModel.id!,
            child: Image.network(
              characterModel.image!,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterInfo({required String title, required String value}) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: MyColors.white,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            fontSize: 16,
            color: MyColors.white,
          ),
        ),
      ]),
    );
  }

  Widget buildDivider({required double endIndent}) {
    return Divider(
      color: MyColors.yellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget displayCharacterQuotes() {
    return Container(
      alignment: Alignment.centerRight,
      width: 300.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 25,
          color: MyColors.yellow,
          shadows: [
            Shadow(
              blurRadius: 7.0,
              color: MyColors.yellow,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText(
              'No Quotes Available',
            ),
          ],
          onTap: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.gray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 2),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    characterInfo(
                        title: 'Id : ', value: '${characterModel.id}'),
                    buildDivider(endIndent: 350),
                    characterInfo(
                        title: 'Name : ', value: characterModel.name!),
                    buildDivider(endIndent: 315),
                    characterInfo(
                        title: 'NikName : ', value: characterModel.nikName!),
                    buildDivider(endIndent: 290),
                    characterInfo(
                        title: 'Status : ', value: characterModel.status!),
                    buildDivider(endIndent: 315),
                    characterInfo(
                        title: 'Species : ',
                        value: '${characterModel.species}'),
                    buildDivider(endIndent: 305),
                    displayCharacterQuotes(),
                    const SizedBox(
                      height: 500,
                    ),

                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
