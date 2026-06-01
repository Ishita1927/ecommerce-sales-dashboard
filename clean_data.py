# ================================================
# FILE: clean_data.py
# Run this in VS Code terminal: python clean_data.py
# ================================================

import pandas as pd

# STEP 1: Load raw file
# Make sure ecommerce_raw_data.csv is in the SAME folder as this script
df = pd.read_csv("ecommerce_raw_data.csv")
print("✅ File loaded:", len(df), "rows")

# STEP 2: Check missing values
print("\n🔍 Missing values:")
print(df.isnull().sum())

# STEP 3: Fix date column + extract month/quarter/year
df["order_date"]  = pd.to_datetime(df["order_date"])
df["month"]       = df["order_date"].dt.month
df["month_name"]  = df["order_date"].dt.strftime("%B")
df["quarter"]     = df["order_date"].dt.quarter
df["year"]        = df["order_date"].dt.year
print("\n✅ Date columns created")

# STEP 4: Recalculate revenue to make sure it's correct
df["revenue"] = df["price"] * df["quantity"]
print("✅ Revenue column verified")

# STEP 5: Clean status column
df["status"] = df["status"].str.strip().str.title()
print("✅ Status values:", df["status"].unique())

# STEP 6: Add delivered flag
df["is_delivered"] = df["status"].apply(lambda x: "Yes" if x == "Delivered" else "No")
print("✅ is_delivered column added")

# STEP 7: Summary
delivered = df[df["status"] == "Delivered"]
print("\n📊 Summary:")
print(f"   Total orders     : {len(df)}")
print(f"   Delivered orders : {len(delivered)}")
print(f"   Total revenue    : ₹{delivered['revenue'].sum():,.2f}")
print(f"   Date range       : {df['order_date'].min().date()} to {df['order_date'].max().date()}")

# STEP 8: Save cleaned file
df.to_csv("ecommerce_cleaned.csv", index=False)
print("\n✅ Saved: ecommerce_cleaned.csv")
print("   → Now import this file into Power BI")
