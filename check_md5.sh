#!/bin/bash

filemd5=`md5sum $1 | awk '{print $1}'`
md5=$2

echo "Checking file: $1"
echo "File MD5: ${filemd5}"
echo "Against MD5: ${md5}"

if [ $filemd5 != $md5 ]
then
  echo "MD5 sums mismatch."
  exit 1
else
  echo "Checksums OK"
fi