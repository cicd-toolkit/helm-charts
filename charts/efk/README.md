# efk

![Version: 0.0.18](https://img.shields.io/badge/Version-0.0.18-informational?style=flat-square)

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
| curator.image | string | `"public.ecr.aws/bitnami/elasticsearch-curator:5.8.4-debian-11-r11"` |  |
| curator.schedule | string | `"0 1 * * *"` |  |
| curator.timestring | string | `"%Y.%m.%d"` |  |
| curator.unit | string | `"days"` |  |
| curator.unit_count | int | `15` |  |
| elasticsearch.es_java_opt | string | `"-Xms512m -Xmx512m"` |  |
| elasticsearch.image | string | `"docker.elastic.co/elasticsearch/elasticsearch:7.5.0"` |  |
| elasticsearch.persistence.storageClassName | string | `nil` |  |
| elasticsearch.persistence.storageSize | string | `"100Gi"` |  |
| elasticsearch.replicas | int | `1` |  |
| fluentd.image | string | `"fluent/fluentd-kubernetes-daemonset:v1.15-debian-elasticsearch7-1"` |  |
| kibana.image | string | `"docker.elastic.co/kibana/kibana:7.5.0"` |  |
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
