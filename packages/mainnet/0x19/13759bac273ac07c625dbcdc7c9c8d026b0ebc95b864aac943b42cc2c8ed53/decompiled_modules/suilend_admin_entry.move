module 0x1913759bac273ac07c625dbcdc7c9c8d026b0ebc95b864aac943b42cc2c8ed53::suilend_admin_entry {
    public fun init_suilend_obligation<T0, T1, T2>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x1913759bac273ac07c625dbcdc7c9c8d026b0ebc95b864aac943b42cc2c8ed53::suilend_entry::authorize(arg0);
        assert!(!0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::has_protocol_cap<T1, T2, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::SuilendObligationCapKey>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_SUILEND(), 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::suilend_obligation_cap_key()), 1);
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_validation::validate_suilend_config<T1, T2>(arg1, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), arg3);
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::store_protocol_cap<T1, T2, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_SUILEND(), 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::suilend_obligation_cap_key(), 0x1913759bac273ac07c625dbcdc7c9c8d026b0ebc95b864aac943b42cc2c8ed53::suilend_adapter::create_obligation<T0>(arg2, arg4), arg4);
    }

    public fun migrate(arg0: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1913759bac273ac07c625dbcdc7c9c8d026b0ebc95b864aac943b42cc2c8ed53::suilend_entry::migration_witness();
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::migrate_ext_version<0x1913759bac273ac07c625dbcdc7c9c8d026b0ebc95b864aac943b42cc2c8ed53::suilend_entry::SuilendLegAuth>(arg0, arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_SUILEND(), 0x1913759bac273ac07c625dbcdc7c9c8d026b0ebc95b864aac943b42cc2c8ed53::suilend_entry::package_version(), &v0, arg2);
    }

    public fun register_suilend_leg_auth<T0, T1>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x1913759bac273ac07c625dbcdc7c9c8d026b0ebc95b864aac943b42cc2c8ed53::suilend_entry::authorize(arg0);
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::register_protocol_leg_auth<T0, T1, 0x1913759bac273ac07c625dbcdc7c9c8d026b0ebc95b864aac943b42cc2c8ed53::suilend_entry::SuilendLegAuth>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_SUILEND(), arg2);
    }

    // decompiled from Move bytecode v7
}

