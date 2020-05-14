---
#
#  Tenant Policies
#
    fvTenant:
      - name: TSMOE
        descr: 'Ansible created@johnwelby'
        state: present

      - name: CLAN
        descr: 'Ansible created@johnwelby'
        state: present

    fvCtx:
      - name: HIGH
        descr: vrf HIGH side @johnwelby
        pcEnfPref: enforced                                    # policy control preference
        pcEnfDir: egress                                       # policy control direction
        state: present
        fvTenant: 
          name: TSMOE

      - name: LOW
        descr: vrf LOW side @johnwelby
        pcEnfPref: enforced                                    # policy control preference
        pcEnfDir: egress                                       # policy control direction      
        state: present
        fvTenant: 
          name: CLAN

      - name: UNCLASS
        descr: vrf UNCLASS @johnwelby
        pcEnfPref: enforced                                    # policy control preference
        pcEnfDir: egress                                       # policy control direction      
        state: absent
        fvTenant: 
          name: CLAN         
#
# Fabric Access Policies
#
    lldpIfP:
      - adminRxSt: on
        adminTxSt: on
        descr: 'LLDP Interface Policy @johnwelby'
        name: Link_Layer_Discovery_Protocol_ON
        state: present
