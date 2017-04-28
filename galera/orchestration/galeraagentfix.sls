#dirty fix of galera agent
galera_orchestrate__pcs_fix_galera_agent:
  cmd.run:
    - name: mkdir -p /usr/lib/ocf/resource.d/heartbeat/; curl -o /usr/lib/ocf/resource.d/heartbeat/galera https://raw.githubusercontent.com/hoonetorg/resource-agents/glt2017/heartbeat/galera; chmod 755 /usr/lib/ocf/resource.d/heartbeat/galera; chown root:root /usr/lib/ocf/resource.d/heartbeat/galera; restorecon /usr/lib/ocf/resource.d/heartbeat/galera
    - unless: grep safe_to /usr/lib/ocf/resource.d/heartbeat/galera
