## v1.0.18

- Bug fix: Add sudo permision to check timestamp on.
- Do not run dist-ossec-keys.sh on chef run (in server mode). It caused chef run to be far to long.

## v1.0.17

- Add ossecd to sudoer's group
- Standardize when a node is not added to OSSEC
- Fix SSH command used to restart OSSEC 
- Run dist-ossec-keys.sh on chef run (in server mode)

## v1.0.16

- Remove service start. Use notifications to start it.
- Add agents before cron job is created.

## v1.0.15

- When keys are distributed by server, restart the ossec agent service.
- Remove call to add_agent in client mode.
- Add Kitchen suit for agent only.
- Update Berkshelf to use new supermarket URL.

## v.1.0.14

### Bug 

- Don't attempt to start service if client.keys is empty

## v1.0.13

### Bug

- Fix search string to use `NOT` vs `AND NOT`.

## v1.0.5

### Bug

- Avoid node.save to prevent incomplete attribute collections
- `dist-ossec-keys.sh` should be sorted for idempotency

### Improvement

- Ability to disable ossec configuration template
- Support for encrypted databags
- Support for environment-scoped searches
- Support for multiple email_to addresses

## v1.0.4

### Bug

- [COOK-2740]: Use FQDN for a client name

### Improvement

- [COOK-2739]: Upgrade OSSEC to version 2.7

## v1.0.2:

* [COOK-1394] - update ossec to version 2.6

## v1.0.0:

* Initial/current release
