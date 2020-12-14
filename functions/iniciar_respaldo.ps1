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

function iniciar_respaldo{

    Param(
    [String]$HostName,
    [String]$ID,
    [String]$directorio_inicial,
    [String]$directorios_omitir,
    [String]$directorio_respaldo
    )

    $omitir = $directorios_omitir.split(" ")


    #
    # // Crear carpetas de respaldo con el nombre del Equipo
    #
    mkdir ./"$directorio_respaldo\$HostName"

    #
    # // Crear carpetas de respaldo
    #
    $carp_usuarios = Get-ChildItem -Path $directorio_inicial | ForEach-Object {$_.Name}
    Foreach($elemento in $carp_usuarios){
        $x = $directorio_respaldo+'\'+$HostName+'\'+$elemento+"_"+$ID
        Write-Host ./$x
        New-Item -Path ./$x -ItemType Directory
    }

    
    #
    # // Crear sub-carpetas de usuarios respaldo
    #
    $carp_usuarios = Get-ChildItem -Path $directorio_inicial | ForEach-Object {$_.Name} 
    Foreach($elemento in $carp_usuarios){
        
                $sub_carpetas_usuario = Get-ChildItem "$directorio_inicial\$elemento" | ForEach-Object {$_.Name}
                Foreach($element in $sub_carpetas_usuario){
                    
                    if($omitir -contains $element ){
                    
                    }else{
                    $x = $directorio_respaldo+'\'+$HostName+'\'+$elemento+"_"+$ID+"\"+$element
                    #Write-Host ./$x
                    New-Item -Path ./$x -ItemType Directory
                    }
                }
                    
    }   


    #
    # // Comprimir contenido de las sub-carpetas de los usuarios y alamcenar en la carpeta correspondiente
    #
    
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
                        $actico_origen = $origen+"\"+$activo
                        $activo_comprimido = $destino+'\'+$activo
                        Compress-Archive -Path $actico_origen -DestinationPath ./$activo_comprimido.zip
                        #Write-Host $actico_origen
                        #Write-Host $activo_comprimido
                        }
                    }
                }
    }

}