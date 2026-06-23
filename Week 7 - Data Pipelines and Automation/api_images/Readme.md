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

---

### Data Extraction

![Data Extracted](Week 7 - Data Pipelines and Automation/data_extraction.png)

---

### Step 2 — Data Transformation
•	Loaded nigeria_weather.csv into a Pandas DataFrame
•	Displayed the original dataset to inspect its structure
•	Renamed columns to Python-friendly names (e.g., Temperature (°C) → Temperature_C)
•	Converted columns to appropriate data types (float for temperatures and wind speed, int for humidity)
•	Ran a missing values check — confirmed zero null values across all columns
•	Saved the cleaned dataset as Cleaned_Weather_Dataset.xlsx

---

### Data Cleaning

![Cleaned Data](Week 7 - Data Pipelines and Automation/data_cleaning.png)

---

### Step 3 — Data Loading
•	Exported the final, cleaned DataFrame to processed_weather_data.csv using weather_df.to_csv() with index=False
•	Confirmed successful save with a print statement

---

### Data Loading

![Loaded Data](Week 7 - Data Pipelines and Automation/data_loading.png)

---

### Step 4 — Basic Analysis
•	Compared temperature readings across all three cities
•	Identified the city with the highest humidity using idxmax()
•	Displayed weather conditions (sky/precipitation descriptions) per city
•	Generated a summary of key findings

---

### Analysis

![Analyzed Data](Week 7 - Data Pipelines and Automation/basic_analysis.png)

---

## Key Findings
Based on weather data collected on 2026-06-23:
•	Lagos recorded the highest temperature at 30.44°C, followed by Port Harcourt (29.22°C) and Abuja (28.84°C).
•	Port Harcourt had the highest humidity at 65%, compared to Abuja (62%) and Lagos (60%).
•	Abuja and Lagos both experienced broken clouds, while Port Harcourt had light rain.
•	All feels-like temperatures were notably higher than actual temperatures, ranging from 31.06°C (Abuja) to 33.69°C (Lagos), reflecting the humid tropical conditions.
•	No missing values were found in the dataset, confirming clean and complete data extraction.

---

Output Files
| File | Description | 
|---|---| 
| nigeria_weather.csv | Raw data extracted directly from the API | 
| Cleaned_Weather_Dataset.xlsx | Cleaned and transformed dataset in Excel format | 
| processed_weather_data.csv | Final cleaned dataset saved as CSV for further analysis | 

---

How to Run
1.	Open the notebook in Google Colab
2.	Replace API_KEY in the extraction cell with your own OpenWeatherMap API key
3.	Run all cells from top to bottom
4.	Download the output files using the files.download() cells provided



