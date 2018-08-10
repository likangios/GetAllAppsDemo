#!/usr/bin/env bash

TABLENAME=symbols
CONFUSE_FILE="$PROJECT_DIR/$PROJECT_NAME"
HEAD_FILE="$PROJECT_DIR/$PROJECT_NAME/DecodeString.h"
STRING_SYMBOL_FILE="$PROJECT_DIR/$PROJECT_NAME/DecodeStringlist.list"
export LC_CTYPE=C

#取以.m或.h结尾的文件以+号或-号开头的行 |去掉所有+号或－号|用空格代替符号|n个空格跟着<号 替换成 <号|开头不能是IBAction|用空格split字串取第二部分|排序|去重复|删除空行|删掉以init开头的行>写进func.list
# "/.*?(@\".*?\")/i"

#rgrep  -h -r  "@\"" $CONFUSE_FILE --include '*.[m]' >$STRING_SYMBOL_FILE

grep -h -r -I  "@\"[0-9a-zA-Z]" $CONFUSE_FILE --include '*.[m]'| sed "s/.*\(@\".*\"\).*/\1/g" | sort|uniq |sed "/^$/d"  >$STRING_SYMBOL_FILE
#grep -h -r -I   $CONFUSE_FILE --include '*.[m]' |sed "s/*@/@/g"   >$STRING_SYMBOL_FILE

#grep -h -r -I  "^[-+]" $CONFUSE_FILE  --include '*.[mh]' >$STRING_SYMBOL_FILE

#s/[+-] 需要被替换的内容 / 替换内容  /g 替换所有的

#grep -h -r -I  "^[-+]" $CONFUSE_FILE  --include '*.[mh]' |sed "s/[+-]//g" >$STRING_SYMBOL_FILE
#
#grep -h -r -I  "^[-+]" $CONFUSE_FILE  --include '*.[mh]' |sed "s/[+-]//g"|sed "s/[();,: *\^\/\{]/ /g" >$STRING_SYMBOL_FILE
#
#grep -h -r -I  "^[-+]" $CONFUSE_FILE  --include '*.[mh]' |sed "s/[+-]//g"|sed "s/[();,: *\^\/\{]/ /g"|sed "s/[ ]*</</" >$STRING_SYMBOL_FILE
#
#grep -h -r -I  "^[-+]" $CONFUSE_FILE  --include '*.[mh]' |sed "s/[+-]//g"|sed "s/[();,: *\^\/\{]/ /g"|sed "s/[ ]*</</"| sed "/^[ ]*IBAction/d"|awk '{split($0,b," "); print b[2]; }' >$STRING_SYMBOL_FILE
#
#grep -h -r -I  "^[-+]" $CONFUSE_FILE  --include '*.[mh]' |sed "s/[+-]//g"|sed "s/[();,: *\^\/\{]/ /g"|sed "s/[ ]*</</"| sed "/^[ ]*IBAction/d"|awk '{split($0,b," "); print b[2]; }'| sort|uniq |sed "/^$/d" >$STRING_SYMBOL_FILE
#
#grep -h -r -I  "^[-+]" $CONFUSE_FILE  --include '*.[mh]' |sed "s/[+-]//g"|sed "s/[();,: *\^\/\{]/ /g"|sed "s/[ ]*</</"| sed "/^[ ]*IBAction/d"|awk '{split($0,b," "); print b[2]; }'| sort|uniq |sed "/^$/d"|sed -n "/^LY_/p" >$STRING_SYMBOL_FILE


ramdomString()
{
openssl rand -base64 64 | tr -cd 'a-zA-Z' |head -c 16
}

echo "" >$HEAD_FILE
touch $HEAD_FILE

cat "$STRING_SYMBOL_FILE" | while read -ra line; do
if [[ ! -z "$line" ]]; then
ramdom=`ramdomString`
#echo $line $ramdom
echo "/*$line*/ static unsigned char $ramdom = " >> $HEAD_FILE
fi
done

