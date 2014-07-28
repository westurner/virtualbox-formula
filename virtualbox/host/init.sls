
{% from "virtualbox/map.jinja" import virtualbox with context %}

virtualbox:
  pkg:
    - installed
    - name: {{ virtualbox.pkg }}
  service:
    - running
    - name: {{ virtualbox.service }}
    - enable: True
