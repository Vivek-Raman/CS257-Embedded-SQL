
sudo docker cp ./sample2.sqc mydb2:/database/config/db2inst1/workspace/sample2.sqc

cat <<EOF | docker exec --interactive mydb2 /bin/bash
su - db2inst1
echo Logged in

cd workspace
db2 connect to sample
echo DB connected

db2 prep sample2.sqc
echo Embedded file prepared

gcc -I../sqllib/include -c sample2.c
echo Compiled

gcc -o sample2 sample2.o -L../sqllib/lib -ldb2
echo Linked and generated executable

./sample2
echo Execution complete

EOF
