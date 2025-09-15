module 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::assert_is_compatible<T0>(arg0);
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::two_step_role::accept_role<0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::roles::OwnerRole<T0>>(0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::roles::owner_role_mut<T0>(0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::assert_is_compatible<T0>(arg0);
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::two_step_role::begin_role_transfer<0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::roles::OwnerRole<T0>>(0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::roles::owner_role_mut<T0>(0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::assert_is_compatible<T0>(arg0);
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::roles::update_blocklister<T0>(0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::assert_is_compatible<T0>(arg0);
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::roles::update_master_minter<T0>(0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::assert_is_compatible<T0>(arg0);
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::roles::update_metadata_updater<T0>(0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::assert_is_compatible<T0>(arg0);
        0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::roles::update_pauser<T0>(0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

