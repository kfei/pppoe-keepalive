# pppoe-keepalive

Scripts to keep PPPOE connection alive.

## Usage

  - For Linux, put the script into cron job and redirect output to /var/log/pppoe.log or something like that.
  - For Windows, schedule a job to run the vbs script.

## DDNS Updater

Usually the DDNS records need to update after PPPOE re-connected.

### CloudFlare

Automatically update CloudFlare Dynamic DNS records to the current external IP:

```bash
./cloudflare-ddns-updater.sh API_KEY USER_MAIL HOST_TO_UPDATE
```
