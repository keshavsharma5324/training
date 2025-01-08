
class FiltersModel {
  String? name;
  bool? isSelected;
  List<OptionsModel>? resultList;

  FiltersModel({
    this.name,
    this.isSelected,
    this.resultList
  });

  FiltersModel copyWith({
    String? name,
    bool? isSelected,
  }) {
    return FiltersModel(
        name: name ?? this.name,
        isSelected: isSelected ?? this.isSelected,
        resultList: resultList
    );
  }
}

class OptionsModel {
  String? name;
  bool? isChecked;

  OptionsModel({
    this.name,
    this.isChecked,
  });

  FiltersModel copyWith({
    String? name,
    bool? isSelected,
  }) {
    return FiltersModel(
        name: name ?? this.name,
        isSelected: isChecked ?? this.isChecked
    );
  }
}