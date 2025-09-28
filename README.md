**Environment:**

- Kubernetes cluster: K3s v1.33.4+k3s1 on RHEL 8 VMware Workstation

- Helm: v3.16.2

- Elasticsearch: amazon/opendistro-for-elasticsearch 1.11.0

  

**Step 1: Deploy Elasticsearch + Kibana with Helm**
```
helm install -name es-task elasticsearch-helm-updated -f elasticsearch-helm-updated/values.yaml -n default
sleep 120

kubectl exec -it es-task-master-0 -- bash -c "/usr/share/elasticsearch/plugins/opendistro_security/tools/securityadmin.sh -cd /usr/share/elasticsearch/plugins/opendistro_security/securityconfig -icl -key /usr/share/elasticsearch/config/kirk-key.pem -cert /usr/share/elasticsearch/config/kirk.pem -cacert /usr/share/elasticsearch/config/root-ca.pem -nhnv"
```
