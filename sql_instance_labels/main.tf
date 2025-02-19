# [START cloud_sql_mysql_instance_labels]
resource "google_sql_database_instance" "mysql_instance_labels" {
  name             = "mysql-instance-labels"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-n1-standard-2"
    user_labels = {
      track        = "production"
      billing-code = 34802
    }
  }
  deletion_protection = false # set to true to prevent destruction of the resource
}
# [END cloud_sql_mysql_instance_labels]

# [START cloud_sql_postgres_instance_labels]
resource "google_sql_database_instance" "postgres_instance_labels" {
  name             = "postgres-instance-labels"
  region           = "us-central1"
  database_version = "POSTGRES_14"
  settings {
    tier = "db-custom-2-7680"
    user_labels = {
      track        = "production"
      billing-code = 34802
    }
  }
  deletion_protection = false # set to true to prevent destruction of the resource
}
# [END cloud_sql_postgres_instance_labels]

# [START cloud_sql_sqlserver_instance_labels]
resource "google_sql_database_instance" "default" {
  name             = "sqlserver-instance-labels"
  region           = "us-central1"
  database_version = "SQLSERVER_2019_STANDARD"
  root_password    = "INSERT-PASSWORD-HERE"
  settings {
    tier = "db-custom-2-7680"
    user_labels = {
      track        = "production"
      billing-code = 34802
    }
  }
  deletion_protection = false # set to true to prevent destruction of the resource
}
# [END cloud_sql_sqlserver_instance_labels]
