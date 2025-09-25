# Enable Istio sidecar injection for a specific deployment your namespace
$ oc patch deployment/<deployment-name> -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n <namepsace>
# OR
$ oc apply -f <(istioctl kube-inject -f <deployment-file>.yaml) -n <namespace>



# Check a service is reachable from a pod
$ SOURCE_POD=$(oc get pod -n <namespace> -l app=<source-app
$ oc exec -it $SOURCE_POD -c curl -- curl 10.1.1.171 -s -o /dev/null -w "%{http_code}"

# Deploy Fortio in a namespace
$ export FORTIO_POD=$(oc get pods -l app=fortio -o 'jsonpath={.items[0].metadata.name}')
# Run a curl command from Fortio pod to httpbin service
$ oc exec "$FORTIO_POD" -c fortio -- /usr/bin/fortio curl -quiet http://httpbin:8000/get
# Run a load test from Fortio pod to httpbin service as fast as possible(qps=0) with 2 connections and total 20 requests
$ oc exec "$FORTIO_POD" -c fortio -- /usr/bin/fortio load -c 2 -qps 0 -n 20 -loglevel Warning http://httpbin:8000/get
