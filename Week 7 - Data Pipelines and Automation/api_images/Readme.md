## Nigeria Weather ETL: Data Pipelines & Automation

## Project Overview
This project demonstrates a simple but complete ETL (Extract, Transform, Load) pipeline built in Python. It automates the collection of real-time weather data for three major Nigerian cities — Abuja, Lagos, and Port Harcourt — processes and cleans that data, and stores it for analysis. The project was developed and run in Google Colab.

---

## Data Source
•	API: OpenWeatherMap API
•	Endpoint: http://api.openweathermap.org/data/2.5/weather
•	Cities Covered: Abuja, Lagos, Port Harcourt
•	Data Collected On: 2026-06-23
•	Units: Metric (°C for temperature, m/s for wind speed)
The API returns current weather data including temperature, feels-like temperature, humidity, weather condition description, and wind speed.

---

## ETL Process
### Extract → Transform → Load

| Stage | Description | 
|---|---| 
| Extract | Pulled live weather data from the OpenWeatherMap API for 3 cities and saved it as a raw CSV file (nigeria_weather.csv)| 
| Transform | Loaded the CSV into a Pandas DataFrame, renamed columns for consistency, validated data types, and checked for missing values | 
| Load | Saved the cleaned dataset as both a CSV (processed_weather_data.csv) and an Excel file (Cleaned_Weather_Dataset.xlsx) for downstream use |

---

## Tools Used
•	Python 3 — Core programming language
•	Google Colab — Cloud-based notebook environment
•	requests — For making HTTP calls to the OpenWeatherMap API
•	csv — For writing raw extracted data to a CSV file
•	pandas — For data transformation, cleaning, and analysis
•	datetime — For timestamping each data record
•	OpenWeatherMap API — Source of real-time weather data

---

## Steps Taken
### Step 1 — Data Extraction
•	Imported the requests, csv, and datetime libraries
•	Defined the target cities and API key
•	Looped through each city, sent a GET request to the API, and parsed the JSON response
•	Extracted temperature, feels-like temperature, humidity, weather condition, and wind speed
•	Wrote all records, along with a timestamp, into nigeria_weather.csv

