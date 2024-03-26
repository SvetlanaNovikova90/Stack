from utils import WorkingReceipts

if __name__ == '__main__':
    vv = WorkingReceipts()
    print(vv.add_new_file())
    print("не оплачены:")
    vv.lack_of_service()