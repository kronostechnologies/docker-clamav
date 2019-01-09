ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.

## Build and Run
```
docker build -t kronostechnologies/clamav .
docker run --rm --name clamav kronostechnologies/clamav
```

## Environment variable
### CLAMD_CONF
If defined, overwrite `/etc/clamav/clamd.conf`

### FRESHCLAM_CONF
If defined, overwrite `/etc/clamav/freshclam.conf`

## Example
### Docker-compose
Below is an example using two environment variable to overwrite content of `/etc/clamav/clamd.conf` and `/etc/clamav/freshclam.conf`
```
clamav:
  image: kronostechnologies/clamav
  restart: always
  environment:
    CLAMD_CONF: |
      StreamMaxLength 256M
      TCPSocket 3310
      Foreground true
    FRESHCLAM_CONF: |
      DatabaseOwner clamav
      UpdateLogFile /var/log/clamav/freshclam.log
      LogVerbose false
      LogSyslog false
      LogFacility LOG_LOCAL6
      LogFileMaxSize 0
      LogRotate true
      LogTime true
      Foreground false
      Debug false
      MaxAttempts 5
      DatabaseDirectory /var/lib/clamav
      DNSDatabaseInfo current.cvd.clamav.net
      PidFile /var/run/clamav/freshclam.pid
      ConnectTimeout 15
      ReceiveTimeout 30
      TestDatabases yes
      ScriptedUpdates yes
      CompressLocalDatabase no
      Bytecode true
      Checks 24
      DatabaseMirror db.us.clamav.net
      DatabaseMirror database.clamav.net
```
