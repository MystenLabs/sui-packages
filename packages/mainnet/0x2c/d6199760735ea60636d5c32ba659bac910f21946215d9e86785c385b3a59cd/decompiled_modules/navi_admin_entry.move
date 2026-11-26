module 0x9d413ab9ae6cb58ba1189de65ac39b201a5ada39018840ee88ecfe25a856923e::navi_admin_entry {
    public fun init_navi_account_cap<T0, T1>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x9d413ab9ae6cb58ba1189de65ac39b201a5ada39018840ee88ecfe25a856923e::navi_entry::authorize(arg0);
        let v0 = 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::navi_account_cap_key();
        assert!(!0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::has_protocol_cap<T0, T1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::NaviAccountCapKey>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_NAVI(), v0), 1);
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::store_protocol_cap<T0, T1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_NAVI(), v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2), arg2);
    }

    public fun migrate(arg0: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x9d413ab9ae6cb58ba1189de65ac39b201a5ada39018840ee88ecfe25a856923e::navi_entry::migration_witness();
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::migrate_ext_version<0x9d413ab9ae6cb58ba1189de65ac39b201a5ada39018840ee88ecfe25a856923e::navi_entry::NaviLegAuth>(arg0, arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_NAVI(), 0x9d413ab9ae6cb58ba1189de65ac39b201a5ada39018840ee88ecfe25a856923e::navi_entry::package_version(), &v0, arg2);
    }

    public fun register_navi_leg_auth<T0, T1>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x9d413ab9ae6cb58ba1189de65ac39b201a5ada39018840ee88ecfe25a856923e::navi_entry::authorize(arg0);
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::register_protocol_leg_auth<T0, T1, 0x9d413ab9ae6cb58ba1189de65ac39b201a5ada39018840ee88ecfe25a856923e::navi_entry::NaviLegAuth>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_NAVI(), arg2);
    }

    // decompiled from Move bytecode v7
}

