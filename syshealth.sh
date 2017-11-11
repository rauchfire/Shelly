
####### Syshealth


syshealth()
{
echo -e "\e[31;43m***** Current System Health Check*****\e[0m"
echo -e '----\n       \n\n';
# -Top 5 processes as far as cpu usage is concerned:
echo -e "\e[31;43m***** CPU-Averages and CPU CONSUMING PROCESSES *****\e[0m"
ps -eo %mem,%cpu,comm --sort=-%cpu | head -n 6;
echo -e '----\n       \n\n';
echo -e "\e[1;32m Report processors and current related cpu statistics\e[0m";
mpstat 1 10;
echo -e "\e[1;32m Reporting Virtual Memory statistics\e[0m";
vmstat 1 10;
echo -e '----\n       \n\n';
echo -e "\e[1;32mIO average statistics\e[0m";
iostat;
echo -e '----\n       \n\n';
echo -e "\e[1;32mSar info - Load Avg\e[0m";
echo -e '\nrunq-sz  plist-sz   ldavg-1   ldavg-5  ldavg-15   blocked\n\n';
sar -q | tail -5;
echo -e '----\n       \n\n';
echo -e "\e[1;32mR/W/await CPU Avg\e[0m";
echo -e '\n DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz     await     svctm     %util\n\n';
sar -d | tail -5;
echo -e "\e[1;32mRAM Averages\e[0m";
echo -e '\n kbmemfree kbmemused  %memused kbbuffers  kbcached  kbcommit   %commit  kbactive   kbinact   kbdirty\n\n';
sar -r | tail -5


echo -e '----\n       \n\n';
# -Checking for hang ups:
echo -e "\e[31;43m***** CHECK FOR HANGUPS and D STATES *****\e[0m"
echo -e "\e[1;32mActive D States. Returns nothing if none found.\e[0m"
ps aux | awk '{if ($8 ~ "D") print $0}';
echo -e '----\nChecking for Defunct Workers...\n\n';
ps axo stat,ppid,pid,comm | grep -w defunct

echo -e '----\n       \n\n';
# -Checking for Latest OOM status... - output returns nothing if nothing found:
echo -e "\e[31;43m ***** Checking for Latest OOM status...*****\e[0m"
echo -e "\e[1;32mOutput returns nothing if nothing found\e[0m";
echo -e '\nChecking via dmesg...\n\n';
dmesg | grep -i "oom"
echo -e '----\n       \n\n';
echo -e '----\nChecking via kern log\n\n';
grep -i 'oom' /var/log/kern.log;


echo -e '----\n       \n\n';
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
echo -e "\e[1;32mDone.\e[0m"
}
