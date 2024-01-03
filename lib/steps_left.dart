import 'package:flutter/material.dart';

class StepsLeft extends StatelessWidget {
  final Color passedStepColor;
  final Color unpassedStepColor;
  final Color borderColor;
  final Color stepTextColor;
  final int currentStep;
  final List<String> steps;
  final bool thinLine;
  static const Color grey400 = Color(0xFFBDBDBD);

  const StepsLeft(
      {Key? key,
      required this.currentStep,
      required this.steps,
      this.passedStepColor = Colors.black,
      this.unpassedStepColor = grey400,
      this.borderColor = Colors.black,
      this.stepTextColor = Colors.white,
      this.thinLine = false})
      : super(key: key);

  Widget step(int index, Color stepColor, double circleSize) {
    return Column(
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: stepColor,
              border: index == currentStep
                  ? Border.all(width: 3, color: borderColor)
                  : null),
          alignment: Alignment.center,
          child: Text(
            "${index + 1}",
            style: TextStyle(color: stepTextColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Container(
              constraints: BoxConstraints(maxWidth: circleSize),
              child: Text(
                steps[index],
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              )),
        )
      ],
    );
  }

  Widget lineBetweenSteps(
      int index, double circleSize, Color currentStepColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: index < steps.length - 1
          ? Container(
              width: circleSize,
              height: thinLine ? 5 : 10,
              decoration: BoxDecoration(color: currentStepColor),
            )
          : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> segments = List.generate(steps.length, (index) {
      Color currentStepColor =
          index < currentStep ? passedStepColor : unpassedStepColor;
      double circleSize = 100 - (steps.length - 1) * 15.0;
      circleSize = circleSize < 45 ? 45 : circleSize;

      return Row(
        children: [
          step(index, currentStepColor, circleSize),
          lineBetweenSteps(index, circleSize, currentStepColor)
        ],
      );
    });

    return (SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: segments),
    ));
  }
}
