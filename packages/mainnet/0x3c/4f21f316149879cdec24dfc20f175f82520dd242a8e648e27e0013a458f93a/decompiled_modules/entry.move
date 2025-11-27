module 0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::assert_is_compatible<T0>(arg0);
        0xaee66d8555b18e3229269d273c0bdb58a86a879434b36ac1527491bc27def5db::two_step_role::accept_role<0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::roles::OwnerRole<T0>>(0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::roles::owner_role_mut<T0>(0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::assert_is_compatible<T0>(arg0);
        0xaee66d8555b18e3229269d273c0bdb58a86a879434b36ac1527491bc27def5db::two_step_role::begin_role_transfer<0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::roles::OwnerRole<T0>>(0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::roles::owner_role_mut<T0>(0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::assert_is_compatible<T0>(arg0);
        0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::roles::update_blocklister<T0>(0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::assert_is_compatible<T0>(arg0);
        0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::roles::update_master_minter<T0>(0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::assert_is_compatible<T0>(arg0);
        0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::roles::update_metadata_updater<T0>(0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::assert_is_compatible<T0>(arg0);
        0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::roles::update_pauser<T0>(0x3c4f21f316149879cdec24dfc20f175f82520dd242a8e648e27e0013a458f93a::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

