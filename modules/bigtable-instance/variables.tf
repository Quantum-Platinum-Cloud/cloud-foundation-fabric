/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "autoscaling_config" {
  description = "Settings for autoscaling of the instance. If you set this variable, the variable num_nodes is ignored."
  type = object({
    min_nodes      = number
    max_nodes      = number
    cpu_target     = number
    storage_target = optional(number, null)
  })
  default = null
}

variable "cluster_id" {
  description = "The ID of the Cloud Bigtable cluster."
  type        = string
  default     = "europe-west1"
}

variable "default_gc_policy" {
  description = "Default garbage collection policy, to be applied to all column families and all tables. Can be override in the tables variable for specific column families."
  type = object({
    deletion_policy = optional(string)
    gc_rules        = optional(string)
    mode            = optional(string)
    max_age         = optional(string)
    max_version     = optional(string)
  })
  default = null
}

variable "deletion_protection" {
  description = "Whether or not to allow Terraform to destroy the instance. Unless this field is set to false in Terraform state, a terraform destroy or terraform apply that would delete the instance will fail."
  default     = true
}

variable "display_name" {
  description = "The human-readable display name of the Bigtable instance."
  default     = null
}

variable "iam" {
  description = "IAM bindings for topic in {ROLE => [MEMBERS]} format."
  type        = map(list(string))
  default     = {}
}

variable "instance_type" {
  description = "(deprecated) The instance type to create. One of 'DEVELOPMENT' or 'PRODUCTION'."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the Cloud Bigtable instance."
  type        = string
}

variable "num_nodes" {
  description = "The number of nodes in your Cloud Bigtable cluster. This value is ignored if you are using autoscaling."
  type        = number
  default     = 1
}

variable "project_id" {
  description = "Id of the project where datasets will be created."
  type        = string
}

variable "storage_type" {
  description = "The storage type to use."
  type        = string
  default     = "SSD"
}

variable "tables" {
  description = "Tables to be created in the BigTable instance."
  nullable    = false
  type = map(object({
    split_keys = optional(list(string), [])
    column_families = optional(map(object(
      {
        gc_policy = optional(object({
          deletion_policy = optional(string)
          gc_rules        = optional(string)
          mode            = optional(string)
          max_age         = optional(string)
          max_version     = optional(string)
        }), null)
    })), {})
  }))
  default = {}
}

variable "zone" {
  description = "The zone to create the Cloud Bigtable cluster in."
  type        = string
}
