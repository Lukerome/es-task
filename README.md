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

kubectl get pods
kubectl get svc
kubectl get
```
---
**Step 2: Enable security & TLS**
This tool is used to initialize or update the security configuration in your Elasticsearch cluster, including users, roles, permissions, and other security settings.
```
kubectl exec -it es-task-master-0 -- bash -c "/usr/share/elasticsearch/plugins/opendistro_security/tools/securityadmin.sh -cd /usr/share/elasticsearch/plugins/opendistro_security/securityconfig -icl -key /usr/share/elasticsearch/config/kirk-key.pem -cert /usr/share/elasticsearch/config/kirk.pem -cacert /usr/share/elasticsearch/config/root-ca.pem -nhnv"
```

---

