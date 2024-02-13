{{/*
Kubeflow Notebooks Jupyter Web App object names.
*/}}
{{- define "kubeflow.notebooks.jupyterWebApp.baseName" -}}
{{- printf "jupyter-web-app" }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.name" -}}
{{- include "kubeflow.component.name" (
    list
    (include "kubeflow.notebooks.jupyterWebApp.baseName" .)
    .
)}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.labels" -}}
{{ include "kubeflow.common.labels" . }}
{{ include "kubeflow.component.labels" (include "kubeflow.notebooks.jupyterWebApp.name" .) }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.selectorLabels" -}}
{{ include "kubeflow.common.selectorLabels" . }}
{{ include "kubeflow.component.selectorLabels" (include "kubeflow.notebooks.jupyterWebApp.name" .) }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.image" -}}
{{ include "kubeflow.component.image" (list .Values.defaults.image .Values.notebooks.jupyterWebApp.image) }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.imagePullPolicy" -}}
{{ include "kubeflow.component.imagePullPolicy" (list .Values.defaults.image .Values.notebooks.jupyterWebApp.image) }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.autoscaling.enabled" -}}
{{ include "kubeflow.component.autoscaling.enabled" (list .Values.defaults.autoscaling .Values.notebooks.jupyterWebApp.autoscaling) }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.autoscaling.minReplicas" -}}
{{ include "kubeflow.component.autoscaling.minReplicas" (list .Values.defaults.autoscaling .Values.notebooks.jupyterWebApp.autoscaling) }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.autoscaling.maxReplicas" -}}
{{ include "kubeflow.component.autoscaling.maxReplicas" (list .Values.defaults.autoscaling .Values.notebooks.jupyterWebApp.autoscaling) }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.autoscaling.targetCPUUtilizationPercentage" -}}
{{ include "kubeflow.component.autoscaling.targetCPUUtilizationPercentage" (list .Values.defaults.autoscaling .Values.notebooks.jupyterWebApp.autoscaling) }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.autoscaling.targetMemoryUtilizationPercentage" -}}
{{ include "kubeflow.component.autoscaling.targetMemoryUtilizationPercentage" (list .Values.defaults.autoscaling .Values.notebooks.jupyterWebApp.autoscaling) }}
{{- end }}


{{- define "kubeflow.notebooks.jupyterWebApp.spawnerUI.configMapName" -}}
{{- printf "%s-%s" (include "kubeflow.notebooks.jupyterWebApp.name" .) "config" }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.logos.configMapName" -}}
{{- $customConfigMap := .Values.notebooks.jupyterWebApp.logos.customConfigMap -}}
{{- if $customConfigMap -}}
    {{- print $customConfigMap }}
{{- else -}}
    {{- printf "%s-%s" (include "kubeflow.notebooks.jupyterWebApp.name" .) "logos" }}
{{- end -}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.mainClusterRoleName" -}}
{{- include "kubeflow.notebooks.jupyterWebApp.name" . }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.mainClusterRoleBindingName" -}}
{{- include "kubeflow.notebooks.jupyterWebApp.name" . }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.kfNbUiAdminClusterRoleName" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "notebooks-ui-admin" }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.kfNbUiEditClusterRoleName" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "notebooks-ui-edit" }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.kfNbUiViewClusterRoleName" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "notebooks-ui-view" }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.enabled" -}}
{{- and .Values.notebooks.enabled .Values.notebooks.jupyterWebApp.enabled }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.createIstioIntegrationObjects" -}}
{{- and
  .Values.istioIntegration.enabled
  (include "kubeflow.notebooks.jupyterWebApp.enabled" . | eq "true" )
}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.rbac.createRoles" -}}
{{- and
    (include "kubeflow.notebooks.jupyterWebApp.enabled" . | eq "true")
    .Values.notebooks.jupyterWebApp.rbac.create }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.rbac.createServiceAccount" -}}
{{- and
    (include "kubeflow.notebooks.jupyterWebApp.enabled" . | eq "true")
    (include "kubeflow.notebooks.jupyterWebApp.rbac.createRoles" . | eq "true")
    .Values.notebooks.jupyterWebApp.rbac.serviceAccount.create
}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.logos.createConfigMap" -}}
{{- and
    (include "kubeflow.notebooks.jupyterWebApp.enabled" . | eq "true")
    (not .Values.notebooks.jupyterWebApp.logos.customConfigMap)
}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.rbac.serviceAccountName" -}}
{{- include "kubeflow.component.serviceAccountName"  (list (include "kubeflow.notebooks.jupyterWebApp.name" .) .Values.notebooks.jupyterWebApp.rbac.serviceAccount) }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.svc.name" -}}
{{ print (include "kubeflow.notebooks.jupyterWebApp.name" .) }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.svc.host" -}}
{{ printf "%s.%s.svc.%s"
  (include "kubeflow.notebooks.jupyterWebApp.svc.name" .)
  (include "kubeflow.namespace" .)
  .Values.clusterDomain
}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.authorizationPolicyExtAuthName" -}}
{{ include "kubeflow.component.authorizationPolicyExtAuthName" (
    list
    (include "kubeflow.notebooks.jupyterWebApp.name" .)
    .Values.istioIntegration
)}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.containerSecurityContext" -}}
{{ include "kubeflow.component.containerSecurityContext" (
    list
    .Values.defaults.containerSecurityContext
    .Values.notebooks.jupyterWebApp.containerSecurityContext
)}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.topologySpreadConstraints" -}}
{{ include "kubeflow.component.topologySpreadConstraints" (
    list
    .Values.defaults.topologySpreadConstraints
    .Values.notebooks.jupyterWebApp.topologySpreadConstraints
)}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.nodeSelector" -}}
{{ include "kubeflow.component.nodeSelector" (
    list
    .Values.defaults.nodeSelector
    .Values.notebooks.jupyterWebApp.nodeSelector
)}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.tolerations" -}}
{{ include "kubeflow.component.tolerations" (
    list
    .Values.defaults.tolerations
    .Values.notebooks.jupyterWebApp.tolerations
)}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.affinity" -}}
{{ include "kubeflow.component.affinity" (
    list
    .Values.defaults.affinity
    .Values.notebooks.jupyterWebApp.affinity
)}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.pdb.create" -}}
{{- include "kubeflow.component.pdb.create" (
    list
    (include "kubeflow.notebooks.jupyterWebApp.enabled" .)
    .Values.defaults.podDisruptionBudget
    .Values.notebooks.jupyterWebApp.podDisruptionBudget
)}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.pdb.values" -}}
{{- include "kubeflow.component.pdb.values" (
    list
    .Values.defaults.podDisruptionBudget
    .Values.notebooks.jupyterWebApp.podDisruptionBudget
)}}
{{- end }}