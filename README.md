# domain-availability-notifier
A bash script to monitor domain availability and send Telegram notifications via cron scheduling.

Sure! Here's a detailed article explaining how to set up a cron job to monitor domain availability and send notifications via Telegram.

---

### How to Monitor Domain Availability and Send Telegram Notifications via Cron

If you’re managing domains or waiting for a specific domain to become available, it's helpful to automate the process of checking its availability. In this guide, I’ll show you how to set up a script on Linux that checks the status of a domain using `whois` and sends a notification to your Telegram account when the domain becomes available. Additionally, we will configure `cron` to run this check automatically at specified times.

### Requirements

- A Linux machine or server
- A domain to monitor (in this example, we will use `********`)
- A Telegram bot for sending notifications
- Basic knowledge of `bash` and `cron`

### Step 1: Create a Telegram Bot

Before we can send messages via Telegram, you need to create a bot and get its API token. Here’s how:

1. Open Telegram and search for **BotFather**.
2. Start a conversation and use the command `/newbot` to create a new bot.
3. Follow the prompts to choose a name and a username for your bot.
4. After the bot is created, BotFather will give you an API token in the format `********`. Keep this token safe, as you'll need it later.

### Step 2: Get Your Chat ID

To send messages, you'll also need your Telegram chat ID. You can get this by sending a message to your bot and then querying the bot's updates.

1. Send a message to your bot (for example, "Hello").
2. Use the following command to get updates, which will include your chat ID:

   ```bash
   curl -s "https://api.telegram.org/bot<your_bot_token>/getUpdates"
   ```

   Replace `<your_bot_token>` with your bot’s token. The response will contain a JSON object. Look for the `chat` object in the response, and note down the `id`. That is your chat ID.

### Step 3: Write the Monitoring Script

Now, we will create a script that checks the availability of the domain using `whois`. If the domain is available, the script will send a Telegram notification.

1. Create a file called `check_domain.sh`:

   ```bash
   nano check_domain.sh
   ```

2. Add the following script:

   ```bash
   #!/bin/bash

   # Domain to monitor
   DOMAIN="********"

   # Telegram bot token and chat ID
   TOKEN="********"
   CHAT_ID="********"
   MESSAGE="The domain $DOMAIN is available for registration!"

   # Check the domain status
   STATUS=$(whois $DOMAIN | grep -i "Status:" | head -1)

   # If the domain is available or no entries found, send a Telegram notification
   if [[ $STATUS == *"AVAILABLE"* ]] || [[ $STATUS == *"no entries found"* ]]; then
     curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d chat_id=$CHAT_ID -d text="$MESSAGE"
     echo "Notification sent via Telegram: $MESSAGE"
   else
     echo "The domain $DOMAIN is not available."
   fi
   ```

3. Save the file and make it executable:

   ```bash
   chmod +x check_domain.sh
   ```

### Step 4: Schedule the Script with Cron

You can now schedule this script to run automatically at specific intervals using `cron`.

1. Open your crontab file:

   ```bash
   crontab -e
   ```

2. Add the following line to schedule the script to run at 14:00 and 22:00 every day:

   ```bash
   0 14,22 * * * /path/to/check_domain.sh
   ```

   Replace `/path/to/check_domain.sh` with the full path to your script.

3. Save and close the crontab editor. Your script will now run automatically at the specified times and notify you via Telegram when the domain becomes available.

### Step 5: Test the Setup

To ensure everything is working, you can manually run the script:

```bash
./check_domain.sh
```

If the domain is available, you should receive a message via Telegram. If not, the script will print a message indicating the domain is still unavailable.

### Conclusion

This setup allows you to automate domain availability monitoring and receive real-time notifications via Telegram. By leveraging `cron`, `whois`, and the Telegram Bot API, you can streamline the domain registration process and ensure you're the first to know when a domain becomes available.

Feel free to adjust the script and `cron` schedule to suit your needs!

---

