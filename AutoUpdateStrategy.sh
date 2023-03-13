#!/bin/bash
SCRIPT_DIR=`dirname $0`
BASEDIR=`cd ${SCRIPT_DIR} && pwd`
cd $BASEDIR
now=$(date)
echo "\n --- LAUNCHING THE STRATEGY UPDATE SCRIPT $now --- \n"

BotPath="PATH TO BOT"
StrategyURL="https://github.com/iterativv/NostalgiaForInfinity/archive/refs/heads/main.zip"
Restartcommand="cd /bots/freqtrade && /usr/bin/docker-compose restart"
bot_token="your-telegram-bot-token"
chat_id="your-telegram-chat-id"

wget -q $StrategyURL
unzip -q main.zip

localStrategy="$BASEDIR/NostalgiaForInfinity-main/NostalgiaForInfinityX2.py"
BotStrategy="$BotPath/user_data/strategies/NostalgiaForInfinityX2.py"

localversion=`grep 'v12.0' $localStrategy |cut -d '"' -f2`
Botversion=`grep 'v12.0' $localStrategy |cut -d '"' -f2`


if [[ "$localversion" =~ $Botversion ]]; then
  echo "The Strategy version is in Sync with Github"
  message="The Strategy version is in Sync with Github.Lastest version:$localversion|botStrategy Version:$Botversion"
  curl -sS -X POST -H "Content-Type:multipart/form-data" -F chat_id=$chat_id -F text="$message" "https://api.telegram.org/bot$bot_token/sendMessage"
else
  echo "\n The Strategy version is not in Sync with Github. Lastest version:$localversion|botStrategy Version:$Botversion Updating now.\n"
  message="The Strategy version is not in Sync with Github. Lastest version:$localversion|botStrategy Version:$Botversion Updating now."
  curl -sS -X POST -H "Content-Type:multipart/form-data" -F chat_id=$chat_id -F text="$message" "https://api.telegram.org/bot$bot_token/sendMessage"
  cp $localStrategy $BotStrategy
  $Restartcommand
  message="Strategy Updated and bots restarted."
  curl -sS -X POST -H "Content-Type:multipart/form-data" -F chat_id=$chat_id -F text="$message" "https://api.telegram.org/bot$bot_token/sendMessage"
fi
rm -rf $BASEDIR/main.zip $BASEDIR/NostalgiaForInfinity-main
echo "\n --- END OF THE STRATEGY UPDATE SCRIPT $now ---\n"
