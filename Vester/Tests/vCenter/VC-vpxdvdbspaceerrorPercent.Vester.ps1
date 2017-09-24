# Test file for the Vester module - https://github.com/WahlNetwork/Vester
# Called via Invoke-Pester VesterTemplate.Tests.ps1

# Test title, e.g. 'DNS Servers'
$Title = 'vpxd.vdb.space.errorPercent'

# Test description: How New-VesterConfig explains this value to the user
$Description = 'The used database space that triggers an error event'

# The config entry stating the desired values
$Desired = $cfg.vcenter.vpxdvdbspaceerrorPercent

# The test value's data type, to help with conversion: bool/string/int
$Type = 'Int32'

# The command(s) to pull the actual value for comparison
# $Object will scope to the folder this test is in (Cluster, Host, etc.)
[ScriptBlock]$Actual = {
    (Get-AdvancedSetting -Entity $Object -Name "vpxd.vdb.space.errorPercent").Value
}

# The command(s) to match the environment to the config
# Use $Object to help filter, and  to set the correct value
[ScriptBlock]$Fix = {
    Get-AdvancedSetting -Entity $Object -Name "vpxd.vdb.space.errorPercent" |
        Set-AdvancedSetting -value $Desired -Confirm:$false -ErrorAction Stop
}
