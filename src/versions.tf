# Copyright 2017, 2021, Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

terraform {
  required_providers {
    oci = {
      source                = "hashicorp/oci"
      configuration_aliases = [oci.home]
    }
  }
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket                      = "hop-tfstates-bucket"
    key                         = "inframs/terraform.tfstate"
    region                      = "sa-saopaulo-1"
    endpoint                    = "https://idgyx0ngq8cj.compat.objectstorage.sa-saopaulo-1.oraclecloud.com"
    profile                     = "oracle-firsttech"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true

  }



}
