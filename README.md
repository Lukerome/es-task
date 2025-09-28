**Environment:**

- Kubernetes cluster: K3s v1.33.4+k3s1 on RHEL 8 VMware Workstation

- Helm: v3.16.2

- Elasticsearch: amazon/opendistro-for-elasticsearch 1.11.0


--- 

**Step 1: Deploy Elasticsearch + Kibana with Helm**
```
git clone https://github.com/Lukerome/es-task.git

helm install -name es-task es-task -f es-task/values.yaml -n default
sleep 120

verify the resources are created:
helm list -n default
kubectl get pv
kubectl get pvc
kubectl get svc
kubectl get sts
kubectl get pods
```
---
**Step 2: Enable security & SSL/TLS**
This tool is used to initialize or update the security configuration in your Elasticsearch cluster, including users, roles, permissions, and other security settings.
```
kubectl exec -it es-task-master-0 -- bash -c "/usr/share/elasticsearch/plugins/opendistro_security/tools/securityadmin.sh -cd /usr/share/elasticsearch/plugins/opendistro_security/securityconfig -icl -key /usr/share/elasticsearch/config/kirk-key.pem -cert /usr/share/elasticsearch/config/kirk.pem -cacert /usr/share/elasticsearch/config/root-ca.pem -nhnv"
```
Note: For any CA provided certs, we need to configure in the certs as secret and mount it using volumeClaimTemplates. Here I have used the opendistro security admin script to enable TLS.

kubectl create secret generic elasticsearch-transport-certs \
  --from-file=elk-transport-crt.pem \
  --from-file=elk-transport-key.pem \
  --from-file=elk-transport-root-ca.pem \
  -n default

---
**Step 3: Scale up the data nodes to 3**
```
kubectl scale statefulset es-task-data --replicas=3

verify the cluster health:
kubectl exec es-task-data-0 -- curl -s -u admin:admin https://es-task-data-svc:9200/_cat/health?v -k

or use the following from vm

ES_IP=`kubectl get svc es-task-data-svc -o yaml | awk -F":" '/clusterIP:/ {print $2}'|tr -d ' '`

curl -u admin:admin -k https://${ES_IP}:9200/_cluster/health

curl -u admin:admin -k https://${ES_IP}:9200/_cat/health?v

or can also be accessed via host from browser using the vm ip and nodeports

ES: https://<host_ip/host_fqdn>:32005
Kibana: http://<host_ip/host_fqdn>:32003

```
---
**Step 4: Create the index template & insert the sample.json**
```
sh es-task/scripts/create_template.sh

sh es-task/scripts/insert_doc.sh

sh es-task/scripts/test/search.sh
```