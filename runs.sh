#!/bin/bash
set -e
release="rls"
action="tpl"
timeout="5m42s"
wait="false"
usage() {
  cat <<-USAGE 1>&2
helm deploy helper
Usage:
  $0 [-u <chart>] [-n <namespace>] [-a <action>] [-r <release>]
Flags:
 -u     chart to use (Required)
 -n     Kubernetes namespace (if not specifed I'm going to use the umbrella chart name)
 -a     action to perform (default "$action")
 -r     Helm Chart Release Name (default "$release")
 -l     Datarobot license file (default "./$licensefile")
 -e     looking on ECR the last stable image (default "$ecrlookup")
 -t     time to wait for any individual Kubernetes operation (default "$timeout")
 -w     will wait until all Pods, PVCs, Services (default "$wait")
 -h,    Help for $0
USAGE
exit 0
}

reset(){
  rm -rf charts && rm -f Chart.lock && helm dependency build --repository-config "${HELM_REPOSITORY_CONFIG:-../repositories.yaml}"
}

helm_upgrade(){
  echo "run helm"
  ARGV=" --create-namespace "
  if [[ "$wait" == "true" ]]; then
    echo "waiting for creation"
    ARGV+=" --wait "
  fi

  if [ -f "values-custom.yaml" ]; then
    echo "CUSTOM"
    ARGV+=" --values values-custom.yaml "
  fi

  time helm upgrade --install $1 . -n $2 $ARGV  --render-subchart-notes --timeout $timeout --skip-crds --debug ${@: 3};
}


helm_delete(){
  echo "helm_delete"
  helm uninstall $1 -n $2 || true
  kubectl delete jobs -l "app.kubernetes.io/instance=$1"  -n $2 || true
  kubectl delete pvc  -l "app.kubernetes.io/instance=$1"  -n $2
  kubectl delete secret  -l "app.kubernetes.io/instance=$1" -n $2 || true
}

while getopts ":c:a:l:t:ehwn:r:" o; do
    case "${o}" in
        c)
            umbrella=${OPTARG}
            ;;
        w)
            wait="true"
            ;;
        n)
            namespace=${OPTARG}
            ;;
        t)
            timeout=${OPTARG}
            ;;
        a)
            action=${OPTARG}
            ;;
        r)
            release=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${umbrella}" ]; then
    usage
fi

if [ ! -d "$umbrella" ]; then
   echo "Warning: chart '$umbrella' NOT found."
   exit 1
fi

if [ -z "${namespace}" ]; then
    echo "namespace argv not provided, setting namespace=$umbrella"
    namespace=$umbrella
fi


echo ""
echo "config:"
echo " chart: ${umbrella}"
echo " namespace: ${namespace}"
echo " release: ${release}"
echo " action: ${action}"
echo "argv:"
echo " timeout: ${timeout}"
echo " wait: ${wait}"
echo ""

cd charts/$umbrella
case "$action" in
  "del")
    helm_delete $release $namespace
    exit 0
    ;;
  "redo")
    reset
    helm_delete $release $namespace
    helm_upgrade $release $namespace
    ;;
  "tpl")
    reset
    helm template .
    ;;
  *)
    reset
    helm_upgrade $release $namespace
    ;;
esac
