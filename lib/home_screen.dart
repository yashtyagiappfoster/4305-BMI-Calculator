import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? bmi;

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    _formKey = GlobalKey<FormState>();
    setState(() {});
  }

  void calculateBMI() {
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);

    double heightSquare = height * height;
    double result = weight / heightSquare;
    bmi = result;
    setState(() {});
    print(bmi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: resetFields, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, right: 25, left: 25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.trending_up,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Height',
                    hintText: 'Height in cm',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || double.parse(value) == 0.0) {
                      return 'Please enter the valid height';
                    }
                  },
                  // onSaved: (value) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.trending_up,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Weight',
                    hintText: 'Weight in kg',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || double.parse(value) == 0.0) {
                      return 'Please enter the valid Weight';
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      calculateBMI();
                    }
                  },
                  child: const Text(
                    'Calculate BMI',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  bmi == null
                      ? "Enter the Value"
                      : 'Result is : ${bmi!.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
