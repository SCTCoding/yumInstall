#! /bin/bash

yumEvent="$1"
#YES/NO|BLANK
reconRequired="$2"

counter=1
execStatus=1

echo "Executing: Policy Event: $yumEvent"

until [[ $counter -gt 4 ]] || [[ $execStatus -eq 0 ]]
do
	
	## Sleep longer if we are almost to the end.
	if [[ $counter -ge 3 ]]
	then
		/bin/sleep $(( ( RANDOM % 10 )  + 1 ))
	else
		/bin/sleep $(( ( RANDOM % 5 )  + 1 ))
	fi
	
	/usr/local/bin/jamf policy -event "$yumEvent"
	execStatus=$?
	
	if [[ $execStatus -eq 0 ]]
	then
		break
	fi
	
	counter=$(( $counter + 1 ))
done

if [[ $execStatus -eq 0 ]] && [[ $counter -le 4 ]]
then
	echo "Success on try: $counter"
else
	echo "Failed to complete: $yumEvent after four tries."
fi

## Recon control
reconRequired=$(echo -n "$reconRequired" | /usr/bin/xargs | /usr/bin/tr '[:lower:]' '[:upper:]')

if [[ "$reconRequired" == "YES"  ]] && [[ $execStatus -eq 0 ]]
then
	echo "Executing recon as requested."
	/usr/local/bin/jamf recon
    exit 0
elif [[ "$reconRequired" == "NO"  ]] && [[ $execStatus -eq 0 ]]
then
	echo "No recon needed."
    exit 0
elif [[ -z "$reconRequired"  ]] && [[ $execStatus -eq 0 ]]
then
	echo "No recon needed."
    exit 0
elif [[ $execStatus -gt 0 ]]
then
	echo "No recon needed."
    exit 1
else
	echo "No recon needed."
fi

exit 0
