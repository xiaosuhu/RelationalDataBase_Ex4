#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#read ELEMENT
ELEMENT=$1

if [[ -z $ELEMENT ]]
then
  echo "Please provide an element as an argument." 
else

  # switch between number and string
  re='^[0-9]+$'
  if [[ $ELEMENT =~ $re ]]
  then
    ELEMENT_INFO=$($PSQL "select atomic_number, symbol, name, atomic_mass,melting_point_celsius,boiling_point_celsius, type from elements inner join properties using(atomic_number) inner join types using (type_id) where atomic_number=$ELEMENT")
  else
    ELEMENT_INFO=$($PSQL "select atomic_number, symbol, name, atomic_mass,melting_point_celsius,boiling_point_celsius, type from elements inner join properties using(atomic_number) inner join types using (type_id) where symbol='$ELEMENT' or name='$ELEMENT'")
  fi

  if [[ -z $ELEMENT_INFO ]]
  then
    echo "I could not find that element in the database."
  else
    # Parse the output
    echo "$ELEMENT_INFO" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING BAR BOILING BAR TYPE
    do 
      #echo "$SYMBOL"
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
fi