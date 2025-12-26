class Gym {
  final String name;
  final String location;
  final String description;
  final String built;
  final String type;
  final List<String> imageUrls;
  final bool isFavorite;
  final Map<String, String> schedule;
  final String imageAsset;


  Gym({
    required this.name,
    required this.location,
    required this.description,
    required this.built,
    required this.type,
    required this.imageUrls,
    this.isFavorite = false,
    required this.schedule,
    required this.imageAsset,
  });
}
