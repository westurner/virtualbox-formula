#  https://launchpad.net/~virtualbox-ppa/+archive/releases

{% set dist = grains['oscodename'] %}
{% set humanname = "virtualbox-releases-%s" % dist %}

include:
  - virtualbox.host

virtualbox:
  pkgrepo.managed:
    - humanname: {{ humanname }}
    - name: deb http://download.virtualbox.org/virtualbox/debian {{ dist }} contrib
    - comment: ""
    - dist: {{ dist }}
    - file: /etc/apt/sources.list.d/{{ humanname }}.list
    #- keyid: D5056DDE  
    #- keyserver: keyserver.ubuntu.com
    - key_url: salt://virtualbox/files/oracle_vbox.asc
    #- gpgcheck: 1
    #- gpgkey: 
    - require_in:
      - pkg: virtualbox


  pkg.latest:
    - pkgs:
      - linux-headers-{{ grains['kernelrelease'] }}
      - dkms
      - virtualbox-4.3
    - require:
      - pkgrepo: virtualbox
    - require_in:
      - pkg: virtualbox
    #- refresh: True
