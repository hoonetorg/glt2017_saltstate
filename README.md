# glt2017_saltstate
## Description
This repo contains the Saltstack state folder with the state-top-file and the sls files with the orchestration state for building a Pacemaker/MySQL/Galera-cluster.
Further the required command for starting the orchestration can be found.
Also log-files of a successful orchestration are in this repo.


# WIP
## useful commands
```salt-call cp.list_master saltenv=glt2017
salt-call -l all state.highstate
salt-call -l debug state.highstate test=True
salt-call -l debug state.sls salt.formulas,salt.master saltenv=glt2017
salt-call -l debug state.sls salt.formulas,salt.master saltenv=glt2017 test=True
```

## fix galera agent, where stock agent (which comes with RHEL/CentOS)is broken with newer versions of Percona XtraDB Cluster 5.6
```salt 'db*' cmd.run 'curl -o /usr/lib/ocf/resource.d/heartbeat/galera https://raw.githubusercontent.com/hoonetorg/resource-agents/master/heartbeat/galera; chmod 755 /usr/lib/ocf/resource.d/heartbeat/galera; chown root:root /usr/lib/ocf/resource.d/heartbeat/galera; restorecon /usr/lib/ocf/resource.d/heartbeat/galera'
```

## remove galera resource from cluster and cleanup mysql runtime files and logs(for redeployments)
```salt 'db*' cmd.run 'pcs resource disable galera; pcs resource cleanup galera; pcs resource delete galera; rm -Rf /var/lib/mysql* /var/log/mysql* /var/run/mysql* /etc/my*'```

## check if mysql is started/stopped on all nodes (useful for debugging problems)
```salt 'db*' cmd.run 'ps -ef|grep mysql'```

## remove Percona XtraDB Cluster rpm packages from db nodes and cleanup mysql runtime files and logs(for redeployments)
```salt 'db*' cmd.run 'yum -y remove --setopt=clean_requirements_on_remove=1 Percona-XtraDB-Cluster-56 Percona-XtraDB-Cluster-client-56 Percona-XtraDB-Cluster-shared-56 Percona-XtraDB-Cluster-server-56 Percona-XtraDB-Cluster-shared-compat-56 nc; rm -Rf /var/lib/mysql* /var/log/mysql* /var/run/mysql* /etc/my*'```

## only run mysql.server state which mainly creates my.cnf and installs (rpm-)packages
```salt 'db*' state.sls mysql.server saltenv=glt2017```

## orchestration state with debugging output
```salt-run --force-color -l debug state.orch galera.orchestration saltenv=glt2017```

## orchestration state with debugging output
```salt-run --force-color state.orch galera.orchestration saltenv=glt2017```


## set SELinux to permissive
```setenforce 0```

## check for uncommitted Saltstack changes on Saltstack master
```for i in `find /srv -type d -name .git` ; do echo $i; cd `dirname $i`; git status;done```

## watch output of orchestration in color and case insensitive search with less 
```less -Ir galeracmds.log```

## create mysql table in database from orchestration and list it
```mysql -u glt2017 --password='glt2017' -h 192.168.124.121 -e "CREATE TABLE glt2017 (           id INT,           data VARCHAR(100)         );" glt2017```
```mysql -u glt2017 --password='glt2017' -h 192.168.124.121 -e "show tables;" glt2017```
