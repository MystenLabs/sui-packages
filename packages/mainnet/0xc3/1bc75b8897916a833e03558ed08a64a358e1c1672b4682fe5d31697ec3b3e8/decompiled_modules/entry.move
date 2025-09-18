module 0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::assert_is_compatible<T0>(arg0);
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::two_step_role::accept_role<0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::roles::OwnerRole<T0>>(0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::roles::owner_role_mut<T0>(0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::assert_is_compatible<T0>(arg0);
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::two_step_role::begin_role_transfer<0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::roles::OwnerRole<T0>>(0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::roles::owner_role_mut<T0>(0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::assert_is_compatible<T0>(arg0);
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::roles::update_blocklister<T0>(0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::assert_is_compatible<T0>(arg0);
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::roles::update_master_minter<T0>(0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::assert_is_compatible<T0>(arg0);
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::roles::update_metadata_updater<T0>(0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::assert_is_compatible<T0>(arg0);
        0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::roles::update_pauser<T0>(0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

