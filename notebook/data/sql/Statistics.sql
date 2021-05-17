#Based on algorithm,type
SELECT algorithm,type,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio
FROM Statistics GROUP by algorithm,type ORDER by profit_ratio desc


#Based on algorithm
SELECT algorithm,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio
FROM Statistics GROUP by algorithm ORDER by profit_ratio desc

#Based on symbol
SELECT symbol,type,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio
FROM Statistics GROUP by symbol,type ORDER by profit_ratio desc


#loss > 0.6 short on symbol
SELECT symbol,type,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio
FROM Statistics GROUP by symbol,type HAVING loss_ratio>0.6 AND type = 'short' ORDER by loss_ratio desc


#loss > 0.6 long on symbol
SELECT symbol,type,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio
FROM Statistics GROUP by symbol,type HAVING loss_ratio>0.6 AND type = 'long' ORDER by loss_ratio desc




#loss > 0.6 symbol
SELECT symbol,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio
FROM Statistics GROUP by symbol HAVING loss_ratio>0.6  ORDER by loss_ratio desc



#profit_ratio > 0.3  symbol
SELECT symbol,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio
FROM Statistics GROUP by symbol HAVING profit_ratio> 0.3  ORDER by profit_ratio desc



#Common symbol, having > 0.6 loss on both long and short 
SELECT symbol FROM Statistics WHERE  symbol in 
(SELECT  q.symbol FROM (SELECT symbol,type,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio
FROM Statistics GROUP by symbol,type HAVING loss_ratio>0.6 AND type = 'short' ORDER by loss_ratio desc) q) 
AND symbol in
(SELECT  q.symbol FROM (SELECT symbol,type,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio
FROM Statistics GROUP by symbol,type HAVING loss_ratio>0.6 AND type = 'long' ORDER by loss_ratio desc) q)
GROUP by symbol