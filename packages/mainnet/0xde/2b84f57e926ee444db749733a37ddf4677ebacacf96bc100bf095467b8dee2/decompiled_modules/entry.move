module 0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::assert_is_compatible<T0>(arg0);
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::two_step_role::accept_role<0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::roles::OwnerRole<T0>>(0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::roles::owner_role_mut<T0>(0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::assert_is_compatible<T0>(arg0);
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::two_step_role::begin_role_transfer<0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::roles::OwnerRole<T0>>(0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::roles::owner_role_mut<T0>(0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::assert_is_compatible<T0>(arg0);
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::roles::update_blocklister<T0>(0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::assert_is_compatible<T0>(arg0);
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::roles::update_master_minter<T0>(0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::assert_is_compatible<T0>(arg0);
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::roles::update_metadata_updater<T0>(0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::assert_is_compatible<T0>(arg0);
        0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::roles::update_pauser<T0>(0xde2b84f57e926ee444db749733a37ddf4677ebacacf96bc100bf095467b8dee2::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

