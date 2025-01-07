module 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::withdraw {
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
        (((arg1 as u256) * (((arg0 as u64) - 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::leverage_scaling()) as u256) / (0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::leverage_scaling() as u256)) as u64)
    }

    public fun get_withdraw_receipt<T0, T1, T2>(arg0: &0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::VaultAcl, arg3: &0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::AggregatorAcl, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg7: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg8: &0x2::clock::Clock, arg9: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg10: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg9, arg5, arg4, arg8);
        let v0 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::access(arg2), 0x1::option::some<0x2::object::ID>(0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::access_id(arg3)), arg10);
        let v1 = vt_shares_to_underlying_a<T0, T1, T2>(arg0, arg6, arg7, arg4, 0x2::coin::value<T2>(&arg1), arg8);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T2>, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(&mut v0, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::access(arg2), b"vt_balance", 0x2::coin::into_balance<T2>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(&mut v0, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::access(arg2), b"withdraw_amount", v1);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(&mut v0, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::access(arg2), b"amount", get_withdraw_flash_swap_amount(0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::utils::get_cur_leverage<T0, T1, T2>(arg0, arg6, arg7, arg4, arg8), v1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(&mut v0, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::access(arg2), b"input_type", 0x1::type_name::get<T0>());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(&mut v0, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::access(arg2), b"fix_input", true);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(&mut v0, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::access(arg2), b"slippage", 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::slippage<T0, T1, T2>(arg0));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(&mut v0, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::access(arg2), b"pool_id", 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::pool_id<T0, T1, T2>(arg0));
        v0
    }

    public fun process_withdraw_receipt<T0, T1, T2>(arg0: &mut 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::Vault<T0, T1, T2>, arg1: &0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::VaultAcl, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg8: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg13: &0x2::clock::Clock, arg14: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::access(arg1);
        let v1 = 0x2::coin::from_balance<T2>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T2>, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(arg2, v0, b"vt_balance"), arg15);
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(arg2, v0, b"repay_amount");
        let v3 = 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::withdraw<T0, T1, T2>(arg0, 0x2::coin::from_balance<T1>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(arg2, v0, b"funds"), arg15), v2 + 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(arg2, v0, b"withdraw_amount"), arg14, arg3, arg4, arg6, arg5, arg9, arg10, arg11, arg12, arg13, arg15);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::Access>(arg2, 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault_acl::access(arg1), b"funds", 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v2, arg15)));
        0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::burn_vt<T0, T1, T2>(arg0, v1);
        let (v4, v5) = 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::withdrawal_fees<T0, T1, T2>(arg0);
        0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::collect_fees<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, (((0x2::coin::value<T0>(&v3) as u256) * (v4 as u256) / (v5 as u256)) as u64), arg15)));
        let (v6, v7, v8) = 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::utils::calc_aum<T0, T1, T2>(arg0, arg7, arg8, arg3, arg13);
        let v9 = WithdrawEvent{
            vault_id          : 0x2::object::id<0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::Vault<T0, T1, T2>>(arg0),
            user              : 0x2::tx_context::sender(arg15),
            lp_shares_burned  : 0x2::coin::value<T2>(&v1),
            amount_out        : 0x2::coin::value<T0>(&v3),
            total_deposited_a : v7,
            total_borrowed_b  : v8,
            aum_in_a          : v6,
            total_lp_supply   : 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v9);
        v3
    }

    fun vt_shares_to_underlying_a<T0, T1, T2>(arg0: &0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::Vault<T0, T1, T2>, arg1: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg2: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        let v0 = 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::vault::total_vt_supply<T0, T1, T2>(arg0);
        if (v0 == 0) {
            return arg4
        };
        let (v1, _, _) = 0x49e9a72210f943f2637768793f122e7564345a664af800ac4565b15dfbe4ecf8::utils::calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5);
        (((arg4 as u256) * (v1 as u256) / (v0 as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

