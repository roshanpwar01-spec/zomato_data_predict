# Zomato Restaurant Data Analysis

Exploratory data analysis of restaurant listings on Zomato, uncovering patterns in pricing, customer ratings, online ordering, and dining preferences using Python.

## Overview

This project analyzes a dataset of 148 restaurants to understand what drives customer ratings and engagement — specifically how factors like online ordering, table booking, restaurant type, and pricing relate to customer votes and satisfaction.

## Dataset

| Detail | Value |
|---|---|
| Records | 148 restaurants |
| Features | 7 (name, online_order, book_table, rate, votes, approx_cost for two, listed_in/type) |
| Cost range | ₹100 – ₹950 (for two people) |
| Restaurant types | Dining (110), Cafes (23), Other (8), Buffet (7) |

## Methodology

1. **Data Cleaning** — Converted the `rate` column (e.g. `4.1/5`) into a clean numeric float for analysis; checked and confirmed no missing values across the dataset.
2. **Exploratory Data Analysis** — Used Pandas for grouping/aggregation and Matplotlib/Seaborn for visualization.
3. **Visualization** — Built count plots, histograms, box plots, and a heatmap to surface relationships between variables.

## Key Insights

- **Dining dominates the market** — 110 of 148 restaurants (74%) are listed as "Dining," far ahead of Cafes, Buffets, and other categories.
- **Online ordering is underutilized** — Only 58 of 148 restaurants (39%) offer online ordering, while the majority (90) do not.
- **Table booking is rare** — Just 8 of 148 restaurants (5%) offer table booking, suggesting it's a differentiator rather than a standard feature.
- **Rating distribution** — Most restaurants cluster in the 3.5–4.2 rating range, visualized via histogram.
- **Online order vs. rating** — A box plot comparison shows a relationship between offering online ordering and customer rating, suggesting online ordering availability may correlate with higher-rated restaurants.
- **Votes by restaurant type** — Aggregated vote counts by category highlight which restaurant types generate the most customer engagement.

## Tools & Libraries

- **Python** — Pandas, NumPy
- **Visualization** — Matplotlib, Seaborn
- **Environment** — Jupyter Notebook

## Files

```
├── zomato_predict.ipynb     # Full analysis notebook (cleaning, EDA, visualizations)
├── Zomato-data-.csv         # Raw dataset
└── README.md
```

## How to Run

1. Clone this repository
   ```bash
   git clone https://github.com/<your-username>/zomato-restaurant-analysis.git
   ```
2. Install dependencies
   ```bash
   pip install pandas numpy matplotlib seaborn
   ```
3. Open `zomato_predict.ipynb` in Jupyter Notebook or JupyterLab and run all cells

## Conclusion

This project demonstrates how raw restaurant data can be cleaned, explored, and visualized to surface actionable business insights — including pricing patterns, service-option trends, and the link between restaurant features and customer ratings. It reflects practical, end-to-end EDA skills in Python, from data cleaning through to interpretable visual storytelling.

## Author

**Roshan Panwar**
[LinkedIn](https://linkedin.com/in/roshanpanwar-195048388) | [GitHub](https://github.com/roshanpwar01-spec)
