# Crypto Risk and Return, 2021 to 2026

![Dashboard page 1](Dashboard%20page%201.PNG)

I work in digital marketing, where I spent years building performance reports. That is how I got interested in analysis. This is my second portfolio project, and it is about a question I find interesting: **does taking more risk in crypto actually pay more?**

I looked at seven coins (Bitcoin, BNB, Cardano, Dogecoin, Ethereum, Solana, XRP) using daily prices from Yahoo Finance, January 2021 to October 2026. I did the work in Python, SQL, Excel and Power BI, using each tool for the part it suits.

## What I found

- **More volatility did not reliably mean more return.** Dogecoin was the most volatile coin (about 193% annual volatility) but ranked third on return (about 58% CAGR), behind Solana and BNB.
- **Solana was the exception.** It had the highest CAGR (about 101%) with about 108% volatility. Cardano sat at the other end, with about 97% volatility and only about 4% CAGR.
- **Bitcoin was the calmest coin** (about 57% volatility, about 20% CAGR).
- **Most coins moved together.** Bitcoin and Ethereum were the closest pair (0.81 correlation on daily returns). Dogecoin moved most on its own, with correlations of 0.25 to 0.40 against the others.
- **Correlations changed over time.** The 90-day rolling correlation with Bitcoin was more spread out in 2021 and 2022, and mostly sat between 0.6 and 0.9 in 2025 and 2026.

![Dashboard page 2](Dashboard%20page%202.PNG)![Dashboard page 2](Dashboard%20page%202.PNG)

## How I built it

1. **Python (Google Colab):** downloaded daily prices from Yahoo Finance, calculated returns, 30-day rolling volatility, the correlation between coins and the 90-day rolling correlation with Bitcoin. Exported the results as CSV files.
2. **SQL (DB Browser for SQLite):** loaded the long-format price table and wrote queries for the daily metrics and monthly returns tables.
3. **Excel:** built a summary table with annual volatility, CAGR and a Sharpe-style ratio for each coin, and made a quick risk-versus-reward scatter chart to check the numbers before building the dashboard.
4. **Power BI:** loaded seven tables, linked them through a `coins` table, and built a two-page dashboard.
   - Page 1: growth of $100, drawdown from previous peak, 30-day volatility, and risk versus reward.
   - Page 2: rolling correlation with Bitcoin, a correlation heatmap, and average return by calendar month.

## Choices I made

- Prices are **daily** and returns are calculated from **[Close / Adj Close: fill in]** prices, in **[USD: fill in]**.
- CAGR and volatility are annualized. The Sharpe-style ratio uses **[risk-free rate: fill in, or "no risk-free rate"]**.
- The 30-day volatility chart caps its axis at 3, because Dogecoin's early-2021 spike would otherwise squash every other line.
- Every coin keeps the same color on every chart, so one legend explains the page.

## Limits

- This is about the past. **Past returns do not predict future ones**, and this is not investment advice.
- Seven coins is a small sample, and I picked large, well-known ones, so the results leave out coins that failed or were delisted.
- Calendar-month averages cover only about five years, so single events dominate them (for example Dogecoin's 84% average for April is mostly the 2021 rally).
- Correlation shows that coins move together, not why.
- The full-period correlation for Dogecoin (0.40 with Bitcoin) is lower than its recent 90-day readings, so a single number hides how the relationship changed.

## Files

| File | What it is |
|---|---|
| `screenshots/` | Dashboard page 1 and page 2 |
| `crypto_dashboard.pbix` | Power BI dashboard |
| `crypto_analysis.xlsx` | Excel summary and scatter chart |
| `[notebook name].ipynb` | Python notebook (Google Colab) |
| `queries.sql` | SQL queries from DB Browser |
| `data/` | Exported CSVs: `coins`, `daily_metrics`, `monthly_returns`, `rolling_vol`, `rolling_corr_btc`, `correlation`, `summary_final` |

## What I would do next

- Add more coins and a longer history.
- Test whether the correlation pattern holds during market falls, not just overall.

*Built by Darakhshan Roohi. Data: Yahoo Finance.*
