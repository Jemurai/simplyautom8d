##
# Simple helper to send a file to a Slack webhook.
# 
# Call with filename of messages to send to Slack.
# Set SLACK_WEBHOOK_URL env before running.
# 
# A simple helper by Jemurai.
filename=$1
echo "Processing " + $filename
case "$(uname -s)" in
    Darwin)
        SLACK_WEBHOOK_URL=$SLACK_WEBHOOK_URL
        ;;
    Linux)
        # Assuming in a github action if on linux ... 
        SLACK_WEBHOOK_URL=${{ secrets.SLACK_WEBHOOK_URL }}
        ;;
    *)
        echo "Slack webhook not found"
        ;;
esac
#echo "Sending to Slack " + $SLACK_WEBHOOK_URL
while read line
do
    sed "s/__FILE_CONTENTS__/$line/" slacktemplate.json > slackmessage.json
    curl -X POST -H 'Content-type: application/json' --data @slackmessage.json $SLACK_WEBHOOK_URL
done < $filename
rm slackmessage.json
