{{/*
Expand the name of the chart.
*/}}
{{- define "demo-app.name" -}}
{{- default .Chart.Name .Values.global.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "demo-app.fullname" -}}
{{- if .Values.global.fullnameOverride }}
{{- .Values.global.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.global.nameOverride }}
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
{{- define "demo-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Frontend service name
*/}}
{{- define "demo-app.frontend.serviceName" -}}
svc-{{- include "demo-app.fullname" . }}-frontend
{{- end }}

{{/*
Backend service name
*/}}
{{- define "demo-app.backend.serviceName" -}}
svc-{{- include "demo-app.fullname" . }}-backend
{{- end }}

{{/*
Frontend service URL
*/}}
{{- define "demo-app.frontend.serviceUrl" -}}
http://{{ include "demo-app.frontend.serviceName" . }}.{{ .Values.global.namespace }}.svc.cluster.local:{{ .Values.frontend.service.port }}
{{- end }}

{{/*
Backend service URL
*/}}
{{- define "demo-app.backend.serviceUrl" -}}
http://{{ include "demo-app.backend.serviceName" . }}.{{ .Values.global.namespace }}.svc.cluster.local:{{ .Values.backend.service.port }}
{{- end }}

{{/*
Frontend environment variables
*/}}
{{- define "demo-app.frontend.env" -}}
PORT: "{{ .Values.frontend.service.port }}"
REACT_APP_ENV: "{{ .Values.global.env | default "development" }}"
{{- end }}

{{/*
Backend environment variables
*/}}
{{- define "demo-app.backend.env" -}}
PORT: "{{ .Values.backend.service.port }}"
NODE_ENV: "{{ .Values.global.env | default "development" }}"
FRONTEND_URL: "{{ include "demo-app.frontend.serviceUrl" . }}"
{{- end }}