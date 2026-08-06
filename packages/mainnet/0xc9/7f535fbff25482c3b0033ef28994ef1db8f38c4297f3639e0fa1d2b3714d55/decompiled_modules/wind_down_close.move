module 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::wind_down_close {
    struct PositionClosedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        debt_repaid: u64,
        collateral_withdrawn: u64,
        flash_swap_repayment: u64,
        final_assets: u64,
    }

    public fun issue_close_position_receipt<T0, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::VaultAcl, arg5: &0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::AggregatorAcl, arg6: &0x2::clock::Clock, arg7: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg7);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_obligation<T0, T1, T2>(arg1, arg2);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg8, arg3, arg2, arg6);
        let (_, v1) = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::info<T0, T1, T2>(arg1, arg2);
        assert!(v1 > 0, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::zero_amount());
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::access(arg4), 0x1::option::some<0x2::object::ID>(0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::access_id(arg5)), arg9);
        let (v3, v4) = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::slippage<T0, T1, T2>(arg1);
        let v5 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::access(arg4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"slippage_up", v3);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"slippage_down", v4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"amount", v1);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"input_type", 0x1::type_name::get<T0>());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"fix_input", false);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"pool_id", 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::pool_id<T0, T1, T2>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"flow_id", 5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"vault_id", 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"expected_debt", v1);
        v2
    }

    public fun process_close_position_receipt<T0: store, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg10: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg11: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg12: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::VaultAcl, arg13: &0x2::clock::Clock, arg14: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg15: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg16: &mut 0x2::tx_context::TxContext) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg14);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_unwinding<T0, T1, T2>(arg1);
        let v0 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::access(arg12);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"flow_id") == 5, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::invalid_flow_id());
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"vault_id");
        assert!(v1 == 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1), 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::invalid_vault());
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"expected_debt");
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"funds");
        assert!(0x2::balance::value<T1>(&v3) == v2, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::slippage_exceeded());
        let v4 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"repay_amount");
        let v5 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::close_position_v2<T0, T1, T2>(arg1, 0x2::coin::from_balance<T1>(v3, arg16), arg15, arg3, arg4, arg6, arg5, arg7, arg8, arg9, arg10, arg11, arg13, arg16);
        let v6 = 0x2::coin::value<T0>(&v5);
        assert!(v6 >= v4, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::slippage_exceeded());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"funds", 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v4, arg16)));
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::join_final_assets<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(v5));
        let v7 = PositionClosedEvent{
            vault_id             : v1,
            debt_repaid          : v2,
            collateral_withdrawn : v6,
            flash_swap_repayment : v4,
            final_assets         : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::final_assets<T0, T1, T2>(arg1),
        };
        0x2::event::emit<PositionClosedEvent>(v7);
    }

    // decompiled from Move bytecode v7
}

