# efk

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square)

## How to install this chart

Add my public chart repo:

```console
helm repo add cicd-toolkit https://cicd-toolkit.github.io/helm-charts
```

A simple install with default values:

```console
helm install cicd-toolkit/efk
```

To install the chart with the release name `my-release`:

```console
helm install my-release cicd-toolkit/efk
```

To install with some set values:

```console
helm install my-release cicd-toolkit/efk --set values_key1=value1 --set values_key2=value2
```

To install with custom values file:

```console
helm install my-release cicd-toolkit/efk -f values.yaml
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| curator.image | string | `"public.ecr.aws/bitnami/elasticsearch-curator:5.8.4-debian-11-r11@sha256:46c98206dfaef81705d9397bd3d962d1505c8cfe9437f86ea0258d5cbef89e7f"` |  |
| curator.schedule | string | `"0 1 * * *"` |  |
| curator.timestring | string | `"%Y.%m.%d"` |  |
| curator.unit | string | `"days"` |  |
| curator.unit_count | int | `15` |  |
| elasticsearch.clusterHealthCheckParams | string | `"wait_for_status=green&timeout=1s"` |  |
| elasticsearch.es_java_opt | string | `"-Xmx1g -Xms1g"` |  |
| elasticsearch.image | string | `"docker.elastic.co/elasticsearch/elasticsearch:7.17.25@sha256:aaf1c65bc2d0d400d59ec70f0a137a5b4f3fb9c764319120ea3ca5a1e1e7869a"` |  |
| elasticsearch.persistence.storageClassName | string | `nil` |  |
| elasticsearch.persistence.storageSize | string | `"100Gi"` |  |
| elasticsearch.replicas | int | `1` |  |
| elasticsearch.resources.limits.cpu | string | `"1000m"` |  |
| elasticsearch.resources.limits.memory | string | `"2Gi"` |  |
| elasticsearch.resources.requests.cpu | string | `"1000m"` |  |
| elasticsearch.resources.requests.memory | string | `"2Gi"` |  |
| elasticsearch.sysctlVmMaxMapCount | string | `"262144"` |  |
| filebeat.config."filebeat.yml" | string | `"filebeat.inputs:\n- type: container\n  paths:\n    - /var/log/containers/*.log\n  exclude_files:\n    - /var/log/containers/fluent.*\n    - /var/log/containers/es-cluster-.*\n    - /var/log/containers/kube-proxy.*\n    - /var/log/containers/konnectivity-agent.*\n    - /var/log/containers/efs-csi-node-.*\n    - /var/log/containers/ebs-snapshot-controller-.*\n    - /var/log/containers/gke-.*\n    - /var/log/containers/event-exporter-gke-.*\n    - /var/log/containers/calico-.*\n    - /var/log/containers/kube-dns-.*\n    - /var/log/containers/netd-.*\n    - /var/log/containers/pdcsi-node-.*\n    - /var/log/containers/csi-azuredisk-node-.*\n    - /var/log/containers/cloud-node-manager-.*\n  processors:\n  - add_kubernetes_metadata:\n      host: ${NODE_NAME}\n      matchers:\n      - logs_path:\n          logs_path: \"/var/log/containers/\"\noutput.elasticsearch:\n  protocol: https\n  hosts: ['${ELASTICSEARCH_HOST:logs-elasticsearch}:${ELASTICSEARCH_PORT:9200}']\n  username: \"${ELASTICSEARCH_USERNAME:elastic}\"\n  password: \"${ELASTICSEARCH_PASSWORD}\"\n  ssl:\n    verification_mode: none\n    certificate_authorities:\n    - /usr/share/filebeat/config/certs/ca.crt\n    - /usr/share/filebeat/config/certs/tls.crt\n"` |  |
| filebeat.enabled | bool | `true` |  |
| filebeat.image | string | `"docker.elastic.co/beats/filebeat:7.17.25@sha256:9bf508a43265d503b131f7cdc95038c0606c2ee6ebe805dfae274e98da4b2f7d"` |  |
| filebeat.updateStrategy | string | `"RollingUpdate"` |  |
| fluentd.enabled | bool | `false` |  |
| fluentd.image | string | `"fluent/fluentd-kubernetes-daemonset:v1.17-debian-elasticsearch7-1@sha256:b2676f28f64fa83d1aa1474210ac7f7b4e5248b28021c13b1274a0628742c6bd"` |  |
| kibana.image | string | `"docker.elastic.co/kibana/kibana:7.17.25@sha256:f526876eb801eda6b6a31bf7997f76e43206fa4b08c4153f5d491fcb1dd81455"` |  |
| kibana.ingress.annotations | object | `{}` |  |
| kibana.ingress.host | string | `"kibana.example.com"` |  |
| kibana.ingress.ingressClassName | string | `"nginx"` |  |
| kibana.ingress.tls.issuer | string | `"letsencrypt-prod"` |  |
| kibana.ingress.tls.secret | string | `"kibana-tls"` |  |
| kibana.init_index_pattern | bool | `false` |  |
| kibana.password | string | `"elastic"` |  |
| kibana.replicas | int | `1` |  |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| giuliocalzolari |  |  |
