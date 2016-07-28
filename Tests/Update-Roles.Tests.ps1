#requires -Modules Pester
#requires -Modules VMware.VimAutomation.Core


[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true,Position = 0,HelpMessage = 'Remediation toggle')]
    [ValidateNotNullorEmpty()]
    [switch]$Remediate,
    [Parameter(Mandatory = $true,Position = 1,HelpMessage = 'Path to the configuration file')]
    [ValidateNotNullorEmpty()]
    [string]$Config
)

Process {
    # Variables
    Invoke-Expression -Command (Get-Item -Path $Config)
    $virolescommand = $global:config.roles.vcenterrolespath +"\Import-VIRole.ps1"
    #Source Import-VIRole stuff
    . $virolescommand 
    # Tests
    Describe -Name "vCenter Roles and Privs" -Fixture {

        foreach ( $role in $global:config.Roles.rolesPresent.keys){
            BeforeEach{
                if ($global:config.roles.rolesPresent[$role].split("\").Count -gt 1) {
                    $roleFile = $global:config.roles.rolesPresent[$role]
                } else {
                   $roleFile = $global:config.roles.defaultRoleFilePath + "\" + $global:config.roles.rolesPresent[$role]
                }
               
                Test-Path $roleFile

                $roleinfo = Get-VIRole -name $role -ErrorAction SilentlyContinue    
                #Get vCenter name since we use it a few times
                $vcname = $global:config.vcenter.vc            
            }

            It -name "vCenter Role $Role is present" -test {
             #  $roleinfo = Get-VIRole -name $role -ErrorAction SilentlyContinue 
               try{
                    $roleinfo | should not BeNullOrEmpty
               } catch { 
                    if ($Remediate) { 
                        Write-Warning -Message $_
                        Write-Warning -Message "Remediating $Role"
                        Import-VIRole -Name $role -Permission $roleFile  -vCenter $vcname
                    } else {
                        throw $_
                    }
               }
            }
            It -name "vCenter Role $Role Privs correct" -test {
            #    $roleInfo = Get-VIRole -name $Role
                try {
                    $privList = $RoleInfo.PrivilegeList
                    $refRoleInfo = Get-Content -Path ($roleFile) | ConvertFrom-Json
                    $refPrivList = $RefRoleInfo.Privileges
                    Compare-Object -ReferenceObject $refPrivList -DifferenceObject $privList | Should Be $Null
                } catch {
                    if ($Remediate) {
                            Write-Warning -Message $_
                            Write-Warning -Message "Remediating $Role Privileges"
                            Import-VIRole -Name $role -Permission $roleFile -vCenter $vcname -OverWrite:$true
                    } else {
                        throw $_
                       
                    }
                }
                
                
            }
        }
    }
}
      