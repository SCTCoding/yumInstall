#! /bin/bash

#############################################################
#     _____ __________________          ___            	    #
#    / ___// ____/_  __/ ____/___  ____/ (_)___  ____ _     #
#    \__ \/ /     / / / /   / __ \/ __  / / __ \/ __ `/     #
#   ___/ / /___  / / / /___/ /_/ / /_/ / / / / / /_/ /      #
#  /____/\____/ /_/  \____/\____/\__,_/_/_/ /_/\__, /       # 
#                                             /____/        #  
#############################################################

#############################################################
## Create by Simon Carlson-Thies on 4/21/22
## Copyright © 2022 Simon Carlson-Thies All rights reserved.
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.
#############################################################

yumEvent="$4"
#YES/NO|BLANK
reconRequired="$5"
#NO
existingProcess="$6"

fileName=$(echo -n "${yumEvent}_exec")

processIs=$(ps -A | /usr/bin/grep "/private/tmp/${fileName}.sh" | /usr/bin/grep -v "grep")

if [[ ! -z "$processIs" ]]
then
	echo "Process alread running."
	if [[ "$existingProcess" == "NO" ]]
	then
		exit 0
	else
		kill $(echo -n "$processIs" | /usr/bin/awk '{print $1}')
	fi
fi

if [[ -e "/private/tmp/${fileName}.sh" ]]
then
	rm "/private/tmp/${fileName}.sh"
	echo "IyEgL2Jpbi9iYXNoCgp5dW1FdmVudD0iJDEiCiNZRVMvTk98QkxBTksKcmVjb25SZXF1aXJlZD0iJDIiCgpjb3VudGVyPTEKZXhlY1N0YXR1cz0xCgplY2hvICJFeGVjdXRpbmc6IFBvbGljeSBFdmVudDogJHl1bUV2ZW50IgoKdW50aWwgW1sgJGNvdW50ZXIgLWd0IDQgXV0gfHwgW1sgJGV4ZWNTdGF0dXMgLWVxIDAgXV0KZG8KCQoJIyMgU2xlZXAgbG9uZ2VyIGlmIHdlIGFyZSBhbG1vc3QgdG8gdGhlIGVuZC4KCWlmIFtbICRjb3VudGVyIC1nZSAzIF1dCgl0aGVuCgkJL2Jpbi9zbGVlcCAkKCggKCBSQU5ET00gJSAxMCApICArIDEgKSkKCWVsc2UKCQkvYmluL3NsZWVwICQoKCAoIFJBTkRPTSAlIDUgKSAgKyAxICkpCglmaQoJCgkvdXNyL2xvY2FsL2Jpbi9qYW1mIHBvbGljeSAtZXZlbnQgIiR5dW1FdmVudCIKCWV4ZWNTdGF0dXM9JD8KCQoJaWYgW1sgJGV4ZWNTdGF0dXMgLWVxIDAgXV0KCXRoZW4KCQlicmVhawoJZmkKCQoJY291bnRlcj0kKCggJGNvdW50ZXIgKyAxICkpCmRvbmUKCmlmIFtbICRleGVjU3RhdHVzIC1lcSAwIF1dICYmIFtbICRjb3VudGVyIC1sZSA0IF1dCnRoZW4KCWVjaG8gIlN1Y2Nlc3Mgb24gdHJ5OiAkY291bnRlciIKZWxzZQoJZWNobyAiRmFpbGVkIHRvIGNvbXBsZXRlOiAkeXVtRXZlbnQgYWZ0ZXIgZm91ciB0cmllcy4iCmZpCgojIyBSZWNvbiBjb250cm9sCnJlY29uUmVxdWlyZWQ9JChlY2hvIC1uICIkcmVjb25SZXF1aXJlZCIgfCAvdXNyL2Jpbi94YXJncyB8IC91c3IvYmluL3RyICdbOmxvd2VyOl0nICdbOnVwcGVyOl0nKQoKaWYgW1sgIiRyZWNvblJlcXVpcmVkIiA9PSAiWUVTIiAgXV0gJiYgW1sgJGV4ZWNTdGF0dXMgLWVxIDAgXV0KdGhlbgoJZWNobyAiRXhlY3V0aW5nIHJlY29uIGFzIHJlcXVlc3RlZC4iCgkvdXNyL2xvY2FsL2Jpbi9qYW1mIHJlY29uCiAgICBleGl0IDAKZWxpZiBbWyAiJHJlY29uUmVxdWlyZWQiID09ICJOTyIgIF1dICYmIFtbICRleGVjU3RhdHVzIC1lcSAwIF1dCnRoZW4KCWVjaG8gIk5vIHJlY29uIG5lZWRlZC4iCiAgICBleGl0IDAKZWxpZiBbWyAteiAiJHJlY29uUmVxdWlyZWQiICBdXSAmJiBbWyAkZXhlY1N0YXR1cyAtZXEgMCBdXQp0aGVuCgllY2hvICJObyByZWNvbiBuZWVkZWQuIgogICAgZXhpdCAwCmVsaWYgW1sgJGV4ZWNTdGF0dXMgLWd0IDAgXV0KdGhlbgoJZWNobyAiTm8gcmVjb24gbmVlZGVkLiIKICAgIGV4aXQgMQplbHNlCgllY2hvICJObyByZWNvbiBuZWVkZWQuIgpmaQoKZXhpdCAw" | /usr/bin/base64 -D >> "/private/tmp/${fileName}.sh"
fi

nohup /bin/bash -c "/private/tmp/${fileName}.sh" "$yumEvent" "$reconRequired" &

exit 0
