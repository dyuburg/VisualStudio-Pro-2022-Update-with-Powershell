# VisualStudio-Pro-2022-Update-with-Powershell
Dedicated for updating VS Pro 2022 through the PS using MS bootstrapper. 
Creates a folder c:\temp\VSUpdate
If it has vs_Professional.exe already, then script will check the hash of the file with the hash in MS site. If no update folder or file found, then the script will download it and update VS automatically.
