ns="ns-dbz-data-engineer"

# -------------------------------------------------
# general
# -------------------------------------------------

k8s-ns-apply:
	kubectl apply -f manifests/namespace.yaml

k8s-ns-del:
	kubectl delete -f manifests/namespace.yaml

k8s-get-pods:
	kubectl get pods -n ${ns}

k8s-get-svc:
	kubectl get svc -n ${ns}

k8s-get-all:
	kubectl get all -n ${ns}

k8s-get-pv:
	kubectl get pv

# -------------------------------------------------
# zookeeper
# -------------------------------------------------

k8s-zk-apply:
	kubectl apply -f manifests/zk-svc.yaml
	kubectl apply -f manifests/zk-pod.yaml

k8s-zk-del:	
	kubectl delete -f manifests/zk-pod.yaml
	kubectl delete -f manifests/zk-svc.yaml

# -------------------------------------------------
# kafka
# -------------------------------------------------

k8s-kafka-apply:
	kubectl apply -f manifests/kafka-svc.yaml
	kubectl apply -f manifests/kafka-pod.yaml

k8s-kafka-del:	
	kubectl delete -f manifests/kafka-pod.yaml
	kubectl delete -f manifests/kafka-svc.yaml

k8s-kafka-log:
	kubectl logs dbz-kafka -n ${ns}

k8s-kafka-desc:
	kubectl describe pod dbz-kafka -n ${ns}

# -------------------------------------------------
# kafka UI
# -------------------------------------------------

k8s-kui-apply:
	kubectl apply -f manifests/kafka-ui-svc.yaml
	kubectl apply -f manifests/kafka-ui-pod.yaml

k8s-kui-del:
	kubectl delete -f manifests/kafka-ui-pod.yaml
	kubectl delete -f manifests/kafka-ui-svc.yaml

k8s-kui-log:
	kubectl logs dbz-kafka-ui -n ${ns}

k8s-kui-desc:
	kubectl describe pod dbz-kafka-ui -n ${ns}

k8s-kui-pf:
	kubectl port-forward svc/kafka-ui-svc -n ${ns} 8080:8080

# -------------------------------------------------
# debezium connect
# -------------------------------------------------

k8s-dbz-apply:
	kubectl apply -f manifests/dbz-connect-svc.yaml
	kubectl apply -f manifests/dbz-connect-pod.yaml

k8s-dbz-del:	
	kubectl delete -f manifests/dbz-connect-pod.yaml
	kubectl delete -f manifests/dbz-connect-svc.yaml

k8s-dbz-job-apply:
	kubectl apply -f manifests/dbz-connect-job-connector-cm.yaml
	kubectl apply -f manifests/dbz-connect-job-connector.yaml

k8s-dbz-job-del:
	kubectl delete -f manifests/dbz-connect-job-connector.yaml
	kubectl delete -f manifests/dbz-connect-job-connector-cm.yaml


k8s-dbz-job-log:
	kubectl describe pod job-include-postgres-connector -n ${ns}
	
k8s-dbz-log:
	kubectl logs dbz-connect -n ${ns}

k8s-dbz-desc:
	kubectl describe pod dbz-connect -n ${ns}

k8s-dbz-pf:
	kubectl port-forward svc/dbz-connect-svc -n ${ns} 8083:8083

# -------------------------------------------------
# database
# -------------------------------------------------

k8s-db-apply:
	kubectl apply -f manifests/postgres-svc.yaml
	kubectl apply -f manifests/postgres-pvc.yaml
	kubectl apply -f manifests/postgres-pod.yaml

k8s-db-del:
	kubectl delete -f manifests/postgres-pod.yaml
	kubectl delete -f manifests/postgres-pvc.yaml
	kubectl delete -f manifests/postgres-svc.yaml

k8s-db-log:
	kubectl logs dbz-postgres -n ${ns}

k8s-db-desc:
	kubectl describe pod dbz-postgres -n ${ns}

k8s-db-sh:
	kubectl exec -it dbz-postgres -n ${ns} -- bash

k8s-db-pf:
	kubectl port-forward svc/postgres-svc -n ${ns} 5432:5432

# -------------------------------------------------
# app
# -------------------------------------------------

k8s-app-apply:
	kubectl apply -f manifests/app-cm.yaml
	kubectl apply -f manifests/app-pod.yaml
	
k8s-app-del:
	kubectl delete -f manifests/app-pod.yaml
	kubectl delete -f manifests/app-cm.yaml

k8s-app-log:
	kubectl logs dbz-fake-transaction -n ${ns}

k8s-app-desc:
	kubectl describe pod dbz-fake-transaction -n ${ns}

# -------------------------------------------------
# setup/destroy
# -------------------------------------------------

k8s-setup: k8s-ns-apply k8s-zk-apply k8s-kafka-apply k8s-kui-apply k8s-dbz-apply k8s-db-apply k8s-app-apply

k8s-destroy: k8s-app-del k8s-ns-del k8s-zk-del k8s-kafka-del k8s-kui-del k8s-dbz-del k8s-db-del

