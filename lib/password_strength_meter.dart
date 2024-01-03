import 'package:flutter/material.dart';

class PasswordStrengthMeter extends StatelessWidget {
  final String password;
  final int numOfLevels;
  final int Function(String) calculateStrength;
  final bool dashed;
  final Color Function(double) getStrengthColor;
  final String Function(double) getStrengthLevelText;

  const PasswordStrengthMeter({
    Key? key,
    required this.password,
    this.numOfLevels = 5,
    List<Color>? strengthColors,
    int Function(String)? calculateStrength,
    Color Function(double)? getColor,
    String Function(double)? getStrengthLevel,
    this.dashed = false,
  })  : calculateStrength =
            calculateStrength ?? _defaultCalculatePasswordStrength,
        getStrengthColor = getColor ?? _defaultGetColorForPercentage,
        getStrengthLevelText =
            getStrengthLevel ?? _defaultGetStrengthLevelFromPercentage,
        super(key: key);

  static int _defaultCalculatePasswordStrength(String password) {
    int passwordStrength = 0;

    if (password.length < 8) {
      return passwordStrength;
    }

    if (password.length >= 8) {
      passwordStrength++;
    }

    if (password.length >= 12) {
      passwordStrength++;
    }

    RegExp upperAndLowerRegExp = RegExp(r'(?=.*[a-z])(?=.*[A-Z])');
    if (upperAndLowerRegExp.hasMatch(password)) {
      passwordStrength++;
    }

    RegExp reDigits = RegExp(r"\d+");
    if (reDigits.hasMatch(password)) {
      passwordStrength++;
    }

    RegExp specialCharRegExp = RegExp(r'[^\w\d]');
    if (specialCharRegExp.hasMatch(password)) {
      passwordStrength++;
    }
    return passwordStrength;
  }

  static Color _defaultGetColorForPercentage(double percentage) {
    if (percentage == 0) {
      return Colors.grey[300]!;
    } else if (percentage <= 0.2) {
      return Colors.red;
    } else if (percentage <= 0.4) {
      return Colors.orange;
    } else if (percentage <= 0.6) {
      return Colors.yellow;
    } else if (percentage <= 0.8) {
      return Colors.lightGreen;
    } else {
      return Colors.green;
    }
  }

  static String _defaultGetStrengthLevelFromPercentage(double percentage) {
    if (percentage == 0) {
      return 'Too short';
    } else if (percentage <= 0.2) {
      return 'Weak';
    } else if (percentage <= 0.4) {
      return 'Moderate';
    } else if (percentage <= 0.6) {
      return 'Okay';
    } else if (percentage <= 0.8) {
      return 'Strong';
    } else {
      return 'Very Strong';
    }
  }

  @override
  Widget build(BuildContext context) {
    int strength = calculateStrength(password);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Password Strength:'),
        _buildStrengthIndicator(strength),
      ],
    );
  }

  Widget _buildStrengthIndicator(int strength) {
    double strengthPercentage;
    if (numOfLevels > 5 &&
        calculateStrength == _defaultCalculatePasswordStrength) {
      if (strength == 0) {
        strengthPercentage = 0;
      } else {
        strengthPercentage = (strength + numOfLevels - 5) / numOfLevels;
      }
    } else {
      strengthPercentage = strength / numOfLevels;
    }
    strengthPercentage = strengthPercentage > 1 ? 1 : strengthPercentage;
    strengthPercentage = strengthPercentage < 0 ? 0 : strengthPercentage;

    Color indicatorColor = getStrengthColor(strengthPercentage);
    String strengthText = getStrengthLevelText(strengthPercentage);
    int segmentLength = (200 - 3 * (numOfLevels - 1)) ~/ numOfLevels;

    List<Widget> segments = List.generate(
      numOfLevels,
      (index) {
        Color segmentColor = strengthPercentage >= (index + 1) / numOfLevels
            ? indicatorColor
            : Colors.grey[300]!;
        return Padding(
          padding: const EdgeInsets.only(right: 3),
          child: Container(
            height: 10.0,
            width: segmentLength.toDouble(),
            color: segmentColor,
          ),
        );
      },
    );

    return Row(
      children: [
        dashed
            ? Row(children: segments)
            : Container(
                width: 200.0,
                height: 10.0,
                color: indicatorColor,
              ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(strengthText),
        ),
      ],
    );
  }
}
