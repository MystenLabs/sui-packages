module 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::cache {
    struct SubVaultLiquidityCacheCap<phantom T0, phantom T1> {
        active_liquidity: vector<u64>,
        sub_vault_ids: vector<0x2::object::ID>,
        sub_vault_index: u64,
    }

    public fun account_for_extension_liquidity_of_type<T0, T1>(arg0: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::cache::UpdateLiquidityCacheCap<T0>, arg1: SubVaultLiquidityCacheCap<T0, T1>, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config) {
        let v0 = &arg1;
        assert!(v0.sub_vault_index == 0x1::vector::length<0x2::object::ID>(&v0.sub_vault_ids), 13835340732849848323);
        let SubVaultLiquidityCacheCap {
            active_liquidity : v1,
            sub_vault_ids    : _,
            sub_vault_index  : _,
        } = arg1;
        let v4 = 0;
        let v5 = v1;
        0x1::vector::reverse<u64>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v5)) {
            v4 = v4 + 0x1::vector::pop_back<u64>(&mut v5);
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<u64>(v5);
        let v7 = 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key();
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::cache::account_for_extension_liquidity_of_type<T0, T1, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey>(arg0, arg2, &v7, v4);
    }

    public fun account_for_sub_vault_liquidity_of_type<T0, T1, T2>(arg0: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &mut SubVaultLiquidityCacheCap<T0, T2>, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T1>, arg3: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config) {
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg3);
        assert!(0x2::object::id<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T1>>(arg2) == *0x1::vector::borrow<0x2::object::ID>(&arg1.sub_vault_ids, arg1.sub_vault_index), 13835059189153529857);
        let v0 = (0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::total_amount<T1>(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_extension<T0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionMetadataV1>(arg0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key())) as u128);
        let v1 = if (v0 == 0) {
            0
        } else {
            ((v0 * (0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::total_liquidity<T1, T2>(arg2) as u128) / (0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::lp_supply<T1>(arg2) as u128)) as u64)
        };
        let v2 = &mut arg1.sub_vault_index;
        *0x1::vector::borrow_mut<u64>(&mut arg1.active_liquidity, *v2) = v1;
        *v2 = *v2 + 1;
    }

    public fun begin_update_sub_vault_liquidity_cache_tx<T0, T1>(arg0: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::Vault<T0>, arg1: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config) : SubVaultLiquidityCacheCap<T0, T1> {
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::assert_package_version(arg1);
        let v0 = 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::sub_vault_ids(0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::vault::borrow_extension<T0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionKey, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::ExtensionMetadataV1>(arg0, 0x41c98987ea5146805443f5e94c0e66f99656a2d02234c0d9ca0cf5905737eff0::state::create_extension_key()));
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        SubVaultLiquidityCacheCap<T0, T1>{
            active_liquidity : v1,
            sub_vault_ids    : v0,
            sub_vault_index  : 0,
        }
    }

    // decompiled from Move bytecode v6
}

