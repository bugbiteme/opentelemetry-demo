# oc adm policy add-scc-to-user anyuid -z otel-sa -n otel-demo
# Get all deployment names and set the service account on each one
for deploy in $(oc get deployment -n otel-demo -o jsonpath='{.items[*].metadata.name}'); do
    oc set serviceaccount deployment/$deploy otel-sa -n otel-demo
done

oc set serviceaccount deployment/grafana otel-sa -n otel-demo
oc set serviceaccount statefulset/opensearch otel-sa -n otel-demo

oc -n otel-demo get deploy -o name | xargs -r -L1 oc -n otel-demo rollout restart
