variable "region" {
    description = "the region to create the ECS"
}

variable "az" {
    description = "the availability zone to create the ECS"
}

variable "name" {
    description = "naming prefix for created resources"
}

variable "image_id" {
    description = "id of the image to use for the server"
}

variable "flavor" {
    description = "name of the flavor to use for the server"
}

variable "keypair" {
    description = "the keypair to deploy on the server"
}

variable "network_id" {
    description = "the ID of the network"
}

variable "subnet_id" {
    description = "the ID of the subnet"
}

variable "attach_eip" {
    description = "whether or not to attach en EIP to the server"
    default      = "false"
}

variable "security_groups" {
    type        = "list"
    description = "list of security group ids to attach to the server"
    default     = []
}

variable "count" {
    description = "number of resources to create"
    default     = "1"
}

variable "instance_count" {
    description = "number of instances to create"
    default     = "1"
}
