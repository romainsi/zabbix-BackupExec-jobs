# Script: zabbix_sbr_job
# Author: Romainsi
# Description: Query Symantec job information
# 
# This script is intended for use with Zabbix > 3.X
#
# USAGE:
#   as a script:    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent\scripts\zabbix_sbr_job.ps1" <ITEM_TO_QUERY> <JOBID>"
#   as an item:     sbr[<ITEM_TO_QUERY>,<JOBID>]
#
# Add to Zabbix Agent
#   UserParameter=sbr[*],powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\Zabbix Agent\scripts\zabbix_sbr_job.ps1" "$1" "$2"

Function Convert-ToUnixDate ($PSdate) {
   $epoch = [timezone]::CurrentTimeZone.ToLocalTime([datetime]'1/1/1970')
   (New-TimeSpan -Start $epoch -End $PSdate).TotalSeconds
}

Import-Module BEMCLI

$ITEM = [string]$args[0]
$ID = [string]$args[1]

switch ($ITEM) {
  "DiscoverTasks" {
$apptasks = Get-BEJob -Jobtype Backup -Status Active
if (!$apptasks) {$apptasks = Get-BEJob -Jobtype Backup -Status Scheduled}
$apptasksok1 = $apptasks.Name
$apptasksok = $apptasksok1.replace('â','&acirc;').replace('à','&agrave;').replace('ç','&ccedil;').replace('é','&eacute;').replace('è','&egrave;').replace('ê','&ecirc;')
$idx = 1
write-host "{"
write-host " `"data`":[`n"
foreach ($currentapptasks in $apptasksok)
{
    if ($idx -lt $apptasksok.count)
    {
     
        $line= "{ `"{#SYMANTECBACKUP}`" : `"" + $currentapptasks + "`" },"
        write-host $line
    }
    elseif ($idx -ge $apptasksok.count)
    {
    $line= "{ `"{#SYMANTECBACKUP}`" : `"" + $currentapptasks + "`" }"
    write-host $line
    }
    $idx++;
} 
write-host
write-host " ]"
write-host "}"}}


switch ($ITEM) {
  "TaskLastResult" {
[string] $name = $ID
$name1 = $name.replace('&acirc;','â').replace('&agrave;','à').replace('&ccedil;','ç').replace('&eacute;','é').replace('&egrave;','è').replace('&ecirc;','ê')
$nametask = Get-BEJobHistory -Name "$name1" -JobType "Backup"| Select -last 1
$nametask1 = $nametask.JobStatus
$nametask2 = "$nametask1".replace('Error','0').replace('Failed','0').replace('Warning','1').replace('Succeeded','2').replace('None','2').replace('idle','3').Replace('Canceled','4')
Write-Output ($nametask2)
}}

switch ($ITEM) {
  "TaskLastRunTime" {
[string] $name = $ID
$name1 = $name.replace('&acirc;','â').replace('&agrave;','à').replace('&ccedil;','ç').replace('&eacute;','é').replace('&egrave;','è').replace('&ecirc;','ê')
$nametask = Get-BEJobHistory -Name "$name1" -JobType "Backup"| Select -last 1
$taskResult = $nametask.StartTime
$date = get-date -date "01/01/1970"
$taskResult1 = (New-TimeSpan -Start $date -end $taskresult).TotalSeconds
Write-Output ($taskResult1)
}}

switch ($ITEM) {
  "TaskEndRunTime" {
[string] $name = $ID
$name1 = $name.replace('&acirc;','â').replace('&agrave;','à').replace('&ccedil;','ç').replace('&eacute;','é').replace('&egrave;','è').replace('&ecirc;','ê')
$nametask = Get-BEJobHistory -Name "$name1" -JobType "Backup"| Select -last 1
$taskResult = $nametask.EndTime
$date = get-date -date "01/01/1970"
$taskResult1 = (New-TimeSpan -Start $date -end $taskresult).TotalSeconds
Write-Output ($taskResult1)
}}

switch ($ITEM) {
  "TaskType" {
[string] $name = $ID
$name1 = $name.replace('&acirc;','â').replace('&agrave;','à').replace('&ccedil;','ç').replace('&eacute;','é').replace('&egrave;','è').replace('&ecirc;','ê')
$nametask = Get-BEJob -Name "$name1"
$nametask1 = $nametask.Storage.StorageType
Write-Output ($nametask1)
}}
