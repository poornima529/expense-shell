#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
n="\e[0m"

LOGS_FOLDER="/var/log/expense-logs"
LOGS_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else 
        echo -e "$2 ... $G SUCCESS $N"
    fi       
}  

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "ERROR:: you must have sudo access to execute this script"
        exit 1 #other than 0
    fi
}

echo "script started executing at: $TIMESTAMP" &>>$LOG FILE NAME

CHECK_ROOT

dnf install mysql-server -y &>>$LOG_FILE_NAME
VALIDATE $? "Istalling MySQL server"

systemctl enable mysqld  &>>$LOG_FILE_NAME
VALIDATE $? "Enabling MySQL server"

systemctl start mysqld &>>$LOG_FILE_NAME
VALIDATE $? "starting MySQL server"

mysql_secure_installation --set-root-pass ExpenseApp@1
VALIDATE $? "setting root password"

