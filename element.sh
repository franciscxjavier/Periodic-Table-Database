#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
echo "Please provide an element as an argument."
ELEMENT=$1

MAIN(){
  ELEMENT_BY_ID
}

ELEMENT_BY_ID(){
if [[ $ELEMENT =~ ^[0-9]+$ ]]
then
  ELEMENT_ID_QUERY=$($PSQL "select a.atomic_number, name, symbol, c.type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements a, properties b, types c where a.atomic_number=b.atomic_number and b.type_id=c.type_id and a.atomic_number=$ELEMENT;")

  if [[ -z $ELEMENT_ID_QUERY ]]
  then
      ELEMENT_BY_SYMBOL
  else
    echo "$ELEMENT_ID_QUERY" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
  do
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
  done
  fi
fi
}

ELEMENT_BY_SYMBOL(){
  echo "ELEMENT_BY_SYMBOL"
}

ELEMENT_BY_NAME(){
  echo "ELEMENT_BY_NAME"
}

MAIN
