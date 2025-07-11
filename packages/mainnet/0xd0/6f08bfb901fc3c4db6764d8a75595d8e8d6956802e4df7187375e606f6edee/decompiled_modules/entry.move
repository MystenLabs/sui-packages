module 0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::assert_is_compatible<T0>(arg0);
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::two_step_role::accept_role<0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::roles::OwnerRole<T0>>(0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::roles::owner_role_mut<T0>(0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::assert_is_compatible<T0>(arg0);
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::two_step_role::begin_role_transfer<0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::roles::OwnerRole<T0>>(0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::roles::owner_role_mut<T0>(0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::assert_is_compatible<T0>(arg0);
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::roles::update_blocklister<T0>(0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::assert_is_compatible<T0>(arg0);
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::roles::update_master_minter<T0>(0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::assert_is_compatible<T0>(arg0);
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::roles::update_metadata_updater<T0>(0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::assert_is_compatible<T0>(arg0);
        0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::roles::update_pauser<T0>(0xd06f08bfb901fc3c4db6764d8a75595d8e8d6956802e4df7187375e606f6edee::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

