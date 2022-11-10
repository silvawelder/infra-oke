# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl
resource "oci_core_security_list" "control_plane_seclist" {
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? "control-plane" : format("%s-%s-control-plane", var.label_prefix, terraform.workspace)
  vcn_id         = var.vcn_id

  dynamic "egress_security_rules" {
    iterator = cp_egress_iterator
    for_each = local.cp_egress_seclist

    content {

      description      = cp_egress_iterator.value["description"]
      destination      = cp_egress_iterator.value["destination"]
      destination_type = cp_egress_iterator.value["destination_type"]
      protocol         = cp_egress_iterator.value["protocol"]
      stateless        = cp_egress_iterator.value["stateless"]

      dynamic "tcp_options" {
        for_each = cp_egress_iterator.value["protocol"] == local.tcp_protocol && cp_egress_iterator.value["port"] != -1 ? [1] : []

        content {
          min = cp_egress_iterator.value["port"]
          max = cp_egress_iterator.value["port"]
        }
      }

    }
  }

  dynamic "ingress_security_rules" {
    iterator = cp_ingress_iterator
    for_each = local.cp_ingress_seclist

    content {
      description = cp_ingress_iterator.value["description"]
      protocol    = cp_ingress_iterator.value["protocol"]
      source      = cp_ingress_iterator.value["source"]
      stateless   = cp_ingress_iterator.value["stateless"]
      source_type = cp_ingress_iterator.value["source_type"]

      dynamic "tcp_options" {
        for_each = cp_ingress_iterator.value["protocol"] == local.tcp_protocol && cp_ingress_iterator.value["port"] != -1 ? [1] : []

        content {
          min = cp_ingress_iterator.value["port"]
          max = cp_ingress_iterator.value["port"]
        }
      }
    }
  }

}

resource "oci_core_security_list" "workers_seclist" {
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? "workers" : format("%s-%s-workers", var.label_prefix, terraform.workspace)
  vcn_id         = var.vcn_id

  dynamic "egress_security_rules" {
    iterator = workers_egress_iterator
    for_each = local.workers_egress

    content {

      description      = workers_egress_iterator.value["description"]
      destination      = workers_egress_iterator.value["destination"]
      destination_type = workers_egress_iterator.value["destination_type"]
      protocol         = workers_egress_iterator.value["protocol"]
      stateless        = workers_egress_iterator.value["stateless"]

      dynamic "tcp_options" {
        for_each = workers_egress_iterator.value["protocol"] == local.tcp_protocol && workers_egress_iterator.value["port"] != -1 ? [1] : []

        content {
          min = workers_egress_iterator.value["port"]
          max = workers_egress_iterator.value["port"]
        }
      }

    }
  }

  dynamic "ingress_security_rules" {
    iterator = workers_ingress_iterator
    for_each = local.workers_ingress

    content {
      description = workers_ingress_iterator.value["description"]
      protocol    = workers_ingress_iterator.value["protocol"]
      source      = workers_ingress_iterator.value["source"]
      stateless   = workers_ingress_iterator.value["stateless"]
      source_type = workers_ingress_iterator.value["source_type"]

      dynamic "tcp_options" {
        for_each = workers_ingress_iterator.value["protocol"] == local.tcp_protocol && workers_ingress_iterator.value["port"] != -1 ? [1] : []

        content {
          min = workers_ingress_iterator.value["port"]
          max = workers_ingress_iterator.value["port"]
        }
      }
    }
  }

}

resource "oci_core_security_list" "int_lb_seclist" {
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? "int-lb" : format("%s-%s-int-lb", var.label_prefix, terraform.workspace)
  vcn_id         = var.vcn_id

  dynamic "egress_security_rules" {
    iterator = int_lb_egress_iterator
    for_each = local.int_lb_egress

    content {

      description      = int_lb_egress_iterator.value["description"]
      destination      = int_lb_egress_iterator.value["destination"]
      destination_type = int_lb_egress_iterator.value["destination_type"]
      protocol         = int_lb_egress_iterator.value["protocol"]
      stateless        = int_lb_egress_iterator.value["stateless"]

      dynamic "tcp_options" {
        for_each = int_lb_egress_iterator.value["protocol"] == local.tcp_protocol && int_lb_egress_iterator.value["port_min"] != -1 ? [1] : []

        content {
          min = int_lb_egress_iterator.value["port_min"]
          max = int_lb_egress_iterator.value["port_max"]
        }
      }

    }
  }

  dynamic "ingress_security_rules" {
    iterator = int_lb_ingress_iterator
    for_each = local.int_lb_ingress

    content {
      description = int_lb_ingress_iterator.value["description"]
      protocol    = int_lb_ingress_iterator.value["protocol"]
      source      = int_lb_ingress_iterator.value["source"]
      stateless   = int_lb_ingress_iterator.value["stateless"]
      source_type = int_lb_ingress_iterator.value["source_type"]

      dynamic "tcp_options" {
        for_each = int_lb_ingress_iterator.value["protocol"] == local.tcp_protocol && int_lb_ingress_iterator.value["port"] != -1 ? [1] : []

        content {
          min = int_lb_ingress_iterator.value["port"]
          max = int_lb_ingress_iterator.value["port"]
        }
      }
    }
  }
}