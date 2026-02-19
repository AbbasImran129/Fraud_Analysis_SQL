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

