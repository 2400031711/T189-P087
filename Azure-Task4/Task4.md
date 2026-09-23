# Task 4 - Azure Networking and DNS

## 1. Create and Configure Virtual Network
- VNet Name: Task4-VNet
- Address Space: 10.0.0.0/16
- Subnet: Task4-Subnet
- Subnet Range: 10.0.1.0/24
- Location: Central India

## 2. Deploy Virtual Machine
VM deployment was attempted using Azure PowerShell.
The deployment could not be completed because the selected VM sizes were unavailable in Central India for the Azure for Students subscription.

## 3. Configure Private and Public IP
- NIC: Task4-NIC
- Private IP: 10.0.1.4
- Public IP: 20.235.77.118
- Public IP Allocation: Static

## 4. Configure Network Security Group
- NSG: Task4-NSG
- Rule: Allow-SSH
- Protocol: TCP
- Direction: Inbound
- Port: 22
- Priority: 100

## 5. Configure Azure DNS for Internal Name Resolution
- Private DNS Zone: task4.internal
- VNet Link: Task4-VNet-Link
- DNS Record: task4-vm.task4.internal
- Private IP: 10.0.1.4

## 6. Configure Azure DNS for External Name Resolution
- Public DNS Zone: task4lab.com
- DNS Record: task4-vm.task4lab.com
- Public IP: 20.235.77.118
- Provisioning State: Succeeded

## Result
The Azure Virtual Network, subnet, NIC, public and private IP configuration,
NSG, internal DNS, and external DNS were successfully configured.
VM deployment was blocked by Azure subscription VM SKU availability in Central India.
