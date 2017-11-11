
#Script WIP by Becca Rauch.
# What is this...
# This is a large script that runs a sequential chain of commands that will return the overview of system health and infrastructure information.

# Things to work on: 
#Adding color to more easily identify each child category under parent categories, Possibly Divide this information into two seperate scripts...
#... adding prompt in the begining of the script before script proceeds to run. run if yes, abort if no. CLean up redundant info and possibly cut down on...
#... length and size of information displayed to make it easier to read. work with dividing infomration more cleanly in when parsing out server stack information...
#...under service/versions.

sysinfo ()
{
echo -e '\n--------------------------\n\n';
echo -e " Please be prepared to use sudo access to get all information that this script will be parsing."
echo -e " This info is a conglomeration of simple commands that will mainly procure summarized data on server infrastructure, user info, and system health."
echo -e '\n--------------------------\n\n';

# -Hostname and OS information:
echo -e "\e[31;43m***** HOSTNAME, KERNEL, and OS INFORMATION *****\e[0m"
hostnamectl;
ip a | grep inet;



# -service/versions:
echo -e "\e[31;43m***** KERNEL, STACK and OS INFORMATION *****\e[0m"
echo -e "\e[1;32mCPU Overview\e[0m"
lscpu;
echo -e '----\n       \n\n';
echo -e "\e[1;32mApache Version and Server Compiled Data\e[0m"
apachectl -V;
echo -e '----\n       \n\n';
echo -e "\e[1;32mNGINX Version\e[0m";
nginx -v;
echo -e '----\n       \n\n';
echo -e "\e[1;32mMySQL Version\e[0m";
mysql -V;
echo -e '----\n       \n\n';
echo -e "\e[1;32mPHP Version\e[0m";
php --version;
echo -e '----\n       \n\n';
echo -e "\e[1;32mSSH Version\e[0m";
ssh -V;
echo -e '----\n       \n\n';
echo -e "\e[1;32mVarnish Version\e[0m";
varnishd -V;
echo -e '----\n       \n\n';
echo -e '\n***** For Active Module information refer to the following: php -m , php7.0 -i , nginx -V , lsmod , apachectl -M\n\n';


# -System uptime, reboots, and load:
echo -e "\e[31;43m***** SYSTEM UPTIME*****\e[0m"
echo -e "\e[1;32mRecent Reboots\e[0m";
last reboot | head -5

echo -e '----\n       \n\n';
# -Logged-in users:
echo -e "\e[31;43m***** CURRENTLY LOGGED-IN and PREVIOUS 10 ACTIVE USERS *****\e[0m"
echo -e "\e[1;32mSanity check... Who are you again? \e[0m";
logname;
echo -e '----\n       \n\n';
echo -e "\e[1;32mWho else is logged in?\e[0m";
w;
echo -e '----\n       \n\n';
echo -e "\e[1;32mRecent Logins - Last 10\e[0m";
last -30;

echo -e '----\n       \n\n';
# -Active http connections:
echo -e "\e[1;32mESTABLISHED HTTP Connections\e[0m";
echo -e '\nTotal:\n\n';
netstat | grep http | grep 'ESTABLISHED' | wc -l

echo -e '----\n       \n\n';
# -Active http connections and mysql connections:
echo -e "\e[1;32mESTABLISHED MYSQL Connections\e[0m";
echo -e '\nTotal:\n\n';
netstat -antp | grep :3306 | grep 'ESTABLISHED' | wc -l

echo -e '----\n       \n\n';
# - Active VHosts
echo -e "\e[31;43m***** ACTIVE VHOSTS*****\e[0m"
echo -e "\e[1;32mActive VHosts\e[0m";
apachectl -S | wc -l
echo -e '----\n       \n\n';
echo -e "\e[1;32mTotal Installs - Live\e[0m";
php /opt/nas/www/tools/wpe.php get-sites-clean $(cat /etc/cluster-id) 1 1 | wc -l;

echo -e '----\n       \n\n';
# -File system disk space usage:
echo -e "\e[31;43m***** FILE SYSTEM CONFIGUARATION and  DISK SPACE USAGE *****\e[0m"
echo -e "\e[1;32mProcuring mounted File System Information...\e[0m";
df -h; fdisk -l;
echo -e '----\n       \n\n';
echo -e "\e[1;32mListing mounted Block Devices - FS mount tree...\e[0m";
lsblk;
echo -e '----\n       \n\n';
echo -e "\e[1;32mProcuring LVM Group Information...\e[0m";
sudo vgdisplay;


# -Free and used memory in the system:
echo -e "\e[31;43m ***** FREE AND USED MEMORY *****\e[0m"
free -h;
echo -e '\n     \n\n';
vmstat -s;


# -MySQl Space and engine buffers:
echo -e "\e[31;43m***** MYSQL Usage *****\e[0m"
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
echo -e '\n       \n\n';
echo -e "\e[1;32mDone.\e[0m"
}
