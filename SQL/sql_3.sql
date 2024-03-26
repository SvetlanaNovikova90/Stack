== Задание 3
Написать функцию stack.select_last_pok_by_acc. Она получает номер лицевого
и возвращает дату,тариф,объем последнего показания по каждой услуге

==Решение

CREATE OR REPLACE FUNCTION stack.select_last_pok_by_acc(account_id int)
RETURNS TABLE(acc int, serv int, date date, tarif int, value int) as $$
BEGIN
RETURN QUERY
WITH lat_rec AS (
    SELECT counter_id, meter_pok.tarif, MAX(meter_pok.date) as max_date
    FROM stack.meter_pok
    GROUP BY counter_id, meter_pok.tarif
),
serv AS (
    SELECT counters.service, meter_pok.counter_id
    FROM stack.meter_pok
    JOIN stack.counters ON meter_pok.counter_id = counters.row_id
)

SELECT accounts.number, serv.service, meter_pok.date, meter_pok.tarif, meter_pok.value
FROM stack.meter_pok
JOIN stack.accounts ON meter_pok.acc_id = accounts.row_id
JOIN serv ON meter_pok.counter_id = serv.counter_id
JOIN lat_rec ON meter_pok.counter_id = lat_rec.counter_id
AND meter_pok.date = lat_rec.max_date
AND meter_pok.tarif = lat_rec.tarif
WHERE accounts.number = account_id
GROUP BY accounts.number, serv.service, meter_pok.date, meter_pok.tarif, meter_pok.value;

END; $$
LANGUAGE plpgsql;