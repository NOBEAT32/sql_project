# 🛒 Retail Sales Data Analysis — SQL Project

## 📌 Project Overview

This project performs an end-to-end exploratory data analysis (EDA) on a retail sales transactions dataset using **SQL Server (T-SQL)**. The analysis covers data cleaning, business performance metrics, customer segmentation, time trends, and pricing insights — all framed around real business questions.

---

## 📂 Dataset

**Table:** `dbo.first`

| Column | Description |
|---|---|
| `transactions_id` | Unique transaction identifier |
| `sale_date` | Date of the sale |
| `sale_time` | Time of the sale |
| `customer_id` | Unique customer identifier |
| `gender` | Customer gender (Male / Female) |
| `age` | Customer age |
| `category` | Product category (Beauty / Clothing / Electronics) |
| `quantiy` | Quantity of items sold |
| `price_per_unit` | Price per unit of the product |
| `cogs` | Cost of Goods Sold per unit |
| `total_sale` | Total sale value for the transaction |

---

## 🧹 Data Cleaning

Before analysis, the dataset was checked for completeness and cleaned.

**Steps performed:**
1. Viewed all records with `SELECT *`
2. Identified NULL values across all columns
3. Deleted all rows containing any NULL values

```sql
DELETE FROM dbo.first
WHERE transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL
   OR customer_id IS NULL OR gender IS NULL OR age IS NULL
   OR category IS NULL OR quantiy IS NULL OR price_per_unit IS NULL
   OR cogs IS NULL OR total_sale IS NULL;
```

---

## 📊 Analysis Tasks

### ✅ Task 1 — Sales Performance Overview

**Goal:** Summarize total revenue, units sold, COGS, profit, and gross profit margin.

**Key Metrics Calculated:**
- `Total Revenue` = SUM(total_sale)
- `Total Units Sold` = SUM(quantiy)
- `Total COGS` = SUM(cogs × quantiy)
- `Total Profit` = Total Revenue − Total COGS
- `Gross Profit Margin (%)` = (Profit / Revenue) × 100

---

### Task 2 — Category Analysis

**Goal:** Identify which product category drives the most revenue and profit margin.

**Categories Analyzed:** Beauty | Clothing | Electronics

**Findings:**
- Revenue and profit margin were computed per category
- **Beauty** showed the highest profit margin
- **Recommendation:** Increase investment in Beauty products

---

### Task 3 — Customer Demographics

**Goal:** Break down sales by gender and age group to identify valuable and under-served segments.

**Age Groups Used:**

| Group | Range |
|---|---|
| Young Adults | 18 – 25 |
| Adults | 26 – 35 |
| Mid Age | 36 – 50 |
| Senior | 50+ |

**Findings:**
- Male customers showed a higher overall profit margin
- Males were found to purchase across all categories including Beauty
- **Highest profit margin** observed in the **18–25 age bracket**
- **Under-served segments:** Female customers aged 18–36 and 57–64

---

###  Task 4 — Time Trends

**Goal:** Analyze year-over-year revenue growth and identify monthly sales patterns.

**Date range explored:** January 2022 – December 2023

**Findings:**
- Clear **revenue and profit margin growth** from 2022 to 2023
- **December** recorded the highest sales frequency (peak season)
- **October** saw the lowest sales period (dip season)

---

### Task 5 — High-Value Transactions

**Goal:** Identify the top 5 transactions by sale value and find common patterns.

```sql
SELECT TOP 5 transactions_id, gender, category, total_sale, age
FROM dbo.first
ORDER BY total_sale DESC;
```

**Findings:**
- Top 5 transactions are dominated by the **Electronics** category
- High-value purchases are concentrated in **durable goods**
- Mid-to-older age groups are more likely to make large purchases

---

###  Task 6 — Pricing & Quantity Insight

**Goal:** Understand if higher-priced items sell in lower quantities, and find the pricing sweet spot.

**Price Buckets Defined:**

| Bucket | Price Range |
|---|---|
| Low Price | < ₹50 |
| Medium Price | ₹50 – ₹200 |
| High Price | > ₹200 |

**Findings:**
- **High-priced items** generate better returns despite lower quantity
- There is a clear inverse relationship between price and quantity sold
- **Recommendation:** Focus premium product lines for revenue maximization

---

##  Key Business Insights Summary

| # | Insight |
|---|---|
| 1 | Gross profit margin is healthy with consistent growth YoY |
| 2 | Beauty products have the best profit margin — worth more investment |
| 3 | Male customers (18–25) are the most profitable segment |
| 4 | Female customers aged 18–36 and 57–64 are under-served |
| 5 | December is peak season; October needs promotional push |
| 6 | Electronics drives the highest single-transaction value |
| 7 | High-price items yield better returns per transaction |

---

##  Tools Used

- **Database:** Microsoft SQL Server
- **Language:** T-SQL (Transact-SQL)
- **Techniques:** Aggregations, CASE statements, GROUP BY, date functions, profit margin calculations

---

---

*Project by: [Your Name] | Data Analysis | SQL Server*
