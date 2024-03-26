== Задание 2

Написать функцию select_value_by_house_and_month. Она получает номер дома и месяц
и возвращает все лицевые в этом доме , для лицевых выводятся все счетчики с сумарным расходом за месяц ( суммирую все показания тарифов)

==Решение

CREATE OR REPLACE FUNCTION stack.select_value_by_house_and_month(house_number int, input_month text)
RETURNS TABLE(acc int, name text, value int8) AS $$
BEGIN
RETURN QUERY
SELECT accounts.number AS acc, counters.name AS name, SUM(meter_pok.value) AS value
FROM stack.accounts
JOIN stack.meter_pok ON counters.row_id = meter_pok.counter_id
JOIN stack.counters ON accounts.row_id = counters.acc_id
WHERE meter_pok.tarif = house_number AND meter_pok.month = TO_DATE(input_month, 'YYYYMMDD')
GROUP BY  accounts.number, meter_pok.tarif, counters.name
order by accounts.number;
END; $$
LANGUAGE plpgsql;