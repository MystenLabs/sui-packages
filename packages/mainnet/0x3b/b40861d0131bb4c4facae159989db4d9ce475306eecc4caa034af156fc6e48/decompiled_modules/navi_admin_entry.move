module 0x3bb40861d0131bb4c4facae159989db4d9ce475306eecc4caa034af156fc6e48::navi_admin_entry {
    public fun init_navi_account_cap<T0, T1>(arg0: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &mut 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::VaultPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x3bb40861d0131bb4c4facae159989db4d9ce475306eecc4caa034af156fc6e48::navi_entry::authorize(arg0);
        let v0 = 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::navi_account_cap_key();
        assert!(!0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::has_protocol_cap<T0, T1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::NaviAccountCapKey>(arg1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_strategy::PROTOCOL_NAVI(), v0), 1);
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::store_protocol_cap<T0, T1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_strategy::PROTOCOL_NAVI(), v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2), arg2);
    }

    public fun migrate(arg0: &mut 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x3bb40861d0131bb4c4facae159989db4d9ce475306eecc4caa034af156fc6e48::navi_entry::migration_witness();
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::migrate_ext_version<0x3bb40861d0131bb4c4facae159989db4d9ce475306eecc4caa034af156fc6e48::navi_entry::NaviLegAuth>(arg0, arg1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_strategy::PROTOCOL_NAVI(), 0x3bb40861d0131bb4c4facae159989db4d9ce475306eecc4caa034af156fc6e48::navi_entry::package_version(), &v0, arg2);
    }

    public fun register_navi_leg_auth<T0, T1>(arg0: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &mut 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::VaultPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x3bb40861d0131bb4c4facae159989db4d9ce475306eecc4caa034af156fc6e48::navi_entry::authorize(arg0);
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::register_protocol_leg_auth<T0, T1, 0x3bb40861d0131bb4c4facae159989db4d9ce475306eecc4caa034af156fc6e48::navi_entry::NaviLegAuth>(arg1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_strategy::PROTOCOL_NAVI(), arg2);
    }

    // decompiled from Move bytecode v7
}

