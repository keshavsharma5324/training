
class TrainingItemModel {
  final String? name;
  final String? price;
  final String? description;
  final String? teacher;
  final String? imageAsset;
  final DateTime? dateTime;
  final String? location;

  TrainingItemModel({
    this.name,
    this.price,
    this.description,
    this.teacher,
    this.imageAsset,
    this.dateTime,
    this.location
  });

  TrainingItemModel copyWith({
    String? name,
    String? price,
    String? description,
    String? teacher,
    String? imageAsset,
    DateTime? dateTime,
    String? location
  }) {
    return TrainingItemModel(
        name: name ?? this.name,
        price: price ?? this.price,
        description: description ?? this.description,
        teacher: teacher ?? this.teacher,
        imageAsset: imageAsset ?? this.imageAsset,
        dateTime: dateTime ?? this.dateTime,
        location: location ?? this.location
    );
  }
}