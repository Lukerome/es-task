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

---
**Step 3: Scale up the data nodes to 3**
```
kubectl scale statefulset es-task-data --replicas=3

verify the cluster health:
kubectl exec es-task-data-0 -- curl -s -u admin:admin https://es-task-data-svc:9200/_cat/health?v -k

or 
ES_IP=`kubectl get svc es-task-data-svc -o yaml | awk -F":" '/clusterIP:/ {print $2}'|tr -d ' '`

curl -u admin:admin -k https://${ES_IP}:9200/_cluster/health

curl -u admin:admin -k https://${ES_IP}:9200/_cat/health?v
```
---