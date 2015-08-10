#!/bin/bash

[ "$#" -ne 3 ] &&  {
  echo "Usage: logger.sh <input_raw_file> <output_file> <channel_name>"
  exit 1
}
_INPUT_FILE=$1
_LOG_FILE=$2
_CHANNEL=$3
_STYLES="<style>.name {color: red;}</style>"

# this works for the original raw pircbotx log output
# initial copy
#echo "<html><h1>$_CHANNEL</h1><table>"`cat $_INPUT_FILE | grep "PRIVMSG $_CHANNEL" | grep -v "SAFELIST" | grep -v "TARGMAX" | grep -v ">>>PRIVMSG" | awk '{$2=substr($2, 5, index($2, "!") - 5); $3=""; $4="";  print strftime("%b %d %H:%M:%S  %Y", substr($1, 0, 10))$0;}' | awk '{$1="<nobr>"$1; $3=$3"</nobr>"; $4=""; $5="</td><td><span style=\"color:red;\">"$5"</span></td><td>"; $6=substr($6, 2); print "<tr><td>"$0"</td></tr>"}' | sed 's/\(https\?:\/\/[^ <]*\)/<a href="\1">\1<\/a>/'` > $_LOG_FILE

# listen and add new changes
#tail -f $1 | grep --line-buffered "PRIVMSG $_CHANNEL" | grep --line-buffered -v "SAFELIST" | grep --line-buffered -v "TARGMAX" | grep --line-buffered -v ">>>PRIVMSG" | awk '{$2=substr($2, 5, index($2, "!") - 5); $3=""; $4="";  print strftime("%b %d %H:%M:%S  %Y", substr($1, 0, 10))$0;system("")}' | awk '{$1="<nobr>"$1; $3=$3"</nobr>"; $4=""; $5="</td><td><span style=\"color:red;\">"$5"</span></td><td>"; $6=substr($6, 2); print "<tr><td>"$0"</td></tr>";system("")}' | sed -u 's/\(https\?:\/\/[^ <]*\)/<a href="\1">\1<\/a>/' >> $_LOG_FILE

# initial copy
echo "<html><head><title>IRC LOG for $_CHANNEL</title>$_STYLES</head><body><h1>$_CHANNEL</h1><table>"`cat $_INPUT_FILE | awk '{$1="<nobr>"$1; $3=$3"</nobr>"; $4=""; $5="</td><td><span class=\"name\">"$5"</span></td><td>"; $6=substr($6, 2); print "<tr><td>"$0"</td></tr>"}' | sed 's/\(https\?:\/\/[^ <]*\)/<a href="\1">\1<\/a>/'` #> $_LOG_FILE

# listen and add new changes
tail -f $1 | awk '{$1="<nobr>"$1; $3=$3"</nobr>"; $4=""; $5="</td><td><span class=\"name\">"$5"</span></td><td>"; $6=substr($6, 2); print "<tr><td>"$0"</td></tr>"}' | sed -u 's/\(https\?:\/\/[^ <]*\)/<a href="\1">\1<\/a>/'` >> $_LOG_FILE
