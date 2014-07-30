#  https://launchpad.net/~virtualbox-ppa/+archive/releases

include:
  - virtualbox.host

{% set dist = grains['oscodename'] %}
{% set humanname = "virtualbox-releases-%s" % dist %}
{% set repo_url = "http://download.virtualbox.org/virtualbox/debian" %}

virtualbox-deb:
  pkgrepo.managed:
    - humanname: {{ humanname }}
    - name: deb {{ repo_url }} {{ dist }} non-free contrib
    - comment: ""
    - dist: {{ dist }}
    - file: /etc/apt/sources.list.d/{{ humanname }}.list
    #- keyid:
    #- keyserver:
    - key_url: salt://virtualbox/files/oracle_vbox.asc
    #- gpgcheck: 1
    #- gpgkey: 
    - require_in:
      - pkg: virtualbox


  pkg.installed:
    - pkgs:
      - linux-headers-{{ grains['kernelrelease'] }}
      - dkms
      - virtualbox-4.3
    - require:
      - pkgrepo: virtualbox-deb
    - require_in:
      - pkg: virtualbox
