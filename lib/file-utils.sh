#!/usr/bin/env bash
set -euo pipefail    ## "strict mode": exit on command errs or undefined vars

###|  file-utils.sh
 ##|  
 ##:  Author: Nathan Winant <nw@exegetic.net>
 ##|  
 ##|  NOTE: requires bash 4.
 ###

##====|  Functions  |========================================================##

##|  Read the contents of a .properties file and assign each property's value 
 #|  to a variable named after it, with dots converted to underscores. E.g.:
 #|  
 #|  user.name=Bob Hoskins   ->    user_name='Bob Hoskins'
 #|  
read_properties_file_to_variables() {
  local -r prop_file="${1}"
  if [ -f "${prop_file}" ]
  then
    while IFS='=' read -r key value
    do
      key=$(echo $key | tr '.' '_')
      eval "${key}='${value}'"
    done < "${prop_file}"
  else
    echo "${prop_file} not found."
  fi
}

##|  Read the contents of a .properties file into an associative array.
 #|  
read_properties_file_to_array() {
  local -r prop_file="${1}"
  local -r result_array="${2}"
  # read file line by line and populate the array. Field separator is "="
  while IFS='=' read -r k v; do
    eval "${result_array}['$k']='$v'"
  done < "${prop_file}"
}

##|  Get the value for a single property in a .properties file.
 #|  
read_value_from_properties_file() {
  local -r prop_name="${1}"
  local -r prop_file="${2}"
  grep "^${prop_name}" "${file}" | cut -d'=' -f2
}

##====|  Run  |==============================================================##

read_properties_file_to_variables_example() {
  read_properties_file_to_variables "${1}"
  echo "user name  = [${user_name}]"
  echo "foo        = [${foo}]"
  echo "some thing = [${some_thing}]"
}

read_properties_file_to_array_example() {
  declare -A properties
  read_properties_file_to_array "${1}" properties
  declare -p properties
  echo "foo        = <${properties[foo]}>"
  echo "some thing = <${properties[some.thing]}>"
  echo "user name  = <${properties[user.name]}>"
}

read_value_from_properties_file_example() {
  echo "user.name  = <"$(read_value_from_properties_file "user.name"  "$file")">"
  echo "foo        = <"$(read_value_from_properties_file "foo"        "$file")">"
  echo "some.thing = <"$(read_value_from_properties_file "some.thing" "$file")">"
}

run_file_utils_examples() {
  local -r file="example.properties"
 #read_properties_file_to_variables_example "${file}"
  echo
  echo "---------------------------------"
  echo
 #read_properties_file_to_array_example "${file}"
  echo
  echo "---------------------------------"
  echo
  read_value_from_properties_file_example "${file}"
}

#run_file_utils_examples

