# Zomato Restaurant Data Analysis

End-to-end analysis of restaurant listings on Zomato — combining Python (EDA), SQL (MySQL), and Power BI to uncover patterns in pricing, customer ratings, online ordering, and dining preferences.

## Overview

This project analyzes a dataset of 148 restaurants to understand what drives customer ratings and engagement — specifically how factors like online ordering, table booking, restaurant type, and pricing relate to customer votes and satisfaction. It reflects a full analytics workflow: cleaning and exploring data in Python, querying it in SQL, and visualizing it in an interactive Power BI dashboard.

## Dataset

| Detail | Value |
|---|---|
| Records | 148 restaurants |
| Features | 7 (name, online_order, book_table, rate, votes, approx_cost for two, listed_in/type) |
| Cost range | ₹100 – ₹950 (for two people) |
| Restaurant types | Dining (110), Cafes (23), Other (8), Buffet (7) |

## Methodology

1. **Data Cleaning (Python)** — Converted the `rate` column (e.g. `4.1/5`) into a clean numeric float, renamed columns for SQL compatibility, and exported a clean CSV (`zomato_clean.csv`); confirmed no missing values across the dataset.
2. **Exploratory Data Analysis (Python)** — Used Pandas for grouping/aggregation and Matplotlib/Seaborn for visualization (count plots, histograms, box plots, heatmap).
3. **SQL Analysis (MySQL)** — Loaded the cleaned data into a MySQL table and wrote aggregation queries to quantify relationships between restaurant features and performance.
4. **Business Intelligence (Power BI)** — Built a 2-page interactive dashboard with DAX measures, slicers, and drill-down visuals connected directly to the cleaned dataset.

## Key Insights

- **Dining dominates the market but rates lowest** — 110 of 148 restaurants (74%) are listed as "Dining," yet this category has the lowest average rating (3.57★) of all restaurant types, with "Other" (3.91★), Buffet (3.84★), and Cafes (3.77★) all outperforming it.
- **Online ordering is a major engagement driver** — Restaurants offering online ordering average **3.86★** and **559 votes**, compared to **3.49★** and just **75 votes** for those without it — a ~7.4x difference in customer engagement.
- **Table booking signals a premium, higher-quality restaurant** — Restaurants offering table booking average **4.19★** at **₹694** for two, versus **3.60★** at **₹403** for those that don't — suggesting table booking is a marker of more established, well-run establishments rather than a standard feature (only 8 of 148 restaurants offer it).
- **Price correlates with rating, but moderately** — Average rating rises from **3.49★ (Budget, <₹300)** to **3.63★ (Mid-range, ₹300–600)** to **3.79★ (Premium, >₹600)** — cost buys some quality signal, but not a guarantee.
- **Top-voted restaurants outperform on rating too** — The most-voted restaurants (Empire Restaurant – 4,884 votes/4.4★, Meghana Foods – 4,401 votes/4.4★, Onesta – 2,556 votes/4.6★) all rate well above the dataset average, reinforcing that vote volume and quality tend to move together.

## SQL Analysis

All queries run against a MySQL table (`restaurants`) built from the cleaned dataset. Full script: [`sql/zomato.sql`](sql/zomato.sql)

```sql
-- Avg rating by restaurant type
SELECT restaurant_type, ROUND(AVG(rate),2) AS avg_rating, COUNT(*) AS total
FROM restaurants GROUP BY restaurant_type ORDER BY avg_rating DESC;

-- Online order impact on rating
SELECT online_order, ROUND(AVG(rate),2) AS avg_rating, ROUND(AVG(votes),0) AS avg_votes
FROM restaurants GROUP BY online_order;

-- Table booking impact
SELECT book_table, ROUND(AVG(rate),2) AS avg_rating, ROUND(AVG(approx_cost),0) AS avg_cost
FROM restaurants GROUP BY book_table;

-- Top 10 most-voted restaurants
SELECT name, votes, rate, restaurant_type FROM restaurants ORDER BY votes DESC LIMIT 10;

-- Cost bucket vs rating
SELECT
  CASE WHEN approx_cost < 300 THEN 'Budget'
       WHEN approx_cost < 600 THEN 'Mid-range'
       ELSE 'Premium' END AS cost_bucket,
  ROUND(AVG(rate),2) AS avg_rating, COUNT(*) AS total
FROM restaurants GROUP BY cost_bucket;
```

### Query Results

**Avg rating by restaurant type**

| Type | Avg Rating | Count |
|---|---|---|
| Other | 3.91 | 8 |
| Buffet | 3.84 | 7 |
| Cafes | 3.77 | 23 |
| Dining | 3.57 | 110 |

**Online order impact**

| Online Order | Avg Rating | Avg Votes |
|---|---|---|
| Yes | 3.86 | 559 |
| No | 3.49 | 75 |

**Table booking impact**

| Book Table | Avg Rating | Avg Cost (₹) |
|---|---|---|
| Yes | 4.19 | 694 |
| No | 3.60 | 403 |

**Cost bucket vs rating**

| Cost Bucket | Avg Rating | Count |
|---|---|---|
| Premium | 3.79 | 40 |
| Mid-range | 3.63 | 64 |
| Budget | 3.49 | 44 |

## Power BI Dashboard

An interactive 2-page dashboard built in Power BI, connected to the cleaned dataset.

**DAX Measures**
```
Avg Rating = ROUND(AVERAGE(zomato_clean[rate]), 2)
Total Restaurants = COUNTROWS(zomato_clean)
% Online Order = DIVIDE(CALCULATE(COUNTROWS(zomato_clean), zomato_clean[online_order]="Yes"), [Total Restaurants])
Avg Votes = ROUND(AVERAGE(zomato_clean[votes]), 0)
```

**Page 1 – Overview**
- KPI cards: Total Restaurants, Avg Rating, % Online Order
- Bar chart: Restaurant count by type
- Donut chart: Online order Yes/No split

![Dashboard Overview](powerbi/screenshots/page1_overview.png)

**Page 2 – Deep Dive**
- Clustered column chart: Avg Rating by online order and table booking
- Bar chart: Avg Votes by restaurant type
- Table: Top 10 most-voted restaurants
- Scatter plot: Cost vs. Rating, color-coded by restaurant type
- Slicers: restaurant type, online order, table booking (fully interactive cross-filtering)

![Deep Dive Dashboard](powerbi/screenshots/page2_deepdive.png)

## Tools & Libraries

- **Python** — Pandas, NumPy
- **Visualization (Python)** — Matplotlib, Seaborn
- **Database** — MySQL
- **BI Tool** — Power BI (DAX, slicers, interactive visuals)
- **Environment** — Jupyter Notebook, MySQL Workbench, Power BI Desktop

## Files

```
├── zomato_predict.ipynb          # Full analysis notebook (cleaning, EDA, visualizations)
├── Zomato-data-.csv              # Raw dataset
├── zomato_clean.csv              # Cleaned dataset (exported from notebook)
├── sql/
│   └── zomato.sql                # Table creation + analysis queries
├── powerbi/
│   ├── zomato_dashboard.pbix      # Power BI dashboard file
│   └── screenshots/
│       ├── page1_overview.png
│       └── page2_deepdive.png
└── README.md
```

## How to Run

1. Clone this repository
   ```bash
   git clone https://github.com/roshanpwar01-spec/zomato-restaurant-analysis.git
   ```
2. **Python EDA**
   ```bash
   pip install pandas numpy matplotlib seaborn
   ```
   Open `zomato_predict.ipynb` in Jupyter Notebook or JupyterLab and run all cells.
3. **SQL Analysis**
   Import `zomato_clean.csv` into a MySQL database and run `sql/zomato.sql` to recreate the table and queries.
4. **Power BI Dashboard**
   Open `powerbi/zomato_dashboard.pbix` in Power BI Desktop (or import `zomato_clean.csv` directly using Get Data → Text/CSV).

## Conclusion

This project demonstrates a full analytics pipeline — from raw data cleaning and exploratory analysis in Python, to structured querying in SQL, to interactive business intelligence in Power BI. Beyond surfacing patterns like pricing trends and rating drivers, it highlights actionable business takeaways: online ordering and table booking are strong differentiators of both customer engagement and perceived restaurant quality, while the most common restaurant type (Dining) has room to improve on ratings despite its market dominance.

## Author

**Roshan Panwar**
[LinkedIn](https://linkedin.com/in/roshanpanwar-195048388) | [GitHub](https://github.com/roshanpwar01-spec)
