class WorkingReceipts:
    month = ['январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь',
             'декабрь']
    services = ['газоснабжение', 'ГВС', 'домофон', 'квартплата', 'ТБО', 'теплоснабжение', 'ХВС', 'капремонт',
                'электроснабжение']

    def get_inform(self):
        file = []
        with open('checks.txt', 'r') as f:
            for i in f:
                file.append(i)
        file[-1] += '\n'
        return file

    def add_new_file(self):
        with open('receipts_by_folders.txt', 'a') as file:
            file.truncate(0)
            for i in self.month:
                for n in self.get_inform():
                    if i in n:
                        file.write(f'/{i}/{n}')
        return f'Файл создан'

    def get_one_month(self, month):
        all = []
        for f in self.get_inform():
            if month in f:
                all.append(f)
        return all

    def get_not_service(self, all_):
        not_serv = []
        for s in self.services:
            if s not in ''.join(all_):
                not_serv.append(s)

        return not_serv

    def lack_of_service(self):
        for m in self.month:
            all_ = self.get_one_month(m)
            not_serv = self.get_not_service(all_)
            if len(not_serv) == 0:
                continue
            else:
                print(f'\n{m}:')
                for i in not_serv:
                    print(i)



