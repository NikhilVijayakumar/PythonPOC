#Based on close_time
SELECT close_time, sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio,
	   round(sum(case when type = 'long' then close*number_of_shares -current*number_of_shares else current*number_of_shares -close*number_of_shares end),2) as returns
FROM Statistics GROUP by close_time ORDER by close_time


#Based on algorithm
SELECT algorithm,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio,
	   round(sum(case when type = 'long' then close*number_of_shares -current*number_of_shares else current*number_of_shares -close*number_of_shares end),2) as returns
FROM Statistics GROUP by algorithm ORDER by profit_ratio desc

#Based on symbol
SELECT symbol,type,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio,
	   round(sum(close*number_of_shares -current*number_of_shares ),2)  as returns
FROM Statistics GROUP by symbol,type ORDER by profit_ratio desc

#loss
SELECT close_time, sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio,
	   round(sum(close*number_of_shares -current*number_of_shares ),2)  as returns
FROM Statistics GROUP by close_time having returns < 0  ORDER by returns


#day status
SELECT close_time,current,close,number_of_shares,symbol,type,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       sum(case when status = 'open' then 1 else 0 end) as open,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio,
	   round(sum(close*number_of_shares -current*number_of_shares ),2)  as returns
FROM Statistics GROUP by symbol,close_time having close_time = '2021-04-30-18:58:55' ORDER by returns
