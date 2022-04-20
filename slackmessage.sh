##
# Simple helper to send a file to a Slack webhook.
# 
# Call with filename of messages to send to Slack.
# Set SLACK_WEBHOOK_URL env before running.
# 
# A simple helper by Jemurai.
filename=$1
slackurl=$2
echo "Processing " + $filename
while read line
do
    sed "s/__FILE_CONTENTS__/$line/" slacktemplate.json > slackmessage.json
    curl -X POST -H 'Content-type: application/json' --data @slackmessage.json $slackurl
done < $filename
rm slackmessage.json
