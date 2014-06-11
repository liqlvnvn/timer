import sys
import subprocess
from time import sleep
from datetime import datetime, date, time, timedelta

def start_case():
    while True:
        subprocess.call("reset")
        print('1. Start 45 minutes circle')
        print('2. Start unlimited')
        print('3. Status of unlimited timer')
        print('4. Stop unlimited timer')
        print('q. Quit')
        print(' ')
        answer = input('1/2/q?')
        print(' ')

        make_menu_action(answer)

def make_menu_action(answer):
    if answer == '1':
        start_45minute()
    elif answer == '2':
        start_unlimited_period()
    elif answer == '3':
        check_status_of_unlim()
    elif answer == '4':
        stop_unlimited_period()
    elif answer == 'q':
        sys.exit()

def start_unlimited_period():
    global time_start_unlim
    time_start_unlim = datetime.now()

def check_status_of_unlim():
    current_time = datetime.now()
    print('Start    ', time_start_unlim)
    print('Current  ', current_time)
    print('You work ', current_time - time_start_unlim)
    input()

def stop_unlimited_period():
    time_end_unlim = datetime.now()
    print('Start    ', time_start_unlim)
    print('End      ', time_end_unlim)
    print('Your work', time_end_unlim - time_start_unlim)
    input()

# NOT USED !!!
# FIX: need to use threading library - timer
# much better solution then timedelta
# for more info, try google 'python timer'
def start_45minute():
    '''
    For 45 minutes circle
    '''
    start, end = initiation_of_start_and_end_time()
    print(start, end)

    t = timedelta()
    t1 = timedelta(seconds=1)
    while (end - start) > t:
        sleep(1)
        start += t1
        print(start)
        
# ALSO NOT USED YET
def initiation_of_start_and_end_time():
    start_datetime = datetime.now()
    circle45 = timedelta(minutes=45)

    start_datetime_in_timedelta = convert_datetime_to_timedelta(start_datetime)
    end_time = start_datetime_in_timedelta + circle45
    return start_datetime_in_timedelta, end_time
########


def convert_datetime_to_timedelta(some_datetime):
    some_timedelta = timedelta(hours=some_datetime.hour, minutes=some_datetime.minute, seconds=some_datetime.second)
    return some_timedelta


