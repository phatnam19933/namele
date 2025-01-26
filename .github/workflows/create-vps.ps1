# Tạo một máy ảo Windows bằng Hyper-V
param (
    [string]$VMName = "MyWindowsVPS",
    [int]$MemoryStartupBytes = 2GB,
    [int]$MaxMemoryBytes = 4GB,
    [string]$VHDPath = "C:\Hyper-V\$VMName.vhdx",
    [string]$ISOPath = "C:\ISO\WindowsServer.iso"
)

# Tạo thư mục nếu chưa tồn tại
New-Item -ItemType Directory -Force -Path (Split-Path $VHDPath)

# Tạo ổ đĩa ảo (VHDX)
New-VHD -Path $VHDPath -SizeBytes 50GB -Dynamic

# Tạo máy ảo
New-VM -Name $VMName -MemoryStartupBytes $MemoryStartupBytes -Generation 2 -NewVHDPath $VHDPath -BootDevice VHD

# Cấu hình bộ nhớ động
Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $true -MaximumBytes $MaxMemoryBytes

# Gắn file ISO
Add-VMDvdDrive -VMName $VMName -Path $ISOPath

# Kết nối mạng (đổi thành switch của bạn)
Connect-VMNetworkAdapter -VMName $VMName -SwitchName "Default Switch"

# Khởi động máy ảo
Start-VM -Name $VMName
