variable control_ips {}
variable edge_ips {}
variable worker_ips {}
variable control_count {}
variable edge_count {}
variable worker_count {}
variable domain {}
variable short_name {}

resource "infoblox_record" "dns-control" {
  count = "${var.control_count}"
  domain = "${var.domain}"
  ipv4addr = "${element(split(\",\", var.control_ips), count.index)}"
  name = "${var.short_name}-control-${format("%02d", count.index+1)}"
}

resource "infoblox_record" "dns-worker" {
  count = "${var.worker_count}"
  domain = "${var.domain}"
  name = "${var.short_name}-worker-${format("%03d", count.index+1)}"
  ipv4addr = "${element(split(\",\", var.worker_ips), count.index)}"
}

resource "infoblox_record" "dns-edge" {
  count = "${var.edge_count}"
  domain = "${var.domain}"
  name = "${var.short_name}-edge-${format("%03d", count.index+1)}"
  ipv4addr = "${element(split(\",\", var.edge_ips), count.index)}"
}

resource "infoblox_record" "dns-worker-haproxy" {
  count = "${var.worker_count}"
  domain = "${var.domain}"
  name = "*.${var.short_name}-lb"
  ipv4addr = "${element(split(\",\", var.worker_ips), count.index)}"
}
