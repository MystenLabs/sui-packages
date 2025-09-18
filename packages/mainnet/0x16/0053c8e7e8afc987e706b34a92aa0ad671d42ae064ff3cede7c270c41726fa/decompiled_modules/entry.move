module 0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::assert_is_compatible<T0>(arg0);
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::two_step_role::accept_role<0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::roles::OwnerRole<T0>>(0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::roles::owner_role_mut<T0>(0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::assert_is_compatible<T0>(arg0);
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::two_step_role::begin_role_transfer<0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::roles::OwnerRole<T0>>(0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::roles::owner_role_mut<T0>(0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::assert_is_compatible<T0>(arg0);
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::roles::update_blocklister<T0>(0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::assert_is_compatible<T0>(arg0);
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::roles::update_master_minter<T0>(0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::assert_is_compatible<T0>(arg0);
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::roles::update_metadata_updater<T0>(0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::assert_is_compatible<T0>(arg0);
        0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::roles::update_pauser<T0>(0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

