# Jemurai Simply Autom8d

Simply Autom8d is a project to help organizations to do
simple security automations.

## Design

To try to make this as simple as possible, we tried to rely on
very basic Unix commands to assemble the output.  Things like:

- curl
- sed
- awk
- jq

We hope this makes them easy to port into different automation flows.
We also hope this will make it easy to add new types of data sources.

We tried to make it so that the same scripts will work locally
and in a Github Action without requiring much more than a shell.

## Automations

### Pulling Recent Vulnerability Information

The first area of work was to identify important
security information and work it into workflows.

The basic idea is to grab some of the most canonical data on
vulnerabilities (CISA, NVD) and then to make it easy to build
alerting around these in your automation flows.

#### CISA Known Exploited Vulnerabilities Catalog

These are vulnerabilities that are known to be used in the wild
to attack.

Our script grabs CISA Known Vulnerabilities and show recent (last two weeks) ones:
- `cisa-known-exploited.sh`
- Reference: https://www.cisa.gov/known-exploited-vulnerabilities-catalog

#### NVD CVE's

The NVD is a very rich resource but it can be overwhelming at times.

Our scripts grab recent NVD CVE's and can be altered to pull other sources as wel:
- `nvd-vulns.sh`
- Recent:  https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-recent.json.gz
- 2022:  https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-2022.json.gz

## Integrations

Of course, the whole idea is to make this information really easy to use.  So
we wanted to look at integrations with Slack and GitHub Actions.

### Slack Setup

Use the instructions here to set up slack webhooks:
https://api.slack.com/messaging/webhooks

We called our Slack application `Simply Autom8d`.

We set up a `#threat-intel` channel in our slack.

We activated Webhook URLs for our workspace.

Once you have the Slack webhook url, simply add it
to the environment as SLACK_WEBHOOK_URL.

For convenience, user or refer to the `slackmessage.sh`
file to send the contents of one of the other processes
to the slack webhook.

### GitHub Actions

To ease integration, we also have github actions for the
key scripts in `.github/workflows/`.

For these to work properly and integrate with Slack, we
need to have a secret defined as follows:

- Name: `SLACK_WEBHOOK_URL`
- Value: The actual webhook url

See:  https://docs.github.com/en/actions/security-guides/encrypted-secrets
