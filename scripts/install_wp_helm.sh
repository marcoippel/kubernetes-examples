#bin/bash
helm install wp-demo2 ./../helm/demo/ \
--namespace wordpress \
--set host=your-host \
--set mysqlPass=password