{% set mysaltymaster = 'salt*' %}
{% set galeranodes = 'db*' %}

#salt -C 'db*' --state-verbose='False' --timeout 1800 state.highstate
galera_orchestrate__highstate:
  salt.state:
    - tgt: {{galeranodes}}
    - tgt_type: compound
    - expect_minions: True
    - highstate: True
#    - saltenv: "glt2017"
    - timeout: 1800

#salt-call --state-verbose='False' --timeout 1800 state.sls pcs.orchestration saltenv='glt2017'
galera_orchestrate__pcs:
  salt.state:
    - tgt: {{mysaltymaster}}
    - expect_minions: True
    - sls: pcs.orchestration
    - saltenv: "glt2017"
    - timeout: 1800
    - require:
      - salt: galera_orchestrate__highstate

#dirty fix of galera agent
galera_orchestrate__pcs_fix_galera_agent:
  salt.state:
    - tgt: {{galeranodes}}
    - tgt_type: compound
    - expect_minions: True
    - sls: galera.orchestration.galeraagentfix
    - saltenv: "glt2017"
    - timeout: 1800
    - require:
      - salt: galera_orchestrate__pcs

#salt-call --state-verbose='False' --timeout 1800 state.sls mysql.orchestration.server saltenv='glt2017'
galera_orchestrate__mysql:
  salt.state:
    - tgt: {{mysaltymaster}}
    - expect_minions: True
    - sls: mysql.orchestration.server
    - saltenv: "glt2017"
    - timeout: 1800
    - require:
      - salt: galera_orchestrate__pcs_fix_galera_agent
