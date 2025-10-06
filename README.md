# ✈️ Air Traffic Analysis: SQL + Tableau

This project analyzes flight and airport data from 2018–2019 to help a hypothetical company decide which of three major U.S. airlines to invest in.  
It combines **SQL-based data analysis** with **interactive Tableau visualizations** to extract actionable business insights on cancellations, delays, and airline performance.

---

## 📂 Project Structure

| Folder | Description |
|--------|--------------|
| `sql/` | Annotated SQL queries answering business questions about flight volume, cancellations, miles, and delays |
| `tableau/` | Tableau workbook (`.twb`) with dashboards and story presentation |

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

## 💡 Key Findings (from SQL)

**Dataset coverage**
- Total flights (2018–2019): **6,521,361**  
  • 2018: **3,218,653** • 2019: **3,302,708**

**Reliability overview**
- Late departures: **2,540,874** (**38.96%** of all flights)  
- Cancellations: **92,363** (**1.42%**)  
- Late **or** cancelled combined: **2,633,237** (**40.38%**)

**Cancellation reasons (share of all flights)**
- Weather: **50,225** (**0.77%**)  
- Carrier: **34,141** (**0.52%**)  
- National Air System: **7,962** (**0.12%**)  
- Security: **35** (**0.00%**)

**2019 monthly seasonality (cancel % of flights)**
- Peak cancellations: **April 2.71%**, **March 2.50%**, **May 2.42%**  
- Lowest cancellations: **December 0.51%**, **November 0.59%**, **October 0.81%**  
- Flight volume (2019) highest in **July (291,955)** and **August (290,493)**; lowest in **February (237,896)**.  
  ⇒ Clear summer demand peak; higher spring cancellations likely weather/system related.

**YoY performance by airline (2019 vs 2018; non-cancelled flights only)**
- **Delta Air Lines**: **+5.78%** miles, **+4.69%** flights  
- **American Airlines**: **+0.04%** miles, **+2.74%** flights  
- **Southwest**: **–1.32%** miles, **–0.30%** flights

**Most popular destination airports (overall top 10)**
1. Hartsfield-Jackson Atlanta Intl — **595,527**  
2. Dallas/Fort Worth Intl — **314,423**  
3. Phoenix Sky Harbor Intl — **253,697**  
4. Los Angeles Intl — **238,092**  
5. Charlotte Douglas Intl — **216,389**  
6. Harry Reid Intl — **200,121**  
7. Denver Intl — **184,935**  
8. Baltimore/Washington Intl — **168,334**  
9. Minneapolis–St Paul Intl — **165,367**  
10. Chicago Midway Intl — **165,007**

**Fleet & utilization (2018–2019)**
- Unique aircraft (tail numbers): **AA 993**, **DL 988**, **WN 754**  
- Avg miles per aircraft (non-cancelled flights):  
  • **Southwest ~2,637,233**  
  • **American ~1,853,159**  
  • **Delta ~1,748,245**

**On-time performance by time of day (avg departure delay)**
- Morning: **7.80 min** • Afternoon: **13.48 min** • Evening: **18.04 min** • Night: **7.67 min**  
  ⇒ Congestion accumulates through the day; evenings are most delayed.

**Airports with highest avg *morning* delay (≥10k flights)**
- San Francisco Intl (**13.22**), George Bush Intercontinental/Houston (**12.42**), Chicago O’Hare (**11.33**),  
  Dallas/Fort Worth (**11.28**), Los Angeles (**10.80**), Seattle/Tacoma (**10.12**), Chicago Midway (**9.81**),  
  Tulsa (**9.57**), Boston Logan (**8.72**), Raleigh-Durham (**8.65**).

---

## 📈 Investment Guidance (from analysis)

- **Recommend Overweight: Delta Air Lines** — simultaneous growth in **miles (+5.78%)** and **flights (+4.69%)** signals healthy expansion with balanced fleet utilization (~1.75M miles/aircraft).  
- **Neutral/Hold: American Airlines** — modest **miles (+0.04%)** with **flights (+2.74%)** suggests mix shift toward shorter routes; large fleet implies higher fixed costs but broad network resilience.  
- **Underweight: Southwest** — declines in **miles (–1.32%)** and **flights (–0.30%)** despite the **highest miles per aircraft (~2.64M)** point to tighter fleet leverage and potential maintenance/ops cost pressure.  
- **Operational risk note:** Carriers with heavy exposure to high-delay hubs (e.g., SFO, IAH, ORD, LAX) may see elevated knock-on delays and customer-experience costs; spring months carry higher cancel risk.

> Overall: **Delta** offers the strongest momentum and operational balance in this 2018–2019 window; **American** is steady but route-mix dependent; **Southwest** shows softening activity and higher per-aircraft strain.

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
