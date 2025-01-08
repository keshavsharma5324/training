import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trainings/data/training_list_data.dart';
import 'package:trainings/models/filters_model.dart';
import 'package:trainings/models/trainings_model.dart';
import 'package:trainings/widgets/listItem.dart';
import 'package:trainings/widgets/showModalBottomSheet.dart';

class TrainingsDashboard extends StatefulWidget {
  const TrainingsDashboard({super.key});

  @override
  State<TrainingsDashboard> createState() => _TrainingsDashboardState();
}

class _TrainingsDashboardState extends State<TrainingsDashboard> {
  final _filtersSubject = BehaviorSubject<List<FiltersModel>>();
  late CarouselSliderController _sliderController;
  final ScrollController controller = ScrollController();
  List<FiltersModel> filters = [];

  final List<OptionsModel> optionsLocations = [];
  final List<OptionsModel> optionsTrainer = [];
  final List<OptionsModel> optionsTrainingName = [];

  List<TrainingItemModel> filteredList = [];
  List<TrainingItemModel> trainingList = TrainingListData().trainingList;

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
    trainingList.forEach((element) {
      if (!optionsLocations.any((elt) => elt.name == element.location)) {
        optionsLocations
            .add(OptionsModel(name: element.location, isChecked: false));
      }
      if (!optionsTrainer.any((elt) => elt.name == element.teacher)) {
        optionsTrainer
            .add(OptionsModel(name: element.teacher, isChecked: false));
      }
      if (!optionsTrainingName.any((elt) => elt.name == element.name)) {
        optionsTrainingName
            .add(OptionsModel(name: element.name, isChecked: false));
      }
    });
    filteredList.addAll(trainingList);
    filters = [
      FiltersModel(
          isSelected: false, name: 'Location', resultList: optionsLocations),
      FiltersModel(
          isSelected: false, name: 'Training Name', resultList: optionsTrainingName),
      FiltersModel(
          isSelected: false, name: 'Trainer', resultList: optionsTrainer)
    ];
    _filtersSubject.value = filters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 350,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 250,
                          color: Colors.red,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 32),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Trainings',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.horizontal_split,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Highlights',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: InkWell(
                              onTap: () {
                                ModalSheet().showModalSheet(
                                    context, filters, TrainingListData().trainingList, (listData) {
                                  setState(
                                    () {
                                      if (listData.isNotEmpty) {
                                        filteredList = listData;
                                      }
                                    },
                                  );
                                }, _filtersSubject);
                              },
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Icon(
                                    Icons.segment,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      'Filter',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 150,
                    child: Stack(
                      children: [
                        Container(
                          height: 140,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: CarouselSlider.builder(
                            carouselController: _sliderController,
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              return ListItem().carouselListItem(
                                  trainingList[index], context);
                            },
                            itemCount: trainingList.length,
                            options: CarouselOptions(
                                enlargeCenterPage: true,
                                initialPage: 0,
                                aspectRatio: 16 / 7,
                                viewportFraction: 1),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 60,
                          child: InkWell(
                            onTap: () {
                              _sliderController.previousPage();
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: .5),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 60,
                          child: InkWell(
                            onTap: () {
                              _sliderController.nextPage();
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: .5),
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredList.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return ListItem()
                        .trainingListItem(filteredList[index], context);
                  })
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
