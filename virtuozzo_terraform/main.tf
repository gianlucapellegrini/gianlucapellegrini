terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = ">= 1.48.0"
    }
  }
}
provider "openstack" {
  auth_url    = "https://vhi-a.milan-a.smeupsecure.cloud:5000/v3"
  tenant_name = "admin"
  user_name   = "admin"
  password    = "fender.guidance.implicate.1"
  domain_name = "Default"
}
resource "openstack_identity_project_v3" "domain_1" {
  name = "test_terraform"
  description = "Dominio di test con terraform"
  is_domain = true
}
resource "openstack_identity_project_v3" "project_1" {
  name = "terraform"
  description = "test terraform project"
  domain_id = openstack_identity_project_v3.domain_1.id
}
resource "openstack_identity_user_v3" "user_1" {
  name      = "testterraform"
  domain_id = openstack_identity_project_v3.domain_1.id
  password  = "ParadisoFiscale"
  extra = {
    email = "user_1@foobar.com"
  }
}
resource "openstack_compute_quotaset_v2" "quotas_compute" {
  project_id = openstack_identity_project_v3.project_1.id
  cores       = 100
  instances   = 50
  ram         = 256000
  key_pairs   = 100
  floating_ips = 2
}
resource "openstack_blockstorage_quotaset_v3" "quotas_blockstorage" {
  project_id = openstack_identity_project_v3.project_1.id
  gigabytes = 1000
  volumes   = 100
  snapshots = 50
}
resource "openstack_networking_quota_v2" "quotas_network" {
  project_id = openstack_identity_project_v3.project_1.id
  floatingip   = 2
  network      = 10
  port         = 50
  router       = 10
  security_group = 10
  security_group_rule = 100
  subnet       = 10
}
