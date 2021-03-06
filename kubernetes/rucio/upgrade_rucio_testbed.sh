#! /bin/bash

REPO=~/rucio-helm-charts # or rucio

PREFIX=testbed
SERVER_NAME=cms-rucio-$PREFIX
DAEMON_NAME=cms-ruciod-$PREFIX
UI_NAME=cms-webui-$PREFIX

helm upgrade --recreate-pods --values cms-rucio-common.yaml,cms-rucio-server.yaml,testbed-rucio-server.yaml,testbed-db.yaml,testbed-release.yaml  $SERVER_NAME $REPO/rucio-server
helm upgrade --recreate-pods --values cms-rucio-common.yaml,cms-rucio-daemons.yaml,testbed-rucio-daemons.yaml,testbed-db.yaml,testbed-release.yaml $DAEMON_NAME $REPO/rucio-daemons
helm upgrade --recreate-pods --values cms-rucio-common.yaml,cms-rucio-webui.yaml,${PREFIX}-rucio-webui.yaml,${PREFIX}-db.yaml,${PREFIX}-release.yaml $UI_NAME $REPO/rucio-ui

# Graphite and other services (currently not doing anything with them)
# helm install --name graphite --values rucio-graphite.yaml,rucio-graphite-nginx.yaml,rucio-graphite-pvc.yaml,dev-graphite.yaml kiwigrid/graphite
# helm install --name grafana --values rucio-grafana.yaml,dev-grafana.yaml stable/grafana
# kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode > dev_grafana_password.txt

# Filebeat and logstash

helm upgrade --values cms-rucio-logstash.yml,testbed-logstash-filter.yaml logstash stable/logstash
helm upgrade --values cms-rucio-filebeat.yml filebeat stable/filebeat

# Label is key to prevent it from also syncing datasets
kubectl apply -f dataset-configmap.yaml
kubectl apply -f testbed-sync-jobs.yaml -l syncs=rses

kubectl get pods
