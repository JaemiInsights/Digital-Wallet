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
- Open the `powerbi/dashboard.pbix` file in Power BI Desktop
- Or see screenshots in [Digital Wallet](images/digital-wallet-dashboard.png)
<img width="799" height="540" alt="Screenshot DW" src="https://github.com/user-attachments/assets/e44bba5a-aa9b-49d8-a726-4d9838a498c5" />

## Author
My name is Victory Oki a data enthusist who is curious about technology and consumer behaviors innovation in fintech
