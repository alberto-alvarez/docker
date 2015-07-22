# mysql5.5

Instructions to create a Docker container of MySQL 5.5 with data volume mapped 
to a specific directory within the host server.

## Usage

```bash
$ sudo mkdir -p /test/mysqldata
$ sudo docker run --name mysql-server -d -e MYSQL_ROOT_PASSWORD=SECRET -v /test/mysqldata:/var/lib/mysql mysql:5.5
```
