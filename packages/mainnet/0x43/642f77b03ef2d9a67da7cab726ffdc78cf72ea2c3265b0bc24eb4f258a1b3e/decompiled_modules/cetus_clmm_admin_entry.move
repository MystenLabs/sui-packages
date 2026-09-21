module 0x5fda60509376e0d9c6db81032f5cedf7d34345041771cbe46be971b472a5c629::cetus_clmm_admin_entry {
    public fun force_refresh_base<T0, T1>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::assert_pool_admin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>(arg1, 0x2::tx_context::sender(arg6));
        let (v0, v1) = 0x5fda60509376e0d9c6db81032f5cedf7d34345041771cbe46be971b472a5c629::cetus_clmm_entry::observe_base_quote<T0, T1>(arg1, arg2, arg3, arg4);
        0x5fda60509376e0d9c6db81032f5cedf7d34345041771cbe46be971b472a5c629::cetus_clmm_entry::force_refresh_quote_value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T1>(arg0, arg1, v0, v1, arg5, arg6);
    }

    public fun force_refresh_lst<T0, T1>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::assert_pool_admin<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>(arg1, 0x2::tx_context::sender(arg6));
        let (v0, v1) = 0x5fda60509376e0d9c6db81032f5cedf7d34345041771cbe46be971b472a5c629::cetus_clmm_entry::observe_lst_quote<T0, T1>(arg1, arg2, arg3, arg4);
        0x5fda60509376e0d9c6db81032f5cedf7d34345041771cbe46be971b472a5c629::cetus_clmm_entry::force_refresh_quote_value<0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::hawal::HAWAL, T1>(arg0, arg1, v0, v1, arg5, arg6);
    }

    public fun migrate(arg0: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x5fda60509376e0d9c6db81032f5cedf7d34345041771cbe46be971b472a5c629::cetus_clmm_entry::migration_witness();
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::migrate_ext_version<0x5fda60509376e0d9c6db81032f5cedf7d34345041771cbe46be971b472a5c629::cetus_clmm_entry::CetusClmmLegAuth>(arg0, arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_CETUS_CLMM(), 0x5fda60509376e0d9c6db81032f5cedf7d34345041771cbe46be971b472a5c629::cetus_clmm_entry::package_version(), &v0, arg2);
    }

    public fun register_leg_auth<T0, T1>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_admin::VaultGlobal, arg1: &mut 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x5fda60509376e0d9c6db81032f5cedf7d34345041771cbe46be971b472a5c629::cetus_clmm_entry::authorize(arg0);
        0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::register_protocol_leg_auth<T0, T1, 0x5fda60509376e0d9c6db81032f5cedf7d34345041771cbe46be971b472a5c629::cetus_clmm_entry::CetusClmmLegAuth>(arg1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_CETUS_CLMM(), arg2);
    }

    // decompiled from Move bytecode v7
}

