include:
  - owncloud.client

{% for user in salt['pillar.get']('owncloud-client', ()) %}
{% for folder,settings in salt['pillar.get']('owncloud-client:' ~ user ~ ':folders', {}).iteritems() %}

owncloud-folder-{{ user }}-{{ folder }}:
  file.managed:
    - name: /home/{{ user }}/.local/share/data/ownCloud/folders/{{ folder }}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
    - contents: |
        [{{ folder }}]
        localPath={{ settings['localpath'] }}
        targetPath={{ settings['targetpath'] }}
        backend={{ settings['backend'] if 'backend' in settings else 'owncloud' }}
        connection={{ settings['connection'] if 'connection' in settings else 'ownCloud' }}

{% endfor %}
{% endfor %}
