{{- define "kubeflow.notebooks.jupyterWebApp.name" -}}
{{- printf "jupyter-web-app" }}
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

{{- define "kubeflow.notebooks.jupyterWebApp.serviceAccountName" -}}
{{- include "kubeflow.component.serviceAccountName"  (list (include "kubeflow.notebooks.jupyterWebApp.name" .) .Values.notebooks.jupyterWebApp.serviceAccount) }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.spawnerUIConfigName" -}}
{{- printf "%s-%s" (include "kubeflow.notebooks.jupyterWebApp.name" .) "config" }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.logosConfigName" -}}
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
{{- printf "%s-%s" (include "kubeflow.fullname" .) "notebook-ui-admin" }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.kfNbUiEditClusterRoleName" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "notebook-ui-edit" }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.kfNbUiViewClusterRoleName" -}}
{{- printf "%s-%s" (include "kubeflow.fullname" .) "notebook-ui-view" }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.rbac.createRoles" -}}
{{- and .Values.notebooks.enabled .Values.notebooks.jupyterWebApp.rbac.create }}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.rbac.createServiceAccount" -}}
{{- and
    (include "kubeflow.notebooks.jupyterWebApp.rbac.createRoles" . | eq "true")
    .Values.notebooks.jupyterWebApp.rbac.serviceAccount.create
}}
{{- end }}

{{- define "kubeflow.notebooks.jupyterWebApp.rbac.serviceAccountName" -}}
{{- include "kubeflow.component.serviceAccountName"  (list (include "kubeflow.notebooks.jupyterWebApp.name" .) .Values.notebooks.jupyterWebApp.rbac.serviceAccount) }}
{{- end }}