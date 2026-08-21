module 0xd50d8f8e228270a5d57d2c2c9fda4b83ee0f835bc771e6c858ef814d0bf393c0::cetus_admin_entry {
    public fun migrate(arg0: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xd50d8f8e228270a5d57d2c2c9fda4b83ee0f835bc771e6c858ef814d0bf393c0::cetus_entry::migration_witness();
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::migrate_ext_version<0xd50d8f8e228270a5d57d2c2c9fda4b83ee0f835bc771e6c858ef814d0bf393c0::cetus_entry::CetusLegAuth>(arg0, arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_CETUS(), 0xd50d8f8e228270a5d57d2c2c9fda4b83ee0f835bc771e6c858ef814d0bf393c0::cetus_entry::package_version(), &v0, arg2);
    }

    public fun register_cetus_hasui_leg_auth<T0>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0>, arg2: &0x2::tx_context::TxContext) {
        0xd50d8f8e228270a5d57d2c2c9fda4b83ee0f835bc771e6c858ef814d0bf393c0::cetus_entry::authorize(arg0);
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::register_protocol_leg_auth<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, T0, 0xd50d8f8e228270a5d57d2c2c9fda4b83ee0f835bc771e6c858ef814d0bf393c0::cetus_entry::CetusLegAuth>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_CETUS(), arg2);
    }

    public fun register_cetus_leg_auth<T0>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<0x2::sui::SUI, T0>, arg2: &0x2::tx_context::TxContext) {
        0xd50d8f8e228270a5d57d2c2c9fda4b83ee0f835bc771e6c858ef814d0bf393c0::cetus_entry::authorize(arg0);
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::register_protocol_leg_auth<0x2::sui::SUI, T0, 0xd50d8f8e228270a5d57d2c2c9fda4b83ee0f835bc771e6c858ef814d0bf393c0::cetus_entry::CetusLegAuth>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_CETUS(), arg2);
    }

    // decompiled from Move bytecode v7
}

