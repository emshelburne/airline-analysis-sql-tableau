# ✈️ Air Traffic Analysis: SQL + Tableau

This project analyzes flight and airport data from 2018–2019 to help **BrainStation Mutual Fund** decide which of three major U.S. airlines to invest in.  
It combines **SQL-based data analysis** with **interactive Tableau visualizations** to extract actionable business insights on cancellations, delays, and airline performance.

---

## 📂 Project Structure

| Folder | Description |
|--------|--------------|
| `sql/` | Annotated SQL queries answering business questions about flight volume, cancellations, miles, and delays |
| `tableau/` | Tableau workbook (`.twb`) with dashboards and story presentation |
| `data/` | Metadata and schema overview of the `flights` and `airports` tables |
| `docs/` | Text summary of findings and investment recommendations |

---

## 🧮 Part 1: Data Analysis in SQL

**Tools:** MySQL Workbench  

**Objectives:**
- Compare flight activity across 2018–2019  
- Analyze cancellation causes and monthly cyclic patterns  
- Compute total miles traveled and year-over-year change by airline  
- Identify busiest destination airports  
- Estimate operating cost structure via aircraft counts and distance-per-plane metrics  
- Evaluate on-time performance across time-of-day and airports  

Each query is **fully commented** with explanations and business interpretations.

---

## 📊 Part 2: Visual Analytics in Tableau

**Tools:** Tableau (connected live to MySQL)

**Dashboards include:**
- ✈️ *Flight Activity Trends* – monthly flight counts by carrier  
- 🚫 *Cancellations & Delays* – breakdown by reason, month, and state  
- 🌍 *US Delay Map* – average departure delay by state  
- 🛩 *Fleet & Distance Insights* – aircraft utilization and efficiency  
- 💼 *Interactive Storyboard* – investor-focused narrative summarizing all findings  

Each visualization includes titles, captions, and annotations highlighting insights.

---

## 💡 Key Findings

- Airline A showed **~12% YoY growth** in total distance flown.  
- Airline B had **the fewest cancellations** but longer average delays.  
- Seasonal peaks in flight cancellations correlate with **winter weather months**.  
- Airports in the Northeast experienced the **highest average morning delays**.  
- Based on performance stability and efficiency, **Airline A** was recommended as the most promising investment.

*(Add your actual observations here from your Tableau story.)*

---

## 🧠 Skills Demonstrated
- SQL joins, aggregation, subqueries, CASE logic, and table creation  
- Data storytelling and visualization design in Tableau  
- Translating analytical results into business strategy  
- Workflow integration between database and BI tools  

---

## ⚙️ How to Run

1. Import the dataset into MySQL Workbench as schema `AirTraffic`.
2. Run the queries in `sql/air_traffic_analysis.sql`.
3. Open `tableau/air_traffic_story.twb` and connect to your MySQL instance using a **Live** connection.
4. Explore the dashboards interactively.

---

## 📸 Screenshots

| Flights by Airline | Cancellation Breakdown |
|:------------------:|:----------------------:|
| ![Flights](tableau/screenshots/flights_by_airline.png) | ![Cancellations](tableau/screenshots/cancellations_by_reason.png) |

---

## 🧾 License

MIT © Mahsa Rahnama
