# Ksflow Chart

Helm chart for [ksflow](https://github.com/ksflow/ksflow).

**This chart does not package all dependencies** since they are generally installed in other namespaces with tools like
[argo-cd](https://github.com/argoproj/argo-cd), [flux](https://github.com/fluxcd/flux2), or [helmfile](https://github.com/helmfile/helmfile).

Refer to the example [dev](../../example-helmfiles/ksflow/dev/helmfile.yaml) and [prod](../../example-helmfiles/ksflow/prod/helmfile.yaml) helmfiles for how to install.

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
  | kafka.configs.admin | object | `{}` | [Admin Client Config](https://kafka.apache.org/documentation/#adminclientconfigs) |
  | kafka.configs.consumer | object | `{}` | [Consumer Config](https://kafka.apache.org/documentation/#consumerconfigs) |
  | kafka.configs.producer | object | `{}` | [Producer Config](https://kafka.apache.org/documentation/#producerconfigs) |
  | kafka.configs.schemaRegistry | object | `{}` | [Kafka Schema Serde Config](https://github.com/confluentinc/schema-registry/tree/v7.4.0-690/schema-serializer/src/main/java/io/confluent/kafka/serializers/AbstractKafkaSchemaSerDeConfig.java) |
  | kafka.configs.topic | object | `{}` | [Topic Config](https://kafka.apache.org/documentation/#topicconfigs) |
  | kafka.topicPrefix | string | `"ksflow"` | Prefix for all Kafka topics |

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
