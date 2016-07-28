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
    [array]$mandatorytagcategory = $global:config.vm.mandatorytagcategory

    Describe -Name 'VM Configuration: Mandatory Tag Category' -Fixture {
        foreach ($VM in (Get-VM -Name $global:config.scope.vm)) 
        {                
            foreach ($category in $mandatorytagcategory) {
                It -name "$($VM.name) has a tag assigned from the category $category" -test {
                    [array]$value = $VM | 
                    Get-TagAssignment | 
                    Where-Object {$_.Tag.Category -match $category}

                    $value.count | Should BeGreaterThan 0
                }   
            }
        }
    }
}   
