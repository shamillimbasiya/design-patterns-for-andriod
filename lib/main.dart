import 'package:flutter/material.dart';
import 'password_strength_meter.dart';
import 'steps_left.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _password = "";
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  onChanged: (value) => setState(() => _password = value),
                  keyboardType: TextInputType.visiblePassword,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              PasswordStrengthMeter(
                password: _password,
                dashed: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: PasswordStrengthMeter(
                  password: _password,
                  dashed: false,
                  numOfLevels: 3,
                  calculateStrength: (password) {
                    int strength = 0;
                    if (password.length > 4) strength++;
                    if (password.length > 8) strength++;
                    if (password.length > 16) strength++;
                    return strength;
                  },
                  getColor: (percentage) {
                    if (percentage == 0) {
                      return Colors.black;
                    } else if (percentage <= .34) {
                      return Colors.pink[400]!;
                    } else if (percentage <= .67) {
                      return Colors.amber[600]!;
                    }
                    return Colors.purple;
                  },
                  getStrengthLevel: (percentage) {
                    if (percentage == 0) {
                      return "Too short";
                    } else if (percentage <= .34) {
                      return "Bad";
                    } else if (percentage <= .67) {
                      return "Okay";
                    }
                    return "Good";
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: StepsLeft(
                    currentStep: _counter,
                    steps: const ["Order Placed", "In Review", "Approved"]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: StepsLeft(
                  currentStep: _counter,
                  steps: const [
                    "Order Placed",
                    "In Review",
                    "Approved",
                    "Sent",
                    "Received",
                  ],
                  thinLine: false,
                  passedStepColor: Colors.green,
                  unpassedStepColor: Colors.yellow[400]!,
                  borderColor: Colors.pink[400]!,
                  stepTextColor: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '${_counter + 1}',
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
