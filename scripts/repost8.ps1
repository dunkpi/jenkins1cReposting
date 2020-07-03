# Скрипт запуска 1С Предприятие и выполнения внешней обработки

# --- Ввод параметров подключения ---
Param (
    [Parameter()][string]$platform1c = '',
    [Parameter()][string]$server1c = '',
    [Parameter()][string]$infobase = '',
    [Parameter()][string]$user = '',
    [Parameter()][string]$passw = '',
    [Parameter()][string]$startDate = '',
    [Parameter()][string]$endDate = '',
    [Parameter()][string]$backupDir = ''
)
# --- Рабочая часть скрипта ---
try {
    $paramString = $startDate + ',' + $endDate + ',' + $backupDir
    $connectionString ='ENTERPRISE /S' + $server1c + '\' + $infobase + ' /N' + $user + ' /P' + $passw + ' /Execute "tools\repost.epf"'
    Write-Host 'paramString = ' $paramString
    Write-Host 'connectionString = ' $connectionString
    Write-Host 'result = ' $platform1c $connectionString $paramString 
    & $platform1c $connectionString $paramString | Out-Null
} catch {
    throw $_.Exception.Message
}