
mysqlbufferchecker()
{
# -MySQl Space and engine buffers:
echo -e "\e[31;43m***** MYSQL BUFFERS, MEMORY CONSUMPTION AND USAGE *****\e[0m"
echo -e '\n       \n\n';
echo -e "\e[1;32mMySQL Query Overview\e[0m";
mysqladmin proc stat | tail -1
echo -e '----\n       \n\n';
echo -e "\e[1;32mInnodb Buffer Limits\e[0m";
grep -i 'innodb' /etc/mysql/my.cnf
echo -e '----\n       \n\n';
echo -e "\e[1;32mTotal Disk Consumed by DB Files\e[0m";
du -sh /var/lib/mysql/
echo -e '----\n       \n\n';
echo -e "\e[1;32mTotal Active MyIsam tables\e[0m";
mysql -e "USE information_schema; SELECT TABLE_SCHEMA, ENGINE FROM TABLES WHERE ENGINE='myisam';" | wc -l
}

