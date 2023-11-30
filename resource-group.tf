resource "azurerm_resource_group" "Harshini-Training" {
  name     = "Harshini-Training"
  location = "Australia East"
  tags = {
    owner   = "harshini.rajagopal@servian.com"
    purpose = "Training"
    client  = "Servian"
  }
}


resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Harshini-Training.location
  resource_group_name = azurerm_resource_group.Harshini-Training.name
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.Harshini-Training.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.Harshini-Training.location
  resource_group_name = azurerm_resource_group.Harshini-Training.name

  security_rule {
    name                       = "AllowInboundTraffic"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "22" # Adjust this port to your needs
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.Harshini-Training.location
  resource_group_name = azurerm_resource_group.Harshini-Training.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "example" {
  name                  = "example-vm"
  location              = azurerm_resource_group.Harshini-Training.location
  resource_group_name   = azurerm_resource_group.Harshini-Training.name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = "Standard_D2s_v3"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name              = "example-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
}
# resource "azurerm_static_site" "example" {
#   name                = "example-static-app"
#   resource_group_name = azurerm_resource_group.Harshini-Training.name
#   location            = "South East Asia"
# }