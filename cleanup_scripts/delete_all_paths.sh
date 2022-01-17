#!/bin/bash

while IFS= read -r line; do
	hadoop fs -rm -r $line
	echo "Deleted: $line"
done < path_list

