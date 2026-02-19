# 🏦 Banking Fraud Risk Analytics Using SQL

---

## Project Title
Banking Fraud Risk Analytics and Financial Crime Pattern Detection Using SQL

---

## Summary
SQL-based fraud risk analysis project identifying financial exposure, behavioral fraud signatures, detection gaps, and transaction network patterns in banking data.

---

## Overview
This project performs end-to-end fraud risk analytics on a financial transaction dataset using SQL.  
The goal is to simulate a banking risk analyst’s workflow by quantifying fraud exposure, identifying high-risk transaction channels, analyzing financial loss severity, evaluating detection system effectiveness, and detecting potential network-based financial crime patterns.

The project focuses on business-driven insights rather than only technical querying.

---

## Problem Statement
Financial institutions process high volumes of digital transactions daily, exposing them to fraud risk.  

Key challenges include:
- Identifying high-risk transaction channels  
- Measuring financial fraud exposure  
- Detecting behavioral fraud patterns (e.g., account drain events)  
- Evaluating monitoring control effectiveness  
- Tracing potential mule or layered transaction networks  

This project addresses these challenges using structured SQL-based risk analysis.

---

## Dataset
The dataset contains simulated financial transactions with the following key fields:

- `step` – Time in hours (simulation over 30 days)
- `type` – Transaction type (TRANSFER, CASH_OUT, DEBIT, PAYMENT, CASH_IN)
- `amount` – Transaction amount
- `nameOrig` – Origin account
- `oldbalanceOrig` – Sender balance before transaction
- `newbalanceOrig` – Sender balance after transaction
- `nameDest` – Destination account
- `oldbalanceDest` – Receiver balance before transaction
- `newbalanceDest` – Receiver balance after transaction
- `isFraud` – Fraud label (1 = fraud, 0 = non-fraud)
- `isFlaggedFraud` – System-generated fraud flag

---

## Tools and Technologies
- SQL (PostgreSQL-compatible syntax)
- Window Functions (ROW_NUMBER, SUM OVER, COUNT OVER)
- Recursive CTE
- Conditional Aggregation
- Risk Segmentation using CASE statements

---

## Methods
The following analytical methods were applied:

1. Fraud incidence rate calculation  
2. Channel-level fraud risk segmentation  
3. Financial loss quantification  
4. High-value transaction risk analysis  
5. Account-drain behavioral detection  
6. Time-based fraud distribution analysis  
7. Fraud detection system performance evaluation (True Positive / False Negative)  
8. Loss concentration analysis (Top 5% fraud exposure)  
9. Repeated beneficiary (mule account) detection  
10. Recursive transaction chain tracing to identify network-based fraud patterns  

---

## Key Insights
- 100% of fraud cases (8,213 transactions) were concentrated in outbound channels (TRANSFER & CASH_OUT), confirming structural exposure in fund-outflow mechanisms.
- Over 90% of fraud-linked accounts were fully drained (newbalanceOrig = 0), indicating account-depletion as the dominant fraud behavioral pattern.
- Top 5% highest-value fraud transactions contributed 32.95% of total fraud loss, demonstrating moderate loss concentration and need for layered detection controls.
- The detection system identified only 16 out of 8,213 fraud cases (~0.19% recall), revealing significant monitoring gaps in rule-based flagging.
- Recursive transfer analysis uncovered multi-step fraud chains across accounts, indicating network-based fraud activity rather than isolated incidents.
---

## Results & Conclusion

The analysis demonstrates that fraud risk in digital banking environments is:

- Concentrated in specific outbound transaction channels  
- Characterized by account-drain behavioral signatures  
- Moderately distributed across transaction value ranges  
- Under-detected by basic rule-based flagging systems  
- Potentially network-driven through multi-step transfer chains  

The project highlights the importance of moving beyond static threshold rules toward behavioral, risk-based, and network-level fraud monitoring frameworks.

This work aligns closely with real-world responsibilities in Fraud Risk, Operational Risk, AML, and Financial Crime Analytics roles.

---
## Author 
Abbas Imran
Master’s in Economics 
[linkedin](https://www.linkedin.com/in/abbas-imran-69910a22b/)
[Portfolio](https://www.datascienceportfol.io/abbasimranabidi009)
