import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trainings/models/filters_model.dart';
import 'package:trainings/models/trainings_model.dart';

class ModalSheet {
  void showModalSheet(
    context,
      List<FiltersModel> filters,
    List<TrainingItemModel> trainingList,
    Function(List<TrainingItemModel> listData) reload,
    BehaviorSubject<List<FiltersModel>> filtersSubject,
  ) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (BuildContext context) {
        return Container(
          height: 400,
          color: Colors.white,
          child: Column(
            children: [
              ListTile(
                trailing: InkWell(
                  onTap: () {
                    List<TrainingItemModel> sortedData = trainingList;
                    List<TrainingItemModel> filtered = [];
                    for (var ele in sortedData) {
                      for (var element in filters) {
                        element.resultList?.forEach((elt) {
                          if (elt.isChecked ?? false) {
                            if (ele.teacher == elt.name ||
                                ele.name == elt.name ||
                                ele.location == elt.name) {
                              filtered.add(ele);
                            }
                          }
                        });
                      }
                    }
                    reload(filtered.isNotEmpty ? filtered : trainingList);
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    size: 32,
                    color: Colors.red,
                  ),
                ),
                title: Text('Filter'),
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      children: [
                        StreamBuilder<List>(
                            stream: filtersSubject,
                            builder: (ctx, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.length ?? 0,
                                    itemBuilder: (ctx, index) {
                                      return ListTile(
                                        onTap: () {
                                          var getLastSelectedIndex =
                                              filters.indexWhere(
                                                  (e) => e.isSelected == true);
                                          if (getLastSelectedIndex != -1) {
                                            filters[getLastSelectedIndex]
                                                .isSelected = false;
                                          }
                                          filters[index].isSelected = true;
                                          filtersSubject.value = filters;
                                        },
                                        title: Text(filters[index].name ?? ''),
                                        titleTextStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                        selectedColor: Colors.red,
                                        selected: filtersSubject
                                                .value[index].isSelected ??
                                            false,
                                      );
                                    });
                              } else {
                                return SizedBox.shrink();
                              }
                            })
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: SizedBox(
                        height: 275,
                        child: StreamBuilder<List>(
                          stream: filtersSubject,
                          builder: (ctx, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.isNotEmpty &&
                                snapshot.data!
                                    .any((elt) => elt.isSelected == true)) {
                              var selectedIndex = snapshot.data!
                                  .indexWhere((elt) => elt.isSelected == true);
                              if (selectedIndex != -1) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: filtersSubject
                                            .value[selectedIndex]
                                            .resultList
                                            ?.length ??
                                        0,
                                    itemBuilder: (ctx, index) {
                                      return ListTile(
                                        leading: Checkbox(
                                            value: filtersSubject
                                                .value[selectedIndex]
                                                .resultList?[index]
                                                .isChecked,
                                            onChanged: (value) {
                                              filters[selectedIndex]
                                                  .resultList?[index]
                                                  .isChecked = value;
                                              filtersSubject.value = filters;
                                            }),
                                        title: Text(filtersSubject
                                                .value[selectedIndex]
                                                .resultList?[index]
                                                .name ??
                                            ''),
                                      );
                                    });
                              } else {
                                return SizedBox.shrink();
                              }
                            } else {
                              return ListTile(
                                title: Text('Please Select Filter Type'),
                              );
                            }
                          },
                        )),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
