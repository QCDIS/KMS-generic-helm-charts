{{/*
Expand the name of the chart.
*/}}
{{- define "kms-generic-helm-charts.name" -}}
{{- default .Chart.Name .Values.kms_generic.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kms-generic-helm-charts.fullname" -}}
{{- if .Values.kms_generic.fullnameOverride }}
{{- .Values.kms_generic.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.kms_generic.nameOverride }}
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
{{- define "kms-generic-helm-charts.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kms-generic-helm-charts.labels" -}}
helm.sh/chart: {{ include "kms-generic-helm-charts.chart" . }}
{{ include "kms-generic-helm-charts.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kms-generic-helm-charts.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kms-generic-helm-charts.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kms-generic-helm-charts.serviceAccountName" -}}
{{- if .Values.kms_generic.serviceAccount.create }}
{{- default (include "kms-generic-helm-charts.fullname" .) .Values.kms_generic.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.kms_generic.serviceAccount.name }}
{{- end }}
{{- end }}
