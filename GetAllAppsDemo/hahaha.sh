
cat DecodeStringlist.list | while read line  ; do
echo $line | sed 's#\"#\\"#g ; s#\/#\\/#g'
echo $line
done
