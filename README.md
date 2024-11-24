# Life Expectancy Predictor

This project provides a Life Expectancy Prediction API that uses various input variables to predict life expectancy. The API is deployed on Render and can be accessed publicly for testing and integration.

Additionally, the project includes a Flutter mobile app that makes requests to the API and displays the predicted life expectancy based on user input.

Public API Endpoint
The Life Expectancy Prediction API is hosted and can be accessed through the following URL:

https://life-expectancy-c830.onrender.com/

API Documentation (Swagger UI)

You can use the Swagger UI to interact with the API and make predictions by providing the required input values.

API Endpoint:
POST /predict: Accepts a JSON payload with the following fields:
Adult Mortality (float): Adult mortality rate.
infant deaths (float): Infant mortality rate.
GDP (float): Gross Domestic Product in USD.
Population (float): Population of the country.


Mobile App (Flutter)
The mobile app is built using Flutter and allows users to enter values for GDP, Adult Mortality, Infant Deaths, and Population to get a prediction for life expectancy.

Instructions to Run the Flutter App
Clone the Repository:

Clone the repository to your local machine:
bash
Copy code
git clone https://github.com/MAHAMAT263/linear_regression_model
cd linear_regression_model/FlutterApp
Install Dependencies:

Ensure that you have Flutter installed on your system. If not, follow the official Flutter installation guide: Flutter Installation.
Install the necessary dependencies by running:
bash
Copy code
flutter pub get


Run the Flutter App:

Connect a device or use an emulator, then run the app:
bash
Copy code
flutter run
Enter the Required Data:

Enter values for GDP, Adult Mortality, Infant Deaths, and Population in the app and press the Predict button to see the life expectancy prediction.
Video Demo
You can watch the video demo of this project, which provides a brief walkthrough of the functionality of the API and the flutter app

link to the demo video:
https://youtu.be/MxaXlzNVmU4 