   print(){
   clear
   echo "______                      _    _            "
   echo "| ___ \                    | |  (_)          "
   echo "| |_/ / _ __   __ _    ___ | |_  _   ___   ___ "
   echo "|  __/ |  __| / _  |  / __|| __|| | / __| / _ \\"
   echo "| |    | |   | (_| | | (__ | |_ | || (__ |  __/"
   echo "\_|    |_|    \__,_|  \___| \__\|_| \___| \___|"
   echo " "
   echo "(_)       | |    (_)                    "
   echo " _  _ __  | |     _  _ __   _   _ __  __"
   echo "| ||  _ \ | |    | ||  _ \ | | | |\ \/ /"
  echo "| || | | || |____| || | | || |_| | >  <"
  echo "|_||_| |_|\_____/|_||_| |_| \__,_|/_/\_\\"
  echo "-NAME-----------------CMD------------------PID-----STIME----"
  for (( i=0 ; i<20 ; i++ ))
  do
     printf "|"
    if [ $i -eq $name_cur ]; then
        printf "^[[41m"
     fi
   printf "%20s^[[0m|" ${name[$i]:0:20}
   if [ $i -eq $pro_cur ]; then
     printf "^[[42m"
   fi
    printf "%-20s^[[0m|" ${cmd[$i]:0:20}
     if [ $i -eq $pro_cur ]; then
         printf "^[[42m"
     fi
     printf "%7s^[[0m|" ${pid[$i]:0:7}
    if [ $i -eq $pro_cur ]; then
        printf "^[[42m"
     fi
     printf "%8s^[[0m|" ${stime[$i]:0:8}·
 printf "\n"
 done
  echo "------------------------------------------------------------"
  }
  declare -i pro_cur=-1
  declare -i name_cur=0
  while [ 1 ]
  do
  declare -a name=(`grep -i /bin/bash /etc/passwd | cut -f1 -d: | sort`)
  declare -a cmd=(`ps -o cmd -u ${name[$name_cur]} | grep -v "CMD"`)
  declare -a pid=(`ps -o pid -u ${name[$name_cur]} | grep -v "PID"`)
  declare -a stime=(`ps -o stime -u ${name[$name_cur]} | grep -v "STIME"`)
  print
  echo "If you want to exit , Please Type 'q' or 'Q'"
  read -n 3 key
      if [ "$key" = 'q' ] || [ "$key" = 'Q' ]; then
      break
      elif [ "$key" = '^[[A' ]; then
          if [ "$pro_cur" -eq -1 ]; then
              if [ "$name_cur" -gt 0 ]; then
                  name_cur=${name_cur}-1
              fi
          else
             if [ "$pro_cur" -gt 0 ]; then
                  pro_cur=${pro_cur}-1
              fi
          fi
      elif [ "$key" = '^[[B' ]; then
        if [ "$pro_cur" -eq -1 ]; then
              if [[ "$name_cur" -lt $((${#name[@]}-1)) ]] && [[ "$name_Cur" -lt 19 ]] ; then
                  name_cur=${name_cur}+1
             fi
          else
              if [[ "$pro_Cur" -lt $((${#cmd[@]})) ]] && [[ "$pro_cur" -lt 19 ]]; then
                  pro_cur=${pro_cur}+1
              fi
          fi
      elif [ "$key" = '^[[C' ]; then
           if [ "$pro_cur" -eq -1 ]; then
              pro_cur=0
           fi
      elif [ "$key" = '^[[D' ]; then
          if [ "$pro_cur" -ge 0 ]; then
              pro_cur=-1
          fi
      fi
  done
