module 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::vault {
    public fun add_extension<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::Config, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg4: &mut 0x2::tx_context::TxContext) {
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::assert_package_version(arg2);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::add_extension<T0, T1, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionMetadataV1>(arg0, arg1, arg3, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key(), 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::new(arg4), true);
    }

    public fun remove_extension<T0, T1, T2>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T2>, arg3: &0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::Config, arg4: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config) {
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg4);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::destroy(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::remove_extension<T0, T1, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionMetadataV1>(arg0, arg1, arg4, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key()));
    }

    public fun add_sub_vault<T0, T1, T2>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T2>, arg3: &0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::Config, arg4: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg5: &mut 0x2::tx_context::TxContext) {
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg4);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        assert!(!0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::supports_extension<T2, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey>(arg2, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key()), 13835059678779801601);
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::add_sub_vault<T2>(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionMetadataV1>(arg0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key()), arg2, arg5);
    }

    public fun crank_unlocks<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x2::clock::Clock) {
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::crank_unlocks<T1>(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionMetadataV1>(arg0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key()), arg1);
    }

    public fun admin_deposit_into_extension<T0, T1, T2, T3>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::SessionCap<T2>, arg3: &0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::Config, arg4: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg4);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key();
        let v1 = 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::admin_withdraw<T0, T1, T3, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey>(arg0, arg1, arg4, v0, arg5, arg7);
        let v2 = 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionMetadataV1>(arg0, v0);
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::crank_unlocks<T2>(v2, arg6);
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::join<T2>(v2, 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::deposit<T2, T3>(arg2, arg4, v1, arg6, arg7), 0x2::coin::value<T3>(&v1), arg6);
    }

    public fun admin_withdraw_from_extension<T0, T1, T2, T3>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::VAULT<T0>, T1>, arg2: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::SessionCap<T2>, arg3: &0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::Config, arg4: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::config::assert_package_version(arg3);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg4);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::assert_is_admin_or_assistant<T1>();
        let v0 = 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key();
        let v1 = 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_mut_extension<T0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionMetadataV1>(arg0, v0);
        0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::crank_unlocks<T2>(v1, arg6);
        assert!(arg5 <= 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::total_unlocked_amount<T2>(v1), 13835340994842853379);
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::admin_deposit<T0, T1, T3, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey>(arg0, arg1, arg4, v0, 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::session::withdraw<T2, T3>(arg2, arg4, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::split<T2>(v1, arg5, arg7), arg6, arg7));
    }

    // decompiled from Move bytecode v6
}

