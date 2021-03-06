glt2017:
  '*':
    - match: compound
    - repoconf
    - firewalld
    - hosts
    - serverpackages
    - chrony
  'salt*':
    - match: compound
    - salt.formulas
    - salt.master

    # all services from here on must be deployed via orchestration
    # 1. pcs -> to get cluster up and running
    # and after that all other services which should be started by the cluster
