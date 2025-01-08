import 'package:flutter/material.dart';
import 'package:trainings/models/trainings_model.dart';

class TrainingDetail extends StatefulWidget {
  final TrainingItemModel? trainingItemModel;
  const TrainingDetail({this.trainingItemModel, super.key});

  @override
  State<TrainingDetail> createState() => _TrainingDetailState();
}

class _TrainingDetailState extends State<TrainingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: 700,
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Stack(
                  children: [
                    Image.asset(
                      widget.trainingItemModel?.imageAsset ?? '',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 40,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 24,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        widget.trainingItemModel?.name ?? '',
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Column(children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.trainingItemModel?.description ?? '',
                        maxLines: 10,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.red),
                          padding: EdgeInsets.all(6),
                          child: Text(
                            'Go Back',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      )),
                ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
