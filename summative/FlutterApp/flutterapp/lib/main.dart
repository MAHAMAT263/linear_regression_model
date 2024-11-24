import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(LifeExpectancyApp());
}

class LifeExpectancyApp extends StatelessWidget {
  const LifeExpectancyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Expectancy Predictor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LifeExpectancyPage(),
    );
  }
}

class LifeExpectancyPage extends StatefulWidget {
  const LifeExpectancyPage({super.key});

  @override
  _LifeExpectancyPageState createState() => _LifeExpectancyPageState();
}

class _LifeExpectancyPageState extends State<LifeExpectancyPage> {
  final TextEditingController _gdpController = TextEditingController();
  final TextEditingController _mortalityController = TextEditingController();
  final TextEditingController _infantDeathsController = TextEditingController();
  final TextEditingController _populationController = TextEditingController();

  String _prediction = ""; // To store the prediction result

  // Function to make the POST request
  Future<void> _makePrediction() async {
    final url =
        Uri.parse('http://10.0.2.2:8080/predict'); // Replace with your API URL

    // Prepare the data for the API request
    Map<String, dynamic> data = {
      "Adult Mortality": double.tryParse(_mortalityController.text) ?? 0.0,
      "infant deaths": double.tryParse(_infantDeathsController.text) ?? 0.0,
      "GDP": double.tryParse(_gdpController.text) ?? 0.0,
      "Population": double.tryParse(_populationController.text) ?? 0.0,
    };

    // Send a POST request to the API
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          _prediction =
              "Predicted Life Expectancy: ${responseData['Life expectancy']}";
        });
      } else {
        setState(() {
          _prediction = "Error: Unable to fetch prediction.";
        });
      }
    } catch (e) {
      setState(() {
        _prediction = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Life Expectancy Predictor',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[600],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Predict Life Expectancy by entering the following variables:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // GDP Input Field
            TextField(
              controller: _gdpController,
              decoration: const InputDecoration(
                labelText: 'GDP in USD',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Adult Mortality Input Field
            TextField(
              controller: _mortalityController,
              decoration: const InputDecoration(
                labelText: 'Adult Mortality',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Infant Deaths Input Field
            TextField(
              controller: _infantDeathsController,
              decoration: const InputDecoration(
                labelText: 'Infant Deaths',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Population Input Field
            TextField(
              controller: _populationController,
              decoration: const InputDecoration(
                labelText: 'Population',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Predict Button
            Center(
              child: ElevatedButton(
                onPressed: _makePrediction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Predict'),
              ),
            ),
            const SizedBox(height: 20),
            // Display Prediction or Error Message
            Text(
              _prediction,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
