salt-call cp.list_master saltenv=glt2017
salt-call -l all state.highstate
salt-call -l debug state.highstate test=True
salt-call -l debug state.sls salt.formulas,salt.master saltenv=glt2017
salt-call -l debug state.sls salt.formulas,salt.master saltenv=glt2017 test=True
salt 'db*' cmd.run 'curl -o /usr/lib/ocf/resource.d/heartbeat/galera https://raw.githubusercontent.com/hoonetorg/resource-agents/master/heartbeat/galera; chmod 755 /usr/lib/ocf/resource.d/heartbeat/galera; chown root:root /usr/lib/ocf/resource.d/heartbeat/galera; restorecon /usr/lib/ocf/resource.d/heartbeat/galera'
#salt 'db*' cmd.run 'pcs resource disable galera; pcs resource cleanup galera; pcs resource delete galera; rm -Rf /var/lib/mysql* /var/log/mysql* /var/run/mysql* /etc/my*'
salt 'db*' cmd.run 'ps -ef|grep mysql'
salt 'db*' cmd.run 'yum -y remove --setopt=clean_requirements_on_remove=1 Percona-XtraDB-Cluster-56 Percona-XtraDB-Cluster-client-56 Percona-XtraDB-Cluster-shared-56 Percona-XtraDB-Cluster-server-56 Percona-XtraDB-Cluster-shared-compat-56 nc; rm -Rf /var/lib/mysql* /var/log/mysql* /var/run/mysql* /etc/my*'
salt 'db*' state.sls mysql.server saltenv=glt2017
salt-run --force-color -l debug state.orch galera.orchestration saltenv=glt2017
salt-run --force-color state.orch galera.orchestration saltenv=glt2017
setenforce 0

for i in `find /srv -type d -name .git` ; do echo $i; cd `dirname $i`; git status;done

less -Ir galeracmds.log


mysql -u glt2017 --password='glt2017' -h 192.168.124.121 -e "CREATE TABLE glt2017 (           id INT,           data VARCHAR(100)         );" glt2017
mysql -u glt2017 --password='glt2017' -h 192.168.124.121 -e "show tables;" glt2017
