#!/bin/bash -e
shopt -s nocaseglob nocasematch
: ${LETTERS:=5}; : ${ROUNDS:=6}; : ${DICTIONARY:=/usr/share/dict/words}

pool=abcdefghijklmnopqrstuvwxyz
hit='\e[30;102m'; match='\e[30;103m'; miss='\e[30;107m'; reset='\e[0m'
secret="$(sort -R $DICTIONARY | grep -xEm 1 '\w{'$LETTERS'}')"

${DEBUG:+echo "$secret"}

for (( j=1; j <= $ROUNDS; j++ )); do
  read -ep "Enter your guess ($LETTERS letters | $j/$ROUNDS): " guess || 
exit
  (( ${#guess} == $LETTERS )) || { echo -e "  ERROR\timproper guess"; 
continue; }
  [[ "$guess" == "$secret" ]] && { win=1; break; }

  declare -a pad=() matched=()
  # mark hits while loading pad
  for (( i=0; i < $LETTERS; i++ )); do
    c=${guess:$i:1}; k=${secret:$i:1}
    [[ "$k" == "$c" ]] && pad[$i]='_' || pad[$i]=$k
  done

  for (( i=0; i < $LETTERS; i++ )); do
    c=${guess:$i:1}
    if [[ ${pad[$i]} == '_' ]]; then
      color=$hit; matched+=( $c )
    elif [[ `printf '%s' "${pad[@]}"` =~ "$c" ]]; then
      color=$match; pad=( ${pad[@]/$c/.} ); matched+=( $c )
    else
      color=$miss
      [[ `printf '%s' "${matched[@]}"` =~ "$c" ]] || pool=${pool/$c/ }
    fi
    echo -en "$color ${c^^} "
  done
  echo -e "${reset}\t\t${pool^^}\n"
done

[ ${win:-0} -eq 1 ] && echo "Congratulations!" ||
    echo "The word was '$secret'. Better luck next time!"
