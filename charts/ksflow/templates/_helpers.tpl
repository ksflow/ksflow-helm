{{/* This file was modified from https://github.com/argoproj/argo-helm/blob/34a33c967f83622b086de824b0e67c83360de791/charts/argo-workflows/templates/_helpers.tpl  (apache 2.0 license) */}}
{{/* vim: set filetype=mustache: */}}

{{/*
Create schema-registry name and version as used by the chart label.
*/}}
{{- define "ksflow.schemaRegistry.fullname" -}}
{{- printf "%s-%s" (include "ksflow.fullname" .) .Values.schemaRegistry.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create controller name and version as used by the chart label.
*/}}
{{- define "ksflow.controller.fullname" -}}
{{- printf "%s-%s" (include "ksflow.fullname" .) .Values.controller.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create jks-password secret name and version as used by the chart label.
*/}}
{{- define "ksflow.jksPassword.fullname" -}}
{{- printf "%s-jks-pwd" (include "ksflow.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "ksflow.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "ksflow.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ksflow.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "ksflow.labels" -}}
helm.sh/chart: {{ include "ksflow.chart" .context }}
{{ include "ksflow.selectorLabels" (dict "context" .context "component" .component "name" .name) }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
app.kubernetes.io/part-of: ksflow
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ksflow.selectorLabels" -}}
{{- if .name -}}
app.kubernetes.io/name: {{ include "ksflow.name" .context }}-{{ .name }}
{{ end -}}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}

{{/*
Create the name of the controller service account to use
*/}}
{{- define "ksflow.schemaRegistryServiceAccountName" -}}
{{- if .Values.controller.serviceAccount.create -}}
    {{ default (include "ksflow.schemaRegistry.fullname" .) .Values.controller.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.controller.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the controller service account to use
*/}}
{{- define "ksflow.controllerServiceAccountName" -}}
{{- if .Values.controller.serviceAccount.create -}}
    {{ default (include "ksflow.controller.fullname" .) .Values.controller.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.controller.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the default ksflow app version
*/}}
{{- define "ksflow.defaultTag" -}}
  {{- default .Chart.AppVersion .Values.images.tag }}
{{- end -}}