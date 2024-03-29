# Ksflow Chart

Helm chart for [ksflow](https://github.com/ksflow/ksflow).

```yaml
# Example values-example.yaml with required values
kafka:
  bootstrapServers:
  - my-kafka-broker-1:9092
  - my-kafka-broker-2:9092
```

```bash
helm repo add ksflow https://ksflow.github.io/ksflow-helm
helm install ksflow ksflow/ksflow -f ./values-example.yaml
```

## Parameters

#### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| crds.annotations | object | `{}` | Annotations to be added to all CRDs |
| crds.install | bool | `true` | Install and upgrade CRDs |
| crds.keep | bool | `true` | Keep CRDs on chart uninstall |
| createAggregateRoles | bool | `true` | Create clusterroles that extend existing clusterroles to interact with ksflow crds (ref: [Aggregated ClusterRoles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#aggregated-clusterroles)) |
| extraObjects | list | `[]` | Extra Kubernetes objects to be managed by the chart |
| fullnameOverride | string | `nil` | String to fully override "ksflow.fullname" template |
| images.pullPolicy | string | `"Always"` | imagePullPolicy to apply to all containers |
| images.pullSecrets | list | `[]` | Secrets with credentials to pull images from a private registry |
| images.tag | string | `""` | Common tag for Ksflow images. Defaults to `.Chart.AppVersion`. |
| nameOverride | string | `nil` | String to partially override "ksflow.fullname" template |

#### Kafka

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kafka.bootstrapServers | string | `nil` | **REQUIRED**. List of initial Kafka brokers to connect to, see [kafka config's bootstrap.servers](https://kafka.apache.org/documentation/#adminclientconfigs_bootstrap.servers) |
| kafka.kafkaTopic.defaults.configs | object | `{}` | Default configs for KafkaTopics |
| kafka.kafkaTopic.defaults.partitions | string | `nil` | Default partitions for KafkaTopics |
| kafka.kafkaTopic.defaults.replicationFactor | string | `nil` | Default replication factor for KafkaTopics |
| kafka.kafkaTopic.nameTemplate | string | `"{{ .Namespace }}.{{ .Name }}"` | Go Template to generate a unique kafka topic from a KafkaTopic's namespaced name. For topic naming see: https://kafka.apache.org/documentation/#multitenancy-topic-naming |
| kafka.kafkaUser.nameTemplate | string | `"CN={{ .Name }}.{{ .Namespace }}.kafkauser"` | Go Template to generate a unique kafka user from a KafkaUser's namespaced name. For user naming see: https://docs.confluent.io/platform/current/kafka/authorization.html#principal |

#### Controller

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controller.affinity | object | `{}` | Assign custom [affinity] rules |
| controller.controllerManager | object | `{}` | [Controller Manager configuration](https://pkg.go.dev/sigs.k8s.io/controller-runtime/pkg/config/v1alpha1#ControllerManagerConfigurationSpec) |
| controller.deploymentAnnotations | object | `{}` | deploymentAnnotations is an optional map of annotations to be applied to the controller Deployment |
| controller.extraArgs | list | `[]` | Extra arguments to be added to the controller |
| controller.extraContainers | list | `[]` | Extra containers to be added to the controller deployment |
| controller.extraEnv | list | `[]` | Extra environment variables to provide to the controller container |
| controller.extraVolumeMounts | list | `[]` | Additional volume mounts to the controller main container |
| controller.extraVolumes | list | `[]` | Additional volumes to the controller pod |
| controller.image.registry | string | `"docker.io"` | Registry to use for the controller |
| controller.image.repository | string | `"ksflow/ksflow"` | Registry to use for the controller |
| controller.image.tag | string | `""` | Image tag for the ksflow controller. Defaults to `.Values.images.tag`. |
| controller.livenessProbe | object | See [values.yaml] | Configure liveness [probe] for the controller |
| controller.name | string | `"controller"` | Controller name string |
| controller.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | [Node selector] |
| controller.pdb.enabled | bool | `false` | Configure [Pod Disruption Budget] for the controller pods |
| controller.podAnnotations | object | `{}` | podAnnotations is an optional map of annotations to be applied to the controller Pods |
| controller.podLabels | object | `{}` | Optional labels to add to the controller pods |
| controller.podSecurityContext | object | `{}` | SecurityContext to set on the controller pods |
| controller.priorityClassName | string | `""` | Leverage a PriorityClass to ensure your pods survive resource shortages (ref: [Pod Priority Preemption](https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/)) |
| controller.rbac.create | bool | `true` | Adds Role and RoleBinding for the controller. |
| controller.replicas | int | `1` | The number of controller pods to run |
| controller.resources | object | `{}` | Resource limits and requests for the controller |
| controller.securityContext | object | See [values.yaml] | the controller container's securityContext |
| controller.serviceAccount.annotations | object | `{}` | Annotations applied to created service account |
| controller.serviceAccount.create | bool | `true` | Create a service account for the controller |
| controller.serviceAccount.name | string | `""` | Service account name |
| controller.tolerations | list | `[]` | [Tolerations] for use with node taints |
| controller.topologySpreadConstraints | list | `[]` | Assign custom [Pod Topology Spread Constraints](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/) rules to the controller. If labelSelector is left out, it will default to the labelSelector configuration of the deployment |
