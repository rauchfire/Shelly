
# This script was built to help procure simple data at a quick pace from the source and destination servers before a migration.
# The script consist of a simple sequential command format, and would help determine if a server was healthy and the right fit for the site prior to migration.
# Information below outlines key information about php version, CPU, hostname, inset IP information, uptime, disk/parition size information,
# and physical / virtual memory usage. 

migratespec()
{

# -Migration info:
echo -e "\e[31;43m***** Server Specs for Migration *****\e[0m"
echo -e "\e[1;32m Hostname Info\e[0m";
hostnamectl;
ip a | grep 'inet'
echo -e '----';
echo -e "\e[1;32mPHP Version\e[0m";
php --version | head -1; 
echo -e '\n     \n\n';
php7.0 -i | head -10;
echo -e '----';
echo -e "\e[1;32mCPU Core Specifications\e[0m";
echo -e "Cores ="; nproc;
echo -e '----';
echo -e "\e[1;32m Mounted Partition Summary\e[0m";
df -h;
echo -e '----';
echo -e "\e[1;32mUptime\e[0m";
uptime;
echo -e '----';
echo -e "\e[1;32mMemory Specs\e[0m";
free -h; 
echo -e '\n     \n\n';
vmstat -s | head -10;
}
