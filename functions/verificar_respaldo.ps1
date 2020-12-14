<# 
.SYNOPSIS
    Iniciar el respaldo.

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

function verificar_respaldo{

    Param(
    [String]$HostName,
    [String]$ID,
    [String]$directorio_inicial,
    [String]$directorios_omitir,
    [String]$directorio_respaldo
    )

    $omitir = $directorios_omitir.split(" ")

    #
    # // Mostrar Respaldos existentes
    #

    $Respaldo_Actual = Get-ChildItem ./$directorio_respaldo | ForEach-Object {$_.Name}
    Foreach($resp_actNivel_uno in $Respaldo_Actual){
    
        $resp_actNivel_dos = Get-ChildItem "$directorio_respaldo\$resp_actNivel_uno" | ForEach-Object {$_.Name}
        Foreach($resp_actNivel_tres in $resp_actNivel_dos){
            
            $resp_actNivel_cuatro = Get-ChildItem "$directorio_respaldo\$resp_actNivel_uno\$resp_actNivel_tres" | ForEach-Object {$_.Name}
            Foreach($resp_actNivel_cinco in $resp_actNivel_cuatro){
            
                if($ruta_respaldada -contains $resp_actNivel_cinco){
                
                }else{
                
                
                }
                
                Write-Host ""
                Write-Host ""
                Write-Host $resp_actNivel_cinco

            }

        }

    }

    <#
    Write-Host ""
    Write-Host ""
    Write-Host $Respaldo_Actual
    
    $resp_nivel_uno = Get-ChildItem -Path $Respaldo_Actual | ForEach-Object {$_.Name}
    Write-Host $Respaldo_Actual\




    $carp_usuarios = Get-ChildItem -Path $directorio_inicial | ForEach-Object {$_.Name} 
    Foreach($elemento in $carp_usuarios){
        
                $sub_carpetas_usuario = Get-ChildItem "$directorio_inicial\$elemento" | ForEach-Object {$_.Name}
                Foreach($element in $sub_carpetas_usuario){
                    
                    if($omitir -contains $element ){
                    
                    }else{
                    
                    $origen  = $directorio_inicial+'\'+$elemento+"\"+$element
                    $destino = $directorio_respaldo+'\'+$HostName+'\'+$elemento+"_"+$ID+"\"+$element
                    
                    # Comprimir
                    $subsub_carpetas_usuario = Get-ChildItem $origen | ForEach-Object {$_.Name}

                        Foreach($activo in $subsub_carpetas_usuario){
                        
                        #$actico_origen = $origen+"\"+$activo
                        #$activo_comprimido = $destino+'\'+$activo
                        #Compress-Archive -Path $actico_origen -DestinationPath ./$activo_comprimido.zip
                        
                        

                        }
                    }
                }
    }#>

}