function menu {

    Param(
    [String]$ID,
    [String]$CompatibilityModeSO
    )

## ---- Obtener datos para el Menú.

    ## ---- Versión del Sistema Operativo.
    $versionSO = (Get-WmiObject -class Win32_OperatingSystem).Caption

    ## ---- Nombre del servidor.
    $HostName = Hostname

    ## ---- Fecha actual.
    $Fecha = Get-Date -Format "dd/MM/yyyy"

    ## ---- IP.
    $Ip = Get-NetIPAddress | Select -expandproperty IPAddress
    $Ip = $Ip -match '(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])' | Select-String -Pattern '127.0.0.1' -NotMatch
    
## ----  Mostrar Menú.

Write-Host "*--------------------------------------------------------------------------------*"
Write-Host "* Fecha: $Fecha"
Write-Host "* Nombre del servidor: $HostName"
Write-Host "* IP: $Ip"
Write-Host "* Sistema Operativo detectado: $versionSO"
Write-Host "* Modo de compatibilidad: $CompatibilityModeSO"
Write-Host "* ID para esta ejecución: $ID"
Write-Host "*--------------------------------------------------------------------------------*"
Write-Host "* 1.- Revisar ..."
Write-Host "* 2.- Aplicar ..."
Write-Host "* 3.- Realizar ..."
Write-Host "* q.- Salir"
Write-Host ""
        
}