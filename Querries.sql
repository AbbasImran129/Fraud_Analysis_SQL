--1
create table transactions
(

step int,
type varchar(50),
amount float,
nameOrig varchar(100),
oldbalanceOrig float,
newBalanceOrig float,
nameDest varchar(100),
oldbalanceDest float,
newbalanceDest float,
isFraud int,
isFlaggedFraud int

)


--2 What is the overall fraud incidence rate across transactions?
SELECT 
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS total_fraud_cases,
    ROUND(SUM(isFraud)*100.0/COUNT(*),4) AS fraud_rate_percentage
FROM transactions;









--3 Are fraudulent transfers forming transaction chains across multiple accounts, 
--indicating potential money mule networks or layered laundering activity?
with recursive rec as
(
select step , nameorig as initial_acc , nameDest as next_acc , amount , newbalancedest
from transactions
where isfraud=1 and type = 'TRANSFER'

union all
select rc.step , rc.initial_acc , t.namedest , t.amount , rc.newbalancedest
from transactions as t 
join rec as rc
on rc.next_acc=t.nameorig and rc.step<t.step 
where t.isfraud=1 and t.type = 'TRANSFER'
)
select * from rec
order by initial_acc 



--4 Are there inconsistencies in post-transaction balance reconciliation?
select 
		amount , oldbalancedest , newbalancedest
		from transactions 
where oldbalancedest+amount <> newbalancedest
	












--5 Do fraudulent transactions typically drain accounts to zero?
WITH account_stats AS (
    SELECT 
        COUNT(DISTINCT CASE  WHEN isFraud = 1 AND newbalanceOrig = 0 
            THEN nameOrig END) AS drained_fraud_accounts,
        COUNT(DISTINCT CASE  WHEN isFraud = 1 
            THEN nameOrig END) AS total_fraud_accounts,
        COUNT(DISTINCT nameOrig) AS total_accounts
    FROM transactions
)
SELECT 
    drained_fraud_accounts,
    total_fraud_accounts,
    total_accounts,

    ROUND(
        drained_fraud_accounts * 100.0 
        / total_fraud_accounts
    ,2) AS drained_as_percent_of_fraud_accounts
FROM account_stats;






--6 Which transaction types contribute most to fraud exposure?
select type , count(*) from transactions
where isfraud=1
group by type


--7  are Frauds are increasing or concentrated at specific hour of the day ? 
SELECT 
    MOD(step, 24) AS hour_of_day,
    COUNT(*) AS number_of_fraud
FROM transactions
WHERE isfraud = 1
GROUP BY MOD(step, 24)
ORDER BY 2 DESC;







--8 Which transaction channels drive the highest financial loss?
SELECT 
    type,
    COUNT(*) AS total_txn,
    SUM(isFraud) AS fraud_cases,
    ROUND(SUM(isFraud)*100.0/COUNT(*),2) AS fraud_rate
FROM transactions
GROUP BY type
ORDER BY fraud_rate DESC;



--9 total fraud amount ?
SELECT ROUND(SUM(amount),2) AS total_fraud_loss
FROM transactions
WHERE isFraud = 1;








--10 Is fraud concentrated in high-value transactions?
SELECT 
CASE 
    WHEN amount < 10000 THEN 'Low'
    WHEN amount BETWEEN 10000 AND 100000 THEN 'Medium'
    ELSE 'High'
END AS value_segment,
COUNT(*) AS total_txn,
SUM(isFraud) AS fraud_cases,
ROUND(SUM(isFraud)*100.0/COUNT(*),2) AS fraud_rate
FROM transactions
GROUP BY value_segment
ORDER BY fraud_rate DESC;




--11 Do fraudulent transactions typically drain accounts to zero?
SELECT 
    COUNT(*) AS drained_fraud_cases
FROM transactions
WHERE isFraud = 1
AND newbalanceOrig = 0;





--13 Are certain beneficiary accounts repeatedly linked to fraud?
SELECT 
    nameDest,
    COUNT(*) AS fraud_occurrences
FROM transactions
WHERE isFraud = 1
GROUP BY nameDest
HAVING COUNT(*) > 1
ORDER BY fraud_occurrences DESC;






--14 How effective is the system-generated fraud flag?

with cte as (

SELECT SUM(CASE WHEN isFraud=1 AND isFlaggedFraud=1 THEN 1 ELSE 0 END) AS true_positive,
       SUM(CASE WHEN isFraud=1 AND isFlaggedFraud=0 THEN 1 ELSE 0 END) AS false_negative
       FROM transactions
)
select true_positive , false_negative , 
	(true_positive*100.0)/(false_negative+true_positive) as fraud_detection_rate 
from cte 


--15  Is fraud loss highly concentrated in a small number of high-value transactions?
WITH fraud_ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY amount DESC) AS rn,
           COUNT(*) OVER () AS total_fraud_count,
           SUM(amount) OVER () AS total_fraud_loss
    FROM transactions
    WHERE isFraud = 1
)
SELECT 
    round(SUM(amount)::numeric,2) AS top_5_percent_loss,
    MAX(total_fraud_loss) AS total_fraud_loss,
    ROUND(
        (SUM(amount)*100.0/MAX(total_fraud_loss))::numeric
    , 2) AS loss_concentration_percentage
FROM fraud_ranked
WHERE rn <= total_fraud_count * 0.05;
--------------

