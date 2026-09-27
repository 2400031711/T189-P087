# Task 1 - Create and Configure Azure Managed Disk

# Resource Group
# Existing resource group: MyResourceGroup
# Location: East US

# Configure Managed Disk
$diskConfig = New-AzDiskConfig `
    -Location "Central India" `
    -CreateOption Empty `
    -DiskSizeGB 32 `
    -SkuName Standard_LRS

# Create Managed Disk
New-AzDisk `
    -ResourceGroupName "MyResourceGroup" `
    -DiskName "MyManagedDisk" `
    -Disk $diskConfig

# Verify Managed Disk
Get-AzDisk -ResourceGroupName "MyResourceGroup"