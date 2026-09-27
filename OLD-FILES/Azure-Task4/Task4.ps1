# Task 4 - Azure Networking and DNS

# 1. Create Virtual Network
Microsoft.Azure.Commands.Network.Models.PSVirtualNetwork = New-AzVirtualNetwork 
    -ResourceGroupName "Task3-Move-RG" 
    -Location "centralindia" 
    -Name "Task4-VNet" 
    -AddressPrefix "10.0.0.0/16"

Add-AzVirtualNetworkSubnetConfig 
    -Name "Task4-Subnet" 
    -AddressPrefix "10.0.1.0/24" 
    -VirtualNetwork Microsoft.Azure.Commands.Network.Models.PSVirtualNetwork

Microsoft.Azure.Commands.Network.Models.PSVirtualNetwork | Set-AzVirtualNetwork

# 2. Network Security Group
Microsoft.Azure.Commands.Network.Models.PSNetworkSecurityGroup = New-AzNetworkSecurityGroup 
    -ResourceGroupName "Task3-Move-RG" 
    -Location "centralindia" 
    -Name "Task4-NSG"

Microsoft.Azure.Commands.Network.Models.PSSecurityRule = New-AzNetworkSecurityRuleConfig 
    -Name "Allow-SSH" 
    -Access Allow 
    -Protocol Tcp 
    -Direction Inbound 
    -Priority 100 
    -SourceAddressPrefix "*" 
    -SourcePortRange "*" 
    -DestinationAddressPrefix "*" 
    -DestinationPortRange 22

Microsoft.Azure.Commands.Network.Models.PSNetworkSecurityGroup.SecurityRules.Add(Microsoft.Azure.Commands.Network.Models.PSSecurityRule)
Microsoft.Azure.Commands.Network.Models.PSNetworkSecurityGroup | Set-AzNetworkSecurityGroup

# 3. Public IP
Microsoft.Azure.Commands.Network.Models.PSPublicIpAddress = New-AzPublicIpAddress 
    -ResourceGroupName "Task3-Move-RG" 
    -Location "centralindia" 
    -Name "Task4-PublicIP" 
    -AllocationMethod Static 
    -Sku Standard

# 4. NIC
Microsoft.Azure.Commands.Network.Models.PSVirtualNetwork = Get-AzVirtualNetwork 
    -ResourceGroupName "Task3-Move-RG" 
    -Name "Task4-VNet"

Microsoft.Azure.Commands.Network.Models.PSSubnet = Get-AzVirtualNetworkSubnetConfig 
    -Name "Task4-Subnet" 
    -VirtualNetwork Microsoft.Azure.Commands.Network.Models.PSVirtualNetwork

Microsoft.Azure.Commands.Network.Models.PSNetworkInterface = New-AzNetworkInterface 
    -ResourceGroupName "Task3-Move-RG" 
    -Location "centralindia" 
    -Name "Task4-NIC" 
    -SubnetId Microsoft.Azure.Commands.Network.Models.PSSubnet.Id 
    -PublicIpAddressId Microsoft.Azure.Commands.Network.Models.PSPublicIpAddress.Id 
    -NetworkSecurityGroupId Microsoft.Azure.Commands.Network.Models.PSNetworkSecurityGroup.Id

# 5. Private DNS Zone
New-AzPrivateDnsZone 
    -ResourceGroupName "Task3-Move-RG" 
    -Name "task4.internal"

# 6. Public DNS Zone
az network dns zone create 
    --resource-group Task3-Move-RG 
    --name task4lab.com

# VM deployment was attempted but was blocked
# because VM SKUs were unavailable for the subscription
# in Central India.
