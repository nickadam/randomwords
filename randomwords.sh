#!/usr/bin/env bash

function rand_word {
  word=$(curl -s https://www.wordnik.com/randoml |\
              grep -o "\/words\/[^\/]*\/"        |\
              awk -F \/ '{print $3}'             |\
              tr A-Z a-z)
  if echo $word | grep \- >/dev/null
  then
    rand_word
  else
    echo $word
  fi
}

function define {
  curl -s https://www.wordnik.com/words/$1/?random=true |\
       grep partOfSpeech                                |\
       sed 's/^.*partOfSpeech">//g'                     |\
       sed 's/<\/abbr>//g'                              |\
       sed 's/<\/li>//g'
}

one=$(rand_word)
two=$(rand_word)
three=$(rand_word)

echo $one
define $one
echo ''
echo $two
define $two
echo ''
echo $three
define $three
echo ''

echo $one$two$three
