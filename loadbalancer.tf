resource "opentelekomcloud_lb_loadbalancer_v2" "loadbalancer" {
  name           = "${var.name}-lb"
  vip_subnet_id  = "${var.subnet_id}"
  admin_state_up = "true"
  depends_on     = ["opentelekomcloud_networking_router_interface_v2.interface"]
}

resource "opentelekomcloud_lb_listener_v2" "listener" {
  name             = "${var.name}-listener"  
  protocol         = "HTTP"
  protocol_port    = 8080
  loadbalancer_id  = "${opentelekomcloud_lb_loadbalancer_v2.loadbalancer.id}"
  admin_state_up   = "true"
  #connection_limit = "-1"
}

resource "opentelekomcloud_lb_pool_v2" "pool" {
  protocol    = "HTTP"  
  lb_method   = "ROUND_ROBIN"
  listener_id = "${opentelekomcloud_lb_listener_v2.listener.id}"
}

resource "opentelekomcloud_lb_member_v2" "member" {
  address       = "${opentelekomcloud_compute_instance_v2.webserver.*.access_ip_v4}"
  pool_id       = "${opentelekomcloud_lb_pool_v2.pool.id}"
  subnet_id     = "${var.subnet_id}"
  protocol_port = 8080
}

resource "opentelekomcloud_lb_monitor_v2" "monitor" {
  pool_id        = "${opentelekomcloud_lb_pool_v2.pool.id}"  
  type           = "HTTP"
  url_path       = "/"
  expected_codes = "200"
  delay          = 20
  timeout        = 10
  max_retries    = 5
}

resource "opentelekomcloud_compute_instance_v2" "webserver" {
  region = "${var.region}"
  availability_zone = "${var.az}"

  count           = "${var.instance_count}"
  name            = "${var.name}-webserver${format("%02d", count.index+1)}"
  image_id      = "${var.image_id}"
  flavor_name     = "${var.flavor}"
  key_pair    	= "${var.keypair}"
  
  security_groups = ["${var.security_groups}"]

  network {
    uuid = "${var.network_id}"
  }
}
