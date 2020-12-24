# Configure the settings to use to setup this Jenkins Executor
$Port = 80

# Disable requiring reason for shutdown/restart
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Reliability" /v ShutDownReasonOn /t REG_DWORD /d 0 /f

Install-WindowsFeature -Name NET-Framework-Core

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

#choco install jdk8 -y
choco install Jenkins -y
choco install git -y
choco install visualstudio2019buildtools --package-parameters "--allWorkloads --includeRecommended --includeOptional --passive --locale en-US" -y

# Set the port Jenkins uses
$Config = Get-Content `
  -Path "${ENV:ProgramFiles(x86)}\Jenkins\Jenkins.xml";
$NewConfig = $Config `
  -replace '--httpPort=[0-9]*\s',"--httpPort=$($Port) ";
$NewConfig = $NewConfig `
  -replace '<env name="JENKINS_HOME" value="(.*?)"/>', '<env name="JENKINS_HOME" value="C:\.jenkins\"/>';
Set-Content `
  -Path "${ENV:ProgramFiles(x86)}\Jenkins\Jenkins.xml" `
  -Value $NewConfig `
  -Force
Restart-Service `
  -Name Jenkins

# Output password to vagrant console.
$Password = Get-Content -Path "C:\.jenkins\secrets\initialAdminPassword";
Write-Output "The installation password is: $($Password)"
