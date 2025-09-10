# Digital-Wallet Dashboard
This project shows how I analyzed and visualized a **Digital Wallet dataset** from Kaggle.

## Tools used
- **Excel** : Data Cleaning
- **SQL (MySQL)** : Deep Analysis
- **Power BI** : Visuals & Dashboard

## Dataset
- Source: [Kaggle Dataset Link](https://www.kaggle.com/datasets/harunrai/digital-wallet-transactions)

## Process
1. **Cleaned data in Excel**
   - Created a duplicate file before cleaning to preserve the original dataset
   - Removed duplicates in the dataset
   - Filtered column headers
   - Used TEXT to Column function in the Data tab to seperate the transaction date from time
   - Edited all columns into proper format
   - Deleted unwanted columns
   - Inserted a new column 'Month' and used the TEXT function to extract just the month from the transaction date
2. **Analyzed in SQL**
   **Calculated**:
   - Total Revenue and Average Transaction
   - Active Distinct Users and Monthly Active Users
   - Monthly Trend
   - New VS Returning Users
   - Retention / Churn Percentage
   - Total Transactions and Revenue gotten from Transaction Status
   - Payment Method Analysis
   - Top 10 Product Category
   - Top 10 Merchant Performance Analysis
   - Comparison between Device Type
   - Location Analysis
   - Top 20 Loyal Customers
   - Identified weak poimts in the system
3. **Visualized in Power BI**
   - KPIs (Total Transactions, Total Revenue, Average Revenue, No of active users)
   - Line Chart: monthly trend, monthly active users
   - Bar Chart: revenue by device, transaction by device
   - Pie Chart: location revenue
   - Donut Chart: payment method revenue
   - Treemap: Top 10 Merchant
4. **Dashboard Design**
   - Made a custom background in PowerPoint
   - Imported into Power BI for a professional look

## How to view
- See screenshots [Dashboard Screenshot](https://github.com/user-attachments/assets/2f7bd254-6ee3-4b11-a8d4-b03d61662d14)
- View Dashboard [Power BI Dashboard](https://app.powerbi.com/groups/me/reports/a37da585-8201-46d0-a44f-d552d9968c85/884b5befa07c4ec3945c?experience=power-bi)

## 💡 Key Insights
1. **High Dependency on Mobile Devices**
   - Majority of transactions happen via **mobile devices**
   - ✅ *Recommendation*: Focus on optimizing mobile app experience
2. **Revenue Concentrated in Few Categories**
   - Top 2-3 products dominate revenue
   - ✅ *Recommendation*: Promote under-utilized categories
3. **Merchant Deppendency Risk**
   - Few merchants generate most of the revenue
   - ✅ *Recommendation*: Onboard more merchants to diversify sources
4. **Payment Method Preferences**
   - UPI and bank transfer dominates other payment method
   - ✅ *Recommendation*: Incentivize wallet balance top-ups (cashbacks, discounts)
5. **Monthly Trend**
   - December noticeable generate more revenue
   - ✅ *Recommendation*: Replicate successful seasonal campaigns
6. **Geographical Opportunity**
   - Revenue is concentrated mostly in Urban areas
   - ✅ *Recommendation*: Expand campaigns, good discounts and loyalty points to rural areas
7. **Active Users**
   - Users are mostly active in May
   - ✅ *Recommandation*: Introduce more discounts or referral offers in months with least active users
     
## Author
My name is Victory Oki a data enthusist who is curious about technology and consumer behaviors innovation in fintech
