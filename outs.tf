output "ids" {
    description = "list of IDs of the created servers"
    value       = ["${opentelekomcloud_lb_loadbalancer_v2.loadbalancer.*.id}"]
}

output "count" {
    description = "number of lbs created"
    value       = "${var.count}"
}

output "instance_count" {
    description = "number of instalces created"
    value       = "${var.instance_count}"
}

