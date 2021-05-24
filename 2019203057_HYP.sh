  1 
  2 print(){
  3 clear
  4 echo "______                      _    _            "
  5 echo "| ___ \                    | |  (_)          "
  6 echo "| |_/ / _ __   __ _    ___ | |_  _   ___   ___ "
  7 echo "|  __/ |  __| / _  |  / __|| __|| | / __| / _ \\"
  8 echo "| |    | |   | (_| | | (__ | |_ | || (__ |  __/"
  9 echo "\_|    |_|    \__,_|  \___| \__\|_| \___| \___|"
 10 echo " "
 11 echo "(_)       | |    (_)                    "
 12 echo " _  _ __  | |     _  _ __   _   _ __  __"
 13 echo "| ||  _ \ | |    | ||  _ \ | | | |\ \/ /"
 14 echo "| || | | || |____| || | | || |_| | >  <"
 15 echo "|_||_| |_|\_____/|_||_| |_| \__,_|/_/\_\\"
 16 echo "-NAME-----------------CMD------------------PID-----STIME----"
 17 for (( i=0 ; i<20 ; i++ ))
 18 do
 19    printf "|"
 20    if [ $i -eq $name_cur ]; then
 21        printf "^[[41m"
 22    fi
 23    printf "%20s^[[0m|" ${name[$i]:0:20}
 24    if [ $i -eq $pro_cur ]; then
 25        printf "^[[42m"
 26   fi
 27    printf "%-20s^[[0m|" ${cmd[$i]:0:20}
 28    if [ $i -eq $pro_cur ]; then
 29         printf "^[[42m"
 30    fi
 31    printf "%7s^[[0m|" ${pid[$i]:0:7}
 32    if [ $i -eq $pro_cur ]; then
 33         printf "^[[42m"
 34    fi
 35    printf "%8s^[[0m|" ${stime[$i]:0:8}·
 36    printf "\n"
 37 done
 38 echo "------------------------------------------------------------"
 39 }
 40 declare -i pro_cur=-1
 41 declare -i name_cur=0
 42 while [ 1 ]
 43 do
 44 declare -a name=(`grep -i /bin/bash /etc/passwd | cut -f1 -d: | sort`)
 45 declare -a cmd=(`ps -o cmd -u ${name[$name_cur]} | grep -v "CMD"`)
 46 declare -a pid=(`ps -o pid -u ${name[$name_cur]} | grep -v "PID"`)
 47 declare -a stime=(`ps -o stime -u ${name[$name_cur]} | grep -v "STIME"`)
 48 print
 49 echo "If you want to exit , Please Type 'q' or 'Q'"
 50 read -n 3 key
 51     if [ "$key" = 'q' ] || [ "$key" = 'Q' ]; then
 52     break
 53     elif [ "$key" = '^[[A' ]; then
 54         if [ "$pro_cur" -eq -1 ]; then
 55             if [ "$name_cur" -gt 0 ]; then
 56                 name_cur=${name_cur}-1
 57             fi
 58         else
 59             if [ "$pro_cur" -gt 0 ]; then
 60                 pro_cur=${pro_cur}-1
 61             fi
 62         fi
 63     elif [ "$key" = '^[[B' ]; then
 64         if [ "$pro_cur" -eq -1 ]; then
 65             if [[ "$name_cur" -lt $((${#name[@]}-1)) ]] && [[ "$name_Cur" -lt 19 ]] ; then
 66                 name_cur=${name_cur}+1
 67             fi
 68         else
 69             if [[ "$pro_Cur" -lt $((${#cmd[@]})) ]] && [[ "$pro_cur" -lt 19 ]]; then
 70                 pro_cur=${pro_cur}+1
 71             fi
 72         fi
 73     elif [ "$key" = '^[[C' ]; then
 74          if [ "$pro_cur" -eq -1 ]; then
 75             pro_cur=0
 76          fi
 77     elif [ "$key" = '^[[D' ]; then
 78         if [ "$pro_cur" -ge 0 ]; then
 79             pro_cur=-1
 80         fi
 81     fi
 82 done
