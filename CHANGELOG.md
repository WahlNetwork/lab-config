# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).



## [1.1.0] - 2017-06-15
I learned that we need to publish releases far more often. :)

### Added
- New scope for datastore clusters: "DSCluster"
- New [DSCluster tests](https://github.com/WahlNetwork/Vester/tree/0a8b87807e60606fe3006a65bbb429958a122d34/Vester/Tests/DSCluster):
  - AutoOverride-IoLoadBalance
  - AutoOverride-PolicyEnforcement
  - AutoOverride-RuleEnforcement
  - AutoOverride-SpaceLoadBalance
  - AutoOverride-VmEvacuation
  - IO-Latency
  - IO-LoadImbalanceThreshold
  - IO-ResIopsThreshold
  - IO-ResPercentThreshold
  - IO-ResThresholdMode
  - IOLoadBalance
  - LoadBalance-Interval
  - SDRS-AutomationLevel
  - SDRS-DefaultVMAffinity
  - Space-FreespaceTheshold
  - Space-ThresholdMode
  - Space-UtilDiffMin
  - SpaceUtilPercent
- Some new tests were written, and others were ported from the old test format (prior to Vester 1.0's module life)
- New [vCenter tests](https://github.com/WahlNetwork/Vester/tree/0a8b87807e60606fe3006a65bbb429958a122d34/Vester/Tests/vCenter):
  - SMTP-Sender
  - SMTP-Server
  - VC-EventMaxAge
  - VC-EventMaxAgeEnabled
  - VC-TaskMaxAge
  - VC-TaskMaxAgeEnabled
- New [ESXi Host tests](https://github.com/WahlNetwork/Vester/tree/0a8b87807e60606fe3006a65bbb429958a122d34/Vester/Tests/Host):
  - Advanced-Kernel-iovDisableIR
  - BPDU-Filter
  - Disk-MaxLUN
  - ESXAdmins
  - NetDump-Settings
  - NetDump-SettingsEnable
  - NTP-Service
  - NTP-Service-Policy
  - SSH-Service-Policy
- New [VM tests](https://github.com/WahlNetwork/Vester/tree/0a8b87807e60606fe3006a65bbb429958a122d34/Vester/Tests/VM):
  - Boot-Delay
  - CPU-Reservation
  - Isolation-DeviceConnectable
  - Isolation-DeviceEdit
  - Memory-Reservation
  - RemoteConsole-VNC
  - Snapshot-Retention
  - Sync-TimeSettings
  - Tools-HostInfoAccess
  - Tools-SetInfo-SizeLimit
- New [VDS Network tests](https://github.com/WahlNetwork/Vester/tree/0a8b87807e60606fe3006a65bbb429958a122d34/Vester/Tests/Network):
  - VDS-LinkOperation
  - VDS-MTUsize
  - VDS-Teaming-HealthCheck
  - VDS-VlanMTU-HealthCheck

### Changed
- #114/#115: `Invoke-Vester` is **more than twice as fast** now! We removed repeated `Get` calls within private file `VesterTemplate.Tests.ps1`. Big thanks to @Midacts/@jpsider/@jonneedham for collaborating on this.
- #118/#119: `Config.json` files now sort their settings within each scope.

### Fixed
- #90: `Invoke-Vester -Test $TestList` should execute all tests in the array, instead of just the final one after ignoring the rest. Now they do again.
- #99: Re-implemented `-PassThru` on `Invoke-Vester`.
- #116/#129: The name of the active vCenter connection was not being reported properly.
- #154: Network test VDS-MTUsize had an incorrect parameter.
- Cleaned up VM test files:
  - Tools-DiskWiperDisable
  - Tools-HGFS-ServerDisable

### Much :heart:
[@jeffgreenca](https://github.com/jeffgreenca) [@haberstrohr](https://github.com/haberstrohr) [@jonneedham](https://github.com/jonneedham) [@Midacts](https://github.com/Midacts) [@jpsider](https://github.com/jpsider) [@Factorization](https://github.com/Factorization)


## [1.0.1] - 2017-02-28
Initial availability as a PowerShell module


## [1.0.0] - 2016-11-10 [YANKED]
Published just to reserve the name on the PowerShell Gallery. If you have this version, please update!
