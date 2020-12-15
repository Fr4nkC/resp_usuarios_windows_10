<#
.SYNOPSIS

.DESCRIPTION

.OUTPUTS
*--------------------------*
| resp_usuarios_windows_10 | 
*--------------------------*
    |
    ├───Index.ps1 ---------------------------------------------> (Archivo principal)
    |
    ├───functions ---------------------------------------------> (CArpeta de Funciones)
    |       |
    │       ├───iniciar_respaldo.ps1 --------------------------> (Función Inicia respaldo)
    │       │   
    │       └───rev_carp_respaldar.ps1 ------------------------> (Revisa respaldo)
    │       │   
    │       └───verificar_respaldo.ps1 ------------------------> (Verificar Respaldo)
    │       │   
    │       └───menu.ps1
    |
    ├───integrity
    |
    ├───log ---------------------------------------------------> (Archivo de errores)
    |
    └───result_respaldos ---------------------------------------------------> (Alemacenan respaldos)

.NOTES
    Author: Fr4nkC
    Requisito: PowerShell Versión 3 o superior.
    
.LINK 
    https://github.com/Fr4nkC
    Version: 1.0.0
     
#>


## ---- Incluir funciones
. './functions/menu.ps1'
. './functions/rev_carp_respaldar.ps1'
. './functions/iniciar_respaldo.ps1'
. './functions/verificar_respaldo.ps1'

## ---- Generar ID de la actividad basado en la fecha de ejecución
$ID = Get-Date -UFormat "%d%m%Y%T"
$ID = $ID -replace '[\:]', '-'    

## ---- Versión del Sistema Operativo.
$ArrayVersionSO = (Get-WmiObject -class Win32_OperatingSystem).Caption | ForEach-Object{($_ -split " ")}

$Hostname = Hostname

$directorio_inicial = 'C:\Users\'

$directorios_omitir = @('.android','.config','.dia','.dotnet','.templateengine','.vscode','3D Objects','ansel','Contacts','Dropbox','Favorites','Intel','Links','OneDrive','Saved Games','Searches','Foxit Software','*.url')

$directorio_respaldo = 'result_respaldos'

## ---- Modo de compatibilidad basado en la versión del Sistema Operativo.
foreach ($pice in $ArrayVersionSO)
{
 
    # Server's
    #if($pice -eq '2019'){
    #$CompatibilityModeSO = '2019'
    #}

    #if($pice -eq '2016'){
    #$CompatibilityModeSO = '2016'
    #}

    # Desktop's
    if($pice -eq '10'){
    $CompatibilityModeSO = '10'
    }

}
pause
## ---- Determinar si el script es compatible con el Sistema Operativo.
if($CompatibilityModeSO){

    do
    {
        ## ---- Limpiar pantalla
        Clear-Host
        
        ## ---- Mostrar Menú
        menu $ID $CompatibilityModeSO

        ## ---- Ejecuciones de acuerdo al Menú
        $opcion = Read-Host "Opción:"
        switch ($opcion)
        {
                 '1' {
                    rev_carp_respaldar $Hostname $ID $directorio_inicial $directorios_omitir $directorio_respaldo
               } '2' {
                    iniciar_respaldo $Hostname $ID $directorio_inicial $directorios_omitir $directorio_respaldo
               } '3' {
                    verificar_respaldo $Hostname $ID $directorio_inicial $directorios_omitir $directorio_respaldo
               } 'q' {
                    ## ---- Crear respaldo después de la actividad.
               }

         }
         pause

    }
    until ($opcion -eq 'q')

}else{
    Write-Host "El Script no es compatible con este Sistema Operativo."
}