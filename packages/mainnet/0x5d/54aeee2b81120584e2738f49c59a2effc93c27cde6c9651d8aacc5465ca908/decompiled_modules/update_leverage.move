module 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::update_leverage {
    struct LeverageUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
        new_leverage: u64,
    }

    fun calc_update_leverage_params<T0, T1, T2>(arg0: &0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::Vault<T0, T1, T2>, arg1: u64, arg2: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg3: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x2::clock::Clock) : (u64, bool) {
        assert!(arg1 >= 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::leverage_scaling(), 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::error::invalid_leverage());
        let (v0, _, _) = 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::utils::calc_aum<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5);
        let v3 = 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::utils::get_cur_leverage<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5);
        assert!(v3 != arg1, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::error::invalid_leverage());
        assert!(0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::leverage<T0, T1, T2>(arg0) != arg1, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::error::invalid_leverage());
        if (arg1 > v3) {
            (((((arg1 - v3) as u256) * (v0 as u256) / (0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::leverage_scaling() as u256)) as u64), true)
        } else {
            (((((arg1 - v3) as u256) * (v0 as u256) / (0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::leverage_scaling() as u256)) as u64), false)
        }
    }

    public fun get_update_leverage_receipt<T0, T1, T2>(arg0: &0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::VaultCap, arg1: &0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg5: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg6: &0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::VaultAcl, arg7: &0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::AggregatorAcl, arg8: &0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::version::Version, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::version::assert_current_version(arg8);
        0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::assert_vault_obligation<T0, T1, T2>(arg1, arg3);
        0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        let v0 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), 0x1::option::some<0x2::object::ID>(0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::access_id(arg7)), arg10);
        let (v1, v2) = calc_update_leverage_params<T0, T1, T2>(arg1, arg2, arg4, arg5, arg3, arg9);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(&mut v0, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), b"is_deposit", v2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(&mut v0, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), b"slippage", 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::slippage<T0, T1, T2>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(&mut v0, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), b"pool_id", 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::pool_id<T0, T1, T2>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(&mut v0, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), b"new_leverage", arg2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(&mut v0, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), b"flow_id", 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::utils::update_leverage_flow_id());
        if (v2) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(&mut v0, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), b"input_type", 0x1::type_name::get<T1>());
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(&mut v0, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), b"fix_input", false);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(&mut v0, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), b"amount", v1);
        } else {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(&mut v0, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), b"input_type", 0x1::type_name::get<T0>());
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(&mut v0, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), b"fix_input", true);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(&mut v0, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg6), b"amount", v1);
        };
        v0
    }

    public fun process_update_leverage_receipt<T0, T1, T2>(arg0: &0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::VaultCap, arg1: &mut 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::Vault<T0, T1, T2>, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg6: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg7: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg11: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg12: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg13: &0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::VaultAcl, arg14: &0x2::clock::Clock, arg15: &0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::version::Version, arg16: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::version::assert_current_version(arg15);
        0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::assert_vault_obligation<T0, T1, T2>(arg1, arg4);
        let v0 = 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg13);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(arg2, v0, b"flow_id") == 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::utils::update_leverage_flow_id(), 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::error::invalid_flow_id());
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(arg2, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg13), b"new_leverage");
        if (0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, bool, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(arg2, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg13), b"is_deposit")) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T1>, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(arg2, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg13), b"funds", 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::deposit<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(arg2, v0, b"funds"), arg17), arg16, arg4, arg3, arg10, arg9, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(arg2, v0, b"repay_amount"), arg5, arg6, arg7, arg8, arg14, arg17));
        } else {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(arg2, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::access(arg13), b"funds", 0x2::coin::into_balance<T0>(0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::withdraw<T0, T1, T2>(arg1, 0x2::coin::from_balance<T1>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(arg2, v0, b"funds"), arg17), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault_acl::Access>(arg2, v0, b"repay_amount"), arg16, arg4, arg3, arg10, arg9, arg5, arg6, arg7, arg8, arg14, arg17)));
        };
        0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::update_leverage<T0, T1, T2>(arg1, v1);
        let (v2, v3, v4) = 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::utils::calc_aum<T0, T1, T2>(arg1, arg11, arg12, arg4, arg14);
        let v5 = LeverageUpdatedEvent{
            vault_id          : 0x2::object::id<0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::Vault<T0, T1, T2>>(arg1),
            total_deposited_a : v3,
            total_borrowed_b  : v4,
            aum_in_a          : v2,
            total_lp_supply   : 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::vault::total_vt_supply<T0, T1, T2>(arg1),
            new_leverage      : v1,
        };
        0x2::event::emit<LeverageUpdatedEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

