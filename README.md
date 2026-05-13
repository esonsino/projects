# Intermediate SQL - Sales Analysis

## Overview

## Business Questions
**Customer Segmentation:** Who are our most valuable customers? 


## Analysis Approach

- Categorize customers based on their total lifetime value (LTV)
- Assign customers to High, Mid and Low value groups using CASE WHEN

🖥️ Query: [1_customer_segmentation](/1_customer_segmentation.sql)

**📈 Visualization:**

![Customer Segmentation](/images/1_customer_segmentation.png)

📊 **Key Findings:**
- High-value segment (25% of customers) drives 66% of revenue ($135.4M)
12,372 customers (25% of 49,487 total customers)
206.4M total revenue = 66%
$10,946 is the average LTV for the high-value customer
- Mid-value segment (50% of customers) generates 32% of revenue ($66.6M)
24,743 customers (50% of 49,487 total customers)
206.4M total revenue = 32%
$2,700 is the average LTV for the mid-value customer
- Low-value segment (25% of customers) accounts for 2% of revenue ($4.3M)
12,372 customers (25% of 49,487 total customers)
206.4M total revenue = 2%
$350 is the average LTV for the low-value customer

💡 **Business Insights**
- High-Value (66% revenue):
    * Offer premium membership program to 12,372 VIP customers
    * Provide early access to new products and dedicated support
    * Focus on retention as losing one customer impacts revenue significantly
- Mid-Value (32% revenue):
    * Create upgrade paths for 24,743 customers through personalized promotions
    * Target with "next best product" recommendations based on high-value patterns
- Low-Value (2% revenue):
    * Design re-engagement campaigns for 12,372 customers to increase purchase frequency
    * Test price-sensitive promotions to encourage more frequent purchases
    * Focus on converting $4.3M segment to mid-value through targeted offers

## Technical Details
- **Database:** PostgreSQL
- **Analysis Tools:** PostgreSQL
- **Visualization:** ChatGPT
