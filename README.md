# AutoUpdateNFIX2Strat

Clone the repo and update the following params as per your environment.

BotPath="PATH TO BOT"

bot_token="your-telegram-bot-token"

chat_id="your-telegram-chat-id"


To Automate and recevie message via Telegram setup the cron as follows:
### Update the path in the CD command to where you have placed the script.
30 * * * * cd /opt/crypto/trading-bots/AutoUpdate;sh AutoUpdateStrategy.sh >>AutoUpdateStrategy.logs 2>&1
