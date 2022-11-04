# 2Add Function Download&Update

$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$Source = “$PSScriptRoot\*"

$Destination = “C:\Temp\VSUpdate\”

if (!(Get-Item -Path "c:\Temp\VSUpdate")) {
    New-Item -Path "c:\" -Name "Temp" -ItemType Directory;
    New-Item -Path "c:\Temp" -Name "VSUpdate" -ItemType Directory; 
    Invoke-WebRequest -Uri $uri -OutFile "C:\temp\VSUpdate\vs_Professional.exe";
    Start-Process -FilePath "vs_Professional.exe" -ArgumentList "updateall --passive --quiet --norestart --installpath 'C:\Program Files\Microsoft Visual Studio\2022\Professional'" -Wait;
}
else {

    # 2Add checking if VS_professional.exe is there
    $myhash = (get-filehash "C:\Temp\VSUpdate\vs_Professional.exe" -Algorithm SHA256).Hash
    $uri = "https://aka.ms/vs/17/release/vs_professional.exe"
    $feeder = Invoke-RestMethod $uri
    $stream = [System.IO.MemoryStream]::new($feeder.ToCharArray())
    $thisFileHash = Get-FileHash -InputStream $stream -Algorithm SHA256
    if ($myhash -eq $thisFileHash.Hash) {
        "All good"
    }
    else {
        "Pulling latest update"
        Invoke-WebRequest -Uri $uri -OutFile "C:\temp\VSUpdate\vs_Professional.exe"
        Start-Process -FilePath "vs_Professional.exe" -ArgumentList "updateall --passive --quiet --norestart --installpath 'C:\Program Files\Microsoft Visual Studio\2022\Professional'" -Wait
    }
}


