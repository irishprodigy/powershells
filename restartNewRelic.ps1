#$siteName = default_Site
#$resourceName = Default-Web-EastUS

Select-AzureRmProfile -Path "C:\Azure\profile.json"

$webApp = Get-AzureRmWebApp -Name default_Site -ResourceGroupName Default-Web-EastUS

$appSettings = $webApp.SiteConfig.AppSettings

$hash = @{}
ForEach ($kvp in $appSettings){
     
    $hash[$kvp.Name] = $kvp.Value
    
    $name = $kvp.Name.ToString()
    Write-Host "Name:  $name"
    Write-Host ""

    $value = $kvp.Value.ToString()
    Write-Host "Value:  $value"
    Write-Host ""
}

$newRelic = $hash.COR_ENABLE_PROFILING.toString()
Write-Host "Current profile setting:  $newRelic"

$hash.COR_ENABLE_PROFILING = 0
$newRelicUpdate = $hash.COR_ENABLE_PROFILING.toString()

Write-Host ""
Write-Host "Updated profile setting:  $newRelicUpdate"

Set-AzureRmWebAppSlot -ResourceGroupName Default-Web-EastUS -Name default_Site -AppSettings $hash -Slot Production

#Checking app Settings
Write-Host "Checking app settings: "
Write-Host ""
$webAppCheck = Get-AzureRmWebApp -Name default_Site -ResourceGroupName Default-Web-EastUS

$appSettingsCheck = $webAppCheck.SiteConfig.AppSettings

$hashCheck = @{}
ForEach ($a in $appSettingsCheck){
     
    $hashCheck[$a.Name] = $a.Value
    
    $nameCheck = $a.Name.ToString()
    Write-Host "Name:  $nameCheck"
    Write-Host ""

    $valueCheck = $a.Value.ToString()
    Write-Host "Value:  $valueCheck"
    Write-Host ""
}

Write-Host "Pausing..."
Write-Host ""
Start-Sleep -Seconds 30

$hash.COR_ENABLE_PROFILING = 1
$newRelicUpdate2 = $hash.COR_ENABLE_PROFILING.toString()

Write-Host "COR_ENABLE_PROFILING value now:  $newRelicUpdate2"

Set-AzureRmWebAppSlot -ResourceGroupName Default-Web-EastUS -Name default_Site -AppSettings $hash -Slot Production

#Verifying App Settings
$webAppVerify = Get-AzureRmWebApp -Name default_Site -ResourceGroupName Default-Web-EastUS

$appSettingsVerify = $webAppVerify.SiteConfig.AppSettings

Write-Host "Verifying app settings:"
Write-Host ""

$hashVerify = @{}
ForEach ($b in $appSettingsVerify){
     
    $hashVerify[$b.Name] = $b.Value
    
    $nameVerify = $b.Name.ToString()
    Write-Host "Name:  $nameVerify"
    Write-Host ""

    $valueVerify = $b.Value.ToString()
    Write-Host "Value:  $valueVerify"
    Write-Host ""
}