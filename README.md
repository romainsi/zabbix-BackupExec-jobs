**================Zabbix-Symantec-Backup-Exec ================**

Work with Symantec Backup Exec V2012 minimum !

This template use PowerShell Cmdlets to discover backup job Symantec Backup Exec

Default French translation for Template.

**-------- Items --------**

  - Check Service Backup Exec Agent Browser
  - Check Service Service Backup Exec Device & Media
  - Check Service	Service Backup Exec Job Engine
  - Check Service Backup Exec Management Service

**-------- Triggers --------**

  - X4 : [HIGH] => For all services Stop

**-------- Discovery --------**

  - Last launch of each task
  - End of each task
  - Result of each task
  - Backup type of each task

**-------- Discovery Triggers --------**

[HIGH] => Job has FAILED <br>
[AVERAGE] => Job has completed with warning<br>
[MEDIUM] => No data recovery for 24 hours<br>


**-------- Setup --------**

1. Install the Zabbix agent on your host
2. Copy zabbix_sbr_job.ps1 in the directory : "C:\Program Files\Zabbix Agent\scripts" (create folder if not exist)
3. Add the following line to your Zabbix agent configuration file.<br>
EnableRemoteCommands=1 <br>
UnsafeUserParameters=1 <br>
UserParameter=sbr[*],powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent\scripts\zabbix_sbr_job.ps1" "$1" "$2"
4. Import TemplateSymantecBackupExec.xml file into Zabbix.
5. Associate "Template VEEAM-BACKUP trapper" to the host.
