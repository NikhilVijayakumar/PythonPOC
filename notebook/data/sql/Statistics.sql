#Based on close_time
SELECT s.close_time, sum(case when  s.status = 'loss' then 1 else 0 end) as loss,
       sum(case when s.status = 'profit' then 1 else 0 end) as profit,
       round(sum(case when  s.status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when s.status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio,
	   round(sum(case when s.type = 'long' then s.close*s.number_of_shares -s.current*s.number_of_shares else s.current*s.number_of_shares -s.close*s.number_of_shares end),2) as turnover,
	   round(1.5*(select count(*) from Statistics t WHERE t.close_time = s.close_time),2) as tax,
	   round(sum(case when s.type = 'long' then s.close*s.number_of_shares -s.current*s.number_of_shares else s.current*s.number_of_shares -s.close*s.number_of_shares end)
	   - 1.5*(select count(*) from Statistics t WHERE t.close_time = s.close_time),2) as returns
FROM Statistics s GROUP by s.close_time ORDER by s.close_time


#Based on algorithm
SELECT algorithm,sum(case when  status = 'loss' then 1 else 0 end) as loss,
       sum(case when status = 'profit' then 1 else 0 end) as profit,
       round(sum(case when  status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio,
	   round(sum(case when type = 'long' then close*number_of_shares -current*number_of_shares else current*number_of_shares -close*number_of_shares end),2)turnover,
	   round(1.5*(select count(*) from Statistics),2) as tax,
	   round(sum(case when type = 'long' then close*number_of_shares -current*number_of_shares else current*number_of_shares -close*number_of_shares end)
	   - 1.5*(select count(*) from Statistics) ,2) as returns
FROM Statistics GROUP by algorithm ORDER by profit_ratio desc

#Based on symbol
SELECT s.symbol,s.type, sum(case when  s.status = 'loss' then 1 else 0 end) as loss,
       sum(case when s.status = 'profit' then 1 else 0 end) as profit,
       sum(case when s.status = 'open' then 1 else 0 end) as open,
       round(sum(case when  s.status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when s.status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio,
	   round(sum(case when s.type = 'long' then s.close*s.number_of_shares -s.current*s.number_of_shares else s.current*s.number_of_shares -s.close*s.number_of_shares end),2) as turnover,
	   round(1.5*(select count(*) from Statistics t WHERE t.symbol = s.symbol),2) as tax,
	   round(sum(case when s.type = 'long' then s.close*s.number_of_shares -s.current*s.number_of_shares else s.current*s.number_of_shares -s.close*s.number_of_shares end)
	   - 1.5*(select count(*) from Statistics t WHERE t.symbol = s.symbol),2) as returns
FROM Statistics s GROUP by s.symbol,s.type  ORDER by returns

#loss
SELECT s.close_time, sum(case when  s.status = 'loss' then 1 else 0 end) as loss,
       sum(case when s.status = 'profit' then 1 else 0 end) as profit,
       sum(case when s.status = 'open' then 1 else 0 end) as open,
       round(sum(case when  s.status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when s.status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio,
	   round(sum(case when s.type = 'long' then s.close*s.number_of_shares -s.current*s.number_of_shares else s.current*s.number_of_shares -s.close*s.number_of_shares end),2) as turnover,
	   round(1.5*(select count(*) from Statistics t WHERE t.close_time = s.close_time),2) as tax,
	   round(sum(case when s.type = 'long' then s.close*s.number_of_shares -s.current*s.number_of_shares else s.current*s.number_of_shares -s.close*s.number_of_shares end)
	   - 1.5*(select count(*) from Statistics t WHERE t.close_time = s.close_time),2) as returns
FROM Statistics s GROUP by s.close_time having returns < 0  ORDER by profit_ratio DESC


#day status
SELECT s.close_time, sum(case when  s.status = 'loss' then 1 else 0 end) as loss,
       sum(case when s.status = 'profit' then 1 else 0 end) as profit,
       round(sum(case when  s.status = 'loss' then 1.0 else 0.0 end)/count(*),2) as loss_ratio,
       round(sum(case when s.status = 'profit' then 1.0 else 0.0 end)/count(*),2)  as profit_ratio,
	   round(sum(case when s.type = 'long' then s.close*s.number_of_shares -s.current*s.number_of_shares else s.current*s.number_of_shares -s.close*s.number_of_shares end),2) as turnover,
	   round(1.5*(select count(*) from Statistics t WHERE t.close_time = s.close_time),2) as tax,
	   round(sum(case when s.type = 'long' then s.close*s.number_of_shares -s.current*s.number_of_shares else s.current*s.number_of_shares -s.close*s.number_of_shares end)
	   - 1.5*(select count(*) from Statistics t WHERE t.close_time = s.close_time),2) as returns
FROM Statistics s GROUP by s.close_time having s.close_time = '2021-04-30-18:58:55'  ORDER by s.close_time



