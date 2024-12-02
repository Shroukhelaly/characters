import 'package:bloc_test/constance/colors.dart';
import 'package:bloc_test/views/screens/character_details_screen.dart';
import 'package:flutter/material.dart';
import '../../constance/constance.dart';
import '../../data/models/character_model.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    super.key,
    required this.characterModel,
  });

  final CharacterModel characterModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, characterDetailsScreen, arguments: characterModel);
          },
          child: GridTile(
            footer: Hero(
              tag: characterModel.id!,
              child: Container(
                width: double.infinity,
                color: Colors.black54,
                alignment: Alignment.bottomCenter,
                child: Text(
                  '${characterModel.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    height: 1.3,
                    color: MyColors.white,

                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            child: Container(
              color: MyColors.gray,
              child: characterModel.image!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: characterModel.image!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(''),
            ),
          ),
        ),
      ),
    );
  }
}
