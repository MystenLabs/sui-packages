module 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::withdraw {
    struct WithdrawEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        user: address,
        lp_shares_burned: u64,
        amount_out: u64,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
    }

    fun get_withdraw_flash_swap_amount(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u256) * (((arg0 as u64) - 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::leverage_scaling()) as u256) / (0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::leverage_scaling() as u256)) as u64)
    }

    public fun get_withdraw_receipt<T0, T1, T2>(arg0: &0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::VaultAcl, arg3: &0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::AggregatorAcl, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg7: &0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::CoinDecimalsRegistry, arg8: &0x2::clock::Clock, arg9: &0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::version::Version, arg10: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg11: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::version::assert_current_version(arg9);
        0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::assert_vault_obligation<T0, T1, T2>(arg0, arg4);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg10, arg5, arg4, arg8);
        let v0 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg2), 0x1::option::some<0x2::object::ID>(0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::access_id(arg3)), arg11);
        let v1 = vt_shares_to_underlying_a<T0, T1, T2>(arg0, arg6, arg7, arg4, 0x2::coin::value<T2>(&arg1), arg8);
        let (v2, v3) = 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::slippage<T0, T1, T2>(arg0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(&mut v0, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg2), b"slippage_up", v2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(&mut v0, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg2), b"slippage_down", v3);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T2>, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(&mut v0, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg2), b"vt_balance", 0x2::coin::into_balance<T2>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(&mut v0, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg2), b"withdraw_amount", v1);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(&mut v0, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg2), b"amount", get_withdraw_flash_swap_amount(0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::utils::get_cur_leverage<T0, T1, T2>(arg0, arg6, arg7, arg4, arg8), v1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(&mut v0, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg2), b"input_type", 0x1::type_name::get<T0>());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(&mut v0, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg2), b"fix_input", true);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(&mut v0, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg2), b"pool_id", 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::pool_id<T0, T1, T2>(arg0));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(&mut v0, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg2), b"flow_id", 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::utils::withdraw_flow_id());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(&mut v0, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg2), b"vault_id", 0x2::object::id<0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::Vault<T0, T1, T2>>(arg0));
        v0
    }

    public fun process_withdraw_receipt<T0, T1, T2>(arg0: &mut 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::Vault<T0, T1, T2>, arg1: &0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::VaultAcl, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg8: &0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::CoinDecimalsRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg13: &0x2::clock::Clock, arg14: &0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::version::Version, arg15: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg16: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::version::assert_current_version(arg14);
        let v0 = 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg1);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(arg2, v0, b"flow_id") == 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::utils::withdraw_flow_id(), 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::error::invalid_flow_id());
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(arg2, v0, b"vault_id") == 0x2::object::id<0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::Vault<T0, T1, T2>>(arg0), 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::error::invalid_vault());
        let v1 = 0x2::coin::from_balance<T2>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T2>, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(arg2, v0, b"vt_balance"), arg16);
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(arg2, v0, b"repay_amount");
        let v3 = 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::withdraw<T0, T1, T2>(arg0, 0x2::coin::from_balance<T1>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(arg2, v0, b"funds"), arg16), v2 + 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(arg2, v0, b"withdraw_amount"), arg15, arg3, arg4, arg6, arg5, arg9, arg10, arg11, arg12, arg13, arg16);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::Access>(arg2, 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault_acl::access(arg1), b"funds", 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v2, arg16)));
        0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::burn_vt<T0, T1, T2>(arg0, v1);
        let (v4, v5) = 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::withdrawal_fees<T0, T1, T2>(arg0);
        0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::collect_fees<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, (((0x2::coin::value<T0>(&v3) as u256) * (v4 as u256) / (v5 as u256)) as u64), arg16)));
        let (v6, v7, v8) = 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::utils::calc_aum<T0, T1, T2>(arg0, arg7, arg8, arg3, arg13);
        let v9 = WithdrawEvent{
            vault_id          : 0x2::object::id<0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::Vault<T0, T1, T2>>(arg0),
            user              : 0x2::tx_context::sender(arg16),
            lp_shares_burned  : 0x2::coin::value<T2>(&v1),
            amount_out        : 0x2::coin::value<T0>(&v3),
            total_deposited_a : v7,
            total_borrowed_b  : v8,
            aum_in_a          : v6,
            total_lp_supply   : 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v9);
        v3
    }

    fun vt_shares_to_underlying_a<T0, T1, T2>(arg0: &0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::Vault<T0, T1, T2>, arg1: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg2: &0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::CoinDecimalsRegistry, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        let v0 = 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::vault::total_vt_supply<T0, T1, T2>(arg0);
        if (v0 == 0) {
            return arg4
        };
        let (v1, _, _) = 0x655b196d3874d74ae8578db45abaadc15affd278bdcb7972e5db0e33f0cd0eb7::utils::calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5);
        (((arg4 as u256) * (v1 as u256) / (v0 as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

