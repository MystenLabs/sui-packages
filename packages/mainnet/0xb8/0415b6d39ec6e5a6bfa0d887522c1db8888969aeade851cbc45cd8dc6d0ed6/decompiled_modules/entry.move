module 0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::assert_is_compatible<T0>(arg0);
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::two_step_role::accept_role<0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::roles::OwnerRole<T0>>(0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::roles::owner_role_mut<T0>(0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::assert_is_compatible<T0>(arg0);
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::two_step_role::begin_role_transfer<0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::roles::OwnerRole<T0>>(0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::roles::owner_role_mut<T0>(0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::assert_is_compatible<T0>(arg0);
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::roles::update_blocklister<T0>(0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::assert_is_compatible<T0>(arg0);
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::roles::update_master_minter<T0>(0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::assert_is_compatible<T0>(arg0);
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::roles::update_metadata_updater<T0>(0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::assert_is_compatible<T0>(arg0);
        0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::roles::update_pauser<T0>(0xb80415b6d39ec6e5a6bfa0d887522c1db8888969aeade851cbc45cd8dc6d0ed6::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

