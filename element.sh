#!/bin/bash
#!/bin/bash


PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

echo "Please provide an element as an argument."
read ELEMENT
ELEMENT_INFO=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using (type_id) where symbol='$ELEMENT' or name='$ELEMENT'")
echo "$ELEMENT_INFO"