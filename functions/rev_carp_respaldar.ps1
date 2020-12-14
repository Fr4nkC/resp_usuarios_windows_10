<# 
.SYNOPSIS
    Funcion para listar los usuarios y capetas a respaldar.

.DESCRIPTION

.INPUTS
    Requiere del HostName
    Requiere del ID inicial que establece el script index.ps1
    Requiere del $directorio_inicial declarado en index.ps1
    Requiere del $directorios_omitir declarado en index.ps1

.OUTPUTS
    Array de las carpetas de usuario
    Array de las sub-carpetas de cada usuario

.EXAMPLE

.LINK
https://github.com/Fr4nkC/resp_usuarios_windows_10

.NOTES
    Author: Fr4nkC.
    Version 1.0.0
#>

function rev_carp_respaldar{

    Param(
    [String]$HostName,
    [String]$ID,
    [String]$directorio_inicial,
    [String]$directorios_omitir
    )

    $omitir = $directorios_omitir.split(" ")


    #
    # // Mostrar en Menú las carpetas de usuarios a respaldar y las sub-carpetas
    #
     
     $carp_usuarios = Get-ChildItem -Path $directorio_inicial | ForEach-Object {$_.Name} 

        Write-Host ""
        Foreach($elemento in $carp_usuarios){
        Write-Host ""
        Write-Host "*----------------*" -ForegroundColor Green
        Write-Host "| $elemento " -ForegroundColor Green
        Write-Host "*----------------*" -ForegroundColor Green



                $sub_carpetas_usuario = Get-ChildItem "$directorio_inicial\$elemento" | ForEach-Object {$_.Name}
                
                Foreach($element in $sub_carpetas_usuario){
                    
                    if($omitir -contains $element ){
                    Write-Host "     ├─── Omitir: $element" -ForegroundColor Darkred 
                    }else{
                    Write-Host "     ├─── Respaldar: $element" -ForegroundColor DarkGreen 
                    }
                }
                    Write-Host "     └───|" -ForegroundColor DarkGray
        }
        

}