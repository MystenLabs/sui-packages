module 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::harvest {
    struct RewardsHarvestedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
    }

    public fun consume_harvest_deposit_receipt<T0, T1, T2>(arg0: &mut 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault::Vault<T0, T1, T2>, arg1: &0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::VaultAcl, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg8: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg13: &0x2::clock::Clock, arg14: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg15: &mut 0x2::tx_context::TxContext) {
        0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault::burn_vt<T0, T1, T2>(arg0, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::deposit::process_deposit_receipt<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15));
        let (v0, v1, v2) = 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::utils::calc_aum<T0, T1, T2>(arg0, arg7, arg8, arg4, arg13);
        let v3 = RewardsHarvestedEvent{
            vault_id          : 0x2::object::id<0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault::Vault<T0, T1, T2>>(arg0),
            total_deposited_a : v1,
            total_borrowed_b  : v2,
            aum_in_a          : v0,
            total_lp_supply   : 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<RewardsHarvestedEvent>(v3);
    }

    public fun consume_harvest_receipt<T0, T1, T2>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault::Vault<T0, T1, T2>, arg2: &0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::VaultAcl, arg3: &0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::AggregatorAcl, arg4: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::Access>(&mut arg0, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::access(arg2), b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::Access>(&mut arg0, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::access(arg2), b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
        0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::deposit::get_deposit_receipt<T0, T1, T2>(arg1, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::Access>(&mut arg0, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::access(arg2), b"funds"), arg2, arg3, arg4)
    }

    public fun issue_harvest_receipt<T0, T1, T2, T3>(arg0: &mut 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault::Vault<T0, T1, T2>, arg1: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg2: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::VaultAcl, arg6: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        let v0 = 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault::get_swap_route<T0, T1, T2, T3>(arg0);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::Access>(0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::access(arg5), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg6)), arg8);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T3>, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::Access>(&mut v1, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::access(arg5), b"funds", 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::redeem_rewards<T3>(arg1, arg2, arg3, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault::obligation_key_mut<T0, T1, T2>(arg0), arg4, arg7, arg8));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::Access>(&mut v1, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::access(arg5), b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::Access>(&mut v1, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::access(arg5), b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v0) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v0)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::Access>(&mut v1, 0x914f2fb2a6b6b7751ad180515038489149160fe1eaf22221887677674f71fa2e::vault_acl::access(arg5), (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v0) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v0));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

