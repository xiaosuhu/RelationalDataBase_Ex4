#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

echo "Please provide an element as an argument." 

#read ELEMENT
ELEMENT=$1

# switch between number and string
re='^[0-9]+$'
if [[ $ELEMENT =~ $re ]]
then
   ELEMENT_INFO=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using (type_id) where atomic_number=$ELEMENT")
else
  ELEMENT_INFO=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using (type_id) where symbol='$ELEMENT' or name='$ELEMENT'")
fi
echo "$ELEMENT_INFO"