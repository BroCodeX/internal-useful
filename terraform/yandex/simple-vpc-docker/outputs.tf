output "external_ip" {
  description = "An external ip of the instance"
  value = yandex_compute_instance.this.network_interface[0].nat_ip_address
}

output "boot_disk_id" {
  description = "The ID of the boot disk created for the instance."
  value       = yandex_compute_disk.boot_disk.id
}

output "instance_id" {
  description = "The ID of the Yandex Compute instance."
  value       = yandex_compute_instance.this.id
}
