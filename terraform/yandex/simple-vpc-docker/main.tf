locals {
  boot_disk_name = var.boot_disk_name != null ? var.boot_disk_name : "${var.name_prefix}-boot-disk"
  vm_name        = var.vm_name != null ? var.vm_name : "${var.name_prefix}-vm"
  vpc_network_name = var.vpc_network_name != null ? var.vpc_network_name : "${var.name_prefix}-private"
}

# Создание VPC и подсети
resource "yandex_vpc_network" "this" {
  name = "${var.name_prefix}-private"
}

resource "yandex_vpc_subnet" "private" {
  name           = local.vpc_network_name
  zone           = var.zone
  v4_cidr_blocks = var.subnets[keys(var.subnets)[0]]
  network_id     = yandex_vpc_network.this.id
}

# Создание диска и виртуальной машины
resource "yandex_compute_disk" "boot_disk" {
  name     = local.boot_disk_name
  zone     = var.zone
  image_id = var.image_id

  type = var.instance_resources.disk.disk_type
  size = var.instance_resources.disk.disk_size
}

resource "yandex_compute_instance" "this" {
  name                      = local.vm_name
  allow_stopping_for_update = true
  platform_id               = var.instance_resources.platform_id
  zone                      = var.zone

  resources {
    cores  = var.instance_resources.cores
    memory = var.instance_resources.memory
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot_disk.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
  }
}
