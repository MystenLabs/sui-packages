module 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::update_leverage {
    struct LeverageUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
        new_leverage: u64,
    }

    fun calc_update_leverage_params<T0, T1, T2>(arg0: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::Vault<T0, T1, T2>, arg1: u64, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg5: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &0x2::clock::Clock) : (u64, bool) {
        assert!(arg1 >= 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::leverage_scaling(), 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::error::invalid_leverage());
        let (v0, _, _) = 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::utils::calc_aum<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        let v3 = 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::utils::get_cur_leverage<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        assert!(v3 != arg1, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::error::invalid_leverage());
        assert!(0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::leverage<T0, T1, T2>(arg0) != arg1, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::error::invalid_leverage());
        if (arg1 > v3) {
            (((((arg1 - v3) as u256) * (v0 as u256) / (0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::leverage_scaling() as u256)) as u64), true)
        } else {
            (((((arg1 - v3) as u256) * (v0 as u256) / (0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::leverage_scaling() as u256)) as u64), false)
        }
    }

    public fun get_update_leverage_receipt<T0, T1, T2>(arg0: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::VaultCap, arg1: &mut 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg7: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg8: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::VaultAcl, arg9: &0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::AggregatorAcl, arg10: &0x2::clock::Clock, arg11: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::version::Version, arg12: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::version::assert_current_version(arg11);
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        let v0 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), 0x1::option::some<0x2::object::ID>(0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::access_id(arg9)), arg12);
        let (v1, v2) = calc_update_leverage_params<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6, arg7, arg3, arg10);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(&mut v0, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), b"is_deposit", v2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(&mut v0, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), b"slippage", 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::slippage<T0, T1, T2>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(&mut v0, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), b"pool_id", 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::pool_id<T0, T1, T2>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(&mut v0, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), b"new_leverage", arg2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(&mut v0, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), b"flow_id", 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::utils::update_leverage_flow_id());
        if (v2) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(&mut v0, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), b"input_type", 0x1::type_name::get<T1>());
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(&mut v0, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), b"fix_input", false);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(&mut v0, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), b"amount", v1);
        } else {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(&mut v0, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), b"input_type", 0x1::type_name::get<T0>());
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(&mut v0, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), b"fix_input", true);
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(&mut v0, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg8), b"amount", v1);
        };
        v0
    }

    public fun process_update_leverage_receipt<T0, T1, T2>(arg0: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::VaultCap, arg1: &mut 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::Vault<T0, T1, T2>, arg2: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::VaultAcl, arg3: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg11: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg12: &0x2::clock::Clock, arg13: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::version::Version, arg14: &mut 0x2::tx_context::TxContext) {
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::version::assert_current_version(arg13);
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        let v0 = 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg2);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(arg3, v0, b"flow_id") == 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::utils::update_leverage_flow_id(), 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::error::invalid_flow_id());
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(arg3, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg2), b"new_leverage");
        if (0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, bool, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(arg3, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg2), b"is_deposit")) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T1>, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(arg3, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg2), b"funds", 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::deposit<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(arg3, v0, b"funds"), arg14), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(arg3, v0, b"repay_amount"), arg4, arg5, arg6, arg7, arg8, arg9, arg12));
        } else {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(arg3, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::access(arg2), b"funds", 0x2::coin::into_balance<T0>(0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::withdraw<T0, T1, T2>(arg1, 0x2::coin::from_balance<T1>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(arg3, v0, b"funds"), arg14), 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault_acl::Access>(arg3, v0, b"repay_amount"), arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg14)));
        };
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::update_leverage<T0, T1, T2>(arg1, v1);
        let (v2, v3, v4) = 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::utils::calc_aum<T0, T1, T2>(arg1, arg5, arg6, arg10, arg11, arg4, arg12);
        let v5 = LeverageUpdatedEvent{
            vault_id          : 0x2::object::id<0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::Vault<T0, T1, T2>>(arg1),
            total_deposited_a : v3,
            total_borrowed_b  : v4,
            aum_in_a          : v2,
            total_lp_supply   : 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::total_vt_supply<T0, T1, T2>(arg1),
            new_leverage      : v1,
        };
        0x2::event::emit<LeverageUpdatedEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

