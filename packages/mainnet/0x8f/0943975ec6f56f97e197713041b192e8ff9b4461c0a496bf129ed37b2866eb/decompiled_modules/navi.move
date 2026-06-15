module 0x8f0943975ec6f56f97e197713041b192e8ff9b4461c0a496bf129ed37b2866eb::navi {
    struct NaviPoolCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NaviVaultCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NaviPoolPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NaviVaultPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NaviPosition has store {
        deposited_value: u64,
    }

    struct NaviInvested has copy, drop {
        object_id: 0x2::object::ID,
        amount: u64,
    }

    struct NaviReturned has copy, drop {
        object_id: 0x2::object::ID,
        gross: u64,
        yield_fee: u64,
        net: u64,
    }

    public fun cover_claim_from_navi<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg7: &0x2::clock::Clock, arg8: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg9: u8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::claimable_amount<T0>(arg0, 0x2::tx_context::sender(arg11), arg7);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::balance_value<T0>(arg0);
        if (v1 < v0) {
            let v2 = v0 - v1;
            let v3 = if (v2 < arg10) {
                v2
            } else {
                arg10
            };
            if (v3 > 0) {
                pool_withdraw_navi<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v3, arg11);
            };
        };
    }

    public fun org_withdraw_navi<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg7: &0x2::clock::Clock, arg8: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg9: u8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg11), 13906835565912850434);
        pool_withdraw_navi<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun pool_invest_navi<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg6: &0x2::clock::Clock, arg7: u8, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"navi");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg5, &v0), 13906834573775667206);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg9), 13906834578070372354);
        let v1 = NaviPoolCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<NaviPoolCapKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v1), 13906834582365732872);
        let v2 = NaviPoolCapKey{dummy_field: false};
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg1, arg2, arg7, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::split_balance_for_invest<T0>(arg0, arg8, arg9), arg9), arg3, arg4, 0x2::dynamic_object_field::borrow_mut<NaviPoolCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg9), v2));
        let v3 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg9);
        let v4 = NaviPoolPositionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<NaviPoolPositionKey>(v3, v4)) {
            let v5 = NaviPoolPositionKey{dummy_field: false};
            let v6 = 0x2::dynamic_field::borrow_mut<NaviPoolPositionKey, NaviPosition>(v3, v5);
            v6.deposited_value = v6.deposited_value + arg8;
        } else {
            let v7 = NaviPoolPositionKey{dummy_field: false};
            let v8 = NaviPosition{deposited_value: arg8};
            0x2::dynamic_field::add<NaviPoolPositionKey, NaviPosition>(v3, v7, v8);
        };
        let v9 = NaviInvested{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
            amount    : arg8,
        };
        0x2::event::emit<NaviInvested>(v9);
    }

    public(friend) fun pool_withdraw_navi<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg7: &0x2::clock::Clock, arg8: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg9: u8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"navi");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg8, &v0), 13906834724099522566);
        let v1 = NaviPoolCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<NaviPoolCapKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v1), 13906834728394620936);
        let v2 = NaviPoolCapKey{dummy_field: false};
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg7, arg5, arg1, arg2, arg9, arg10, arg3, arg4, 0x2::dynamic_object_field::borrow_mut<NaviPoolCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg8), v2));
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = NaviPoolPositionKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow<NaviPoolPositionKey, NaviPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v5).deposited_value;
        let v7 = if (arg10 <= v6) {
            arg10
        } else {
            v6
        };
        let v8 = if (v4 > v7) {
            v4 - v7
        } else {
            0
        };
        let v9 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v8, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::org_yield_fee_bps(arg6), 10000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u64>(&v9)) {
            let v10 = 0x1::option::destroy_some<u64>(v9);
            let v11 = 0x2::coin::from_balance<T0>(v3, arg11);
            if (v10 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v11, v10, arg11), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg6));
            };
            0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::merge_balance_from_yield<T0>(arg0, 0x2::coin::into_balance<T0>(v11));
            let v12 = NaviPoolPositionKey{dummy_field: false};
            0x2::dynamic_field::borrow_mut<NaviPoolPositionKey, NaviPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg8), v12).deposited_value = v6 - v7;
            let v13 = NaviReturned{
                object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
                gross     : v4,
                yield_fee : v10,
                net       : v4 - v10,
            };
            0x2::event::emit<NaviReturned>(v13);
            return
        } else {
            0x1::option::destroy_none<u64>(v9);
            abort 13906834814294229004
        };
    }

    public fun store_pool_account_cap<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg2), 13906834457811288066);
        let v0 = NaviPoolCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<NaviPoolCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg2), v0, arg1);
    }

    public fun store_vault_account_cap(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg2), 13906834500761092100);
        let v0 = NaviVaultCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<NaviVaultCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg2), v0, arg1);
    }

    public fun vault_invest_navi<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg7: &0x2::clock::Clock, arg8: u8, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"navi");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg6, &v0), 13906834947437821958);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg10), 13906834951732658180);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, arg1);
        let v2 = NaviVaultCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<NaviVaultCapKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg6), v2), 13906834977502855178);
        let v3 = NaviVaultCapKey{dummy_field: false};
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg7, arg2, arg3, arg8, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::split_bucket_for_invest<T0>(v1, arg9), arg10), arg4, arg5, 0x2::dynamic_object_field::borrow_mut<NaviVaultCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg6), v3));
        let v4 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg6);
        let v5 = NaviVaultPositionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<NaviVaultPositionKey>(v4, v5)) {
            let v6 = NaviVaultPositionKey{dummy_field: false};
            let v7 = 0x2::dynamic_field::borrow_mut<NaviVaultPositionKey, NaviPosition>(v4, v6);
            v7.deposited_value = v7.deposited_value + arg9;
        } else {
            let v8 = NaviVaultPositionKey{dummy_field: false};
            let v9 = NaviPosition{deposited_value: arg9};
            0x2::dynamic_field::add<NaviVaultPositionKey, NaviPosition>(v4, v8, v9);
        };
        let v10 = NaviInvested{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg10)),
            amount    : arg9,
        };
        0x2::event::emit<NaviInvested>(v10);
    }

    public fun vault_withdraw_navi<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg8: &0x2::clock::Clock, arg9: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg10: u8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"navi");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg9, &v0), 13906835136416382982);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg12), 13906835140711219204);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, arg1);
        let v2 = NaviVaultCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<NaviVaultCapKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg9), v2), 13906835157891481610);
        let v3 = NaviVaultCapKey{dummy_field: false};
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg8, arg6, arg2, arg3, arg10, arg11, arg4, arg5, 0x2::dynamic_object_field::borrow_mut<NaviVaultCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg9), v3));
        let v5 = 0x2::balance::value<T0>(&v4);
        let v6 = NaviVaultPositionKey{dummy_field: false};
        let v7 = 0x2::dynamic_field::borrow<NaviVaultPositionKey, NaviPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg9), v6).deposited_value;
        let v8 = if (arg11 <= v7) {
            arg11
        } else {
            v7
        };
        let v9 = if (v5 > v8) {
            v5 - v8
        } else {
            0
        };
        let v10 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v9, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::vault_yield_fee_bps(arg7), 10000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u64>(&v10)) {
            let v11 = 0x1::option::destroy_some<u64>(v10);
            let v12 = 0x2::coin::from_balance<T0>(v4, arg12);
            if (v11 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v12, v11, arg12), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg7));
            };
            0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::merge_bucket_from_yield<T0>(v1, 0x2::coin::into_balance<T0>(v12));
            let v13 = NaviVaultPositionKey{dummy_field: false};
            0x2::dynamic_field::borrow_mut<NaviVaultPositionKey, NaviPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg9), v13).deposited_value = v7 - v8;
            let v14 = NaviReturned{
                object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg12)),
                gross     : v5,
                yield_fee : v11,
                net       : v5 - v11,
            };
            0x2::event::emit<NaviReturned>(v14);
            return
        } else {
            0x1::option::destroy_none<u64>(v10);
            abort 13906835265265795084
        };
    }

    // decompiled from Move bytecode v7
}

