#!/usr/bin/env bash

# Gets a random word from wordnik. If the random word
# contains a "-", get another
function rand_word {
  word=$(curl -s https://www.wordnik.com/randoml |\
              grep -o "\/words\/[^\/]*\/"        |\
              awk -F \/ '{print $3}'             |\
              tr A-Z a-z)
  # check for "-"
  if echo $word | grep \- >/dev/null 
  then
    rand_word
  else
    echo $word
  fi
}


# Get the definition from wordnik
function define {
  curl -s https://www.wordnik.com/words/$1/?random=true |\
       grep partOfSpeech                                |\
       sed 's/^.*partOfSpeech">//g'                     |\
       sed 's/<\/abbr>//g'                              |\
       sed 's/<\/li>//g'
}

# get three words
one=$(rand_word)
two=$(rand_word)
three=$(rand_word)

# show each word and it's definition
echo $one
define $one
echo ''
echo $two
define $two
echo ''
echo $three
define $three
echo ''

# display all three words smushed together, like in a password
echo $one$two$three
