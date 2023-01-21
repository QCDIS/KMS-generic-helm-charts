{{/*
Expand the name of the chart.
*/}}
{{- define "KMS-generic-helm-charts.name" -}}
{{- default .Chart.Name .Values.kms-generic.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "KMS-generic-helm-charts.fullname" -}}
{{- if .Values.kms-generic.fullnameOverride }}
{{- .Values.kms-generic.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.kms-generic.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "KMS-generic-helm-charts.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "KMS-generic-helm-charts.labels" -}}
helm.sh/chart: {{ include "KMS-generic-helm-charts.chart" . }}
{{ include "KMS-generic-helm-charts.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "KMS-generic-helm-charts.selectorLabels" -}}
app.kubernetes.io/name: {{ include "KMS-generic-helm-charts.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "KMS-generic-helm-charts.serviceAccountName" -}}
{{- if .Values.kms-generic.serviceAccount.create }}
{{- default (include "KMS-generic-helm-charts.fullname" .) .Values.kms-generic.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.kms-generic.serviceAccount.name }}
{{- end }}
{{- end }}
