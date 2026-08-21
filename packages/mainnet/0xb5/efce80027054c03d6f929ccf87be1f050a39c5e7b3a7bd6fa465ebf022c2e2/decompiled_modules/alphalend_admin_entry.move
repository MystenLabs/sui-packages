module 0xb5efce80027054c03d6f929ccf87be1f050a39c5e7b3a7bd6fa465ebf022c2e2::alphalend_admin_entry {
    public fun init_alphalend_position_cap<T0, T1>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5efce80027054c03d6f929ccf87be1f050a39c5e7b3a7bd6fa465ebf022c2e2::alphalend_entry::authorize(arg0);
        let v0 = 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::alphalend_position_cap_key();
        assert!(!0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::has_protocol_cap<T0, T1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::AlphaLendPositionCapKey>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_ALPHALEND(), v0), 1);
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_validation::validate_alphalend_protocol<T0, T1>(arg1, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2));
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::store_protocol_cap<T0, T1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_ALPHALEND(), v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg2, arg3), arg3);
    }

    public fun migrate(arg0: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xb5efce80027054c03d6f929ccf87be1f050a39c5e7b3a7bd6fa465ebf022c2e2::alphalend_entry::migration_witness();
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::migrate_ext_version<0xb5efce80027054c03d6f929ccf87be1f050a39c5e7b3a7bd6fa465ebf022c2e2::alphalend_entry::AlphaLendLegAuth>(arg0, arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_ALPHALEND(), 0xb5efce80027054c03d6f929ccf87be1f050a39c5e7b3a7bd6fa465ebf022c2e2::alphalend_entry::package_version(), &v0, arg2);
    }

    public fun register_alphalend_leg_auth<T0, T1>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0xb5efce80027054c03d6f929ccf87be1f050a39c5e7b3a7bd6fa465ebf022c2e2::alphalend_entry::authorize(arg0);
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::register_protocol_leg_auth<T0, T1, 0xb5efce80027054c03d6f929ccf87be1f050a39c5e7b3a7bd6fa465ebf022c2e2::alphalend_entry::AlphaLendLegAuth>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_ALPHALEND(), arg2);
    }

    // decompiled from Move bytecode v7
}

