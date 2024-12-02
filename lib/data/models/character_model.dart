class CharacterModel {
   int? id;
   String? image;
   String? name;
   String? status;
   String? nikName;
   String? species;

  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    status = json['status'];
    nikName =json['origin']['name'];
    species = json['species'];

  }
}