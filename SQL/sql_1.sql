== Задание 1.

Написать функцию stack.select_count_pok_by_service. Она получает номера услуг строкой и дату
и возвращает количество показаний по услуге для каждого лицевого

==Решение

CREATE OR REPLACE FUNCTION stack.select_count_pok_by_service(service_number text, input_date text)
RETURNS TABLE(acc int, serv int, count int8) AS $$
BEGIN
RETURN QUERY
SELECT accounts.number AS acc, counters.service AS serv, COUNT(meter_pok.value) AS count
FROM stack.meter_pok
JOIN stack.accounts ON meter_pok.acc_id = accounts.row_id
JOIN stack.counters ON meter_pok.counter_id = counters.row_id
WHERE counters.service = CAST(service_number AS integer) AND meter_pok.month = TO_DATE(input_date, 'YYYYMMDD')
GROUP BY accounts.number, counters.service;

END; $$
LANGUAGE plpgsql;
