class UserModel {
  List<String> imageUrl;
  String name;
  String countryFlag;
  String userHeight;
  String distance;
  String age;
  String religion;
  String description;
  String professional;
  // String
  UserModel(
      {required this.age,
      required this.professional,
      required this.religion,
      required this.description,
      required this.countryFlag,
      required this.distance,
      required this.imageUrl,
      required this.name,
      required this.userHeight});
}
