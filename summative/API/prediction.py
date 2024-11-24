import joblib  # Use joblib to load the model
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
import numpy as np
from fastapi.middleware.cors import CORSMiddleware
import uvicorn

# Load the pre-trained model using joblib
model = joblib.load('best_model.pkl')  # This is where you load your model

app = FastAPI()


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins, or specify allowed domains
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class LifeExpectancyInput(BaseModel):
    
    adult_mortality: float = Field(..., ge=0, le=2000 ,alias="Adult Mortality")
    infant_deaths: float = Field(..., ge=0, le=2000 ,alias="infant deaths")
    gdp: int = Field(..., ge=0, alias="GDP")
    population: float = Field(..., ge=1, le=1000000000 ,alias="Population" )

@app.post("/predict")
def predict_life_expectancy(input_data: LifeExpectancyInput):
    try:
        # Prepare the input data for prediction (convert the fields to a NumPy array)
        features = np.array([[input_data.adult_mortality, input_data.infant_deaths, input_data.gdp, input_data.population]])
        
        # Make the prediction
        prediction = model.predict(features)
        
        # Return the prediction as a JSON response
        return {"Life expectancy": prediction[0]}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction failed: {str(e)}")

# To run the app, use the command: uvicorn prediction:app --reload
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080)