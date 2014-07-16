include:
  - owncloud.client

{% for user in salt['pillar.get']('owncloud-client', ()) %}
{% for folder in salt['pillar.get']('owncloud-client:' ~ user ~ ':folders', {}) %}

owncloud-folder-{{ user }}-{{ folder }}:
  file.managed:
    - name: /home/{{ user }}/.local/share/data/ownCloud/folders/{{ folder }}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 744
    - contents: |
      [{{ folder }}]
      localPath={{ folder['localpath'] }}
      targetPath={{ folder['targetpath'] }}
      backend={{ folder['backend'] }}
      connection={{ folder['connection'] }}

{% endfor %}
{% endfor %}
