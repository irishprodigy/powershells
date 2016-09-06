#Login to Azure
Login-AzureRmAccount

#path-to-file like C:\Azure\profile.json
Save-AzureRmProfile -Path <path-to-file>

#open those creds
Select-AzureRmProfile -Path <path-to-file>

#Need better solution, seems to expire every month or so.