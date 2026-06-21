module 0x8f0943975ec6f56f97e197713041b192e8ff9b4461c0a496bf129ed37b2866eb::scallop {
    struct ScallopPoolMarketCoinKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ScallopVaultMarketCoinKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ScallopPoolPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ScallopVaultPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ScallopPosition has store {
        deposited_value: u64,
    }

    struct ScallopInvested has copy, drop {
        object_id: 0x2::object::ID,
        amount: u64,
    }

    struct ScallopReturned has copy, drop {
        object_id: 0x2::object::ID,
        gross: u64,
        yield_fee: u64,
        net: u64,
    }

    public fun cover_claim_from_scallop<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::claimable_amount<T0>(arg0, 0x2::tx_context::sender(arg7), arg5);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::balance_value<T0>(arg0);
        if (v1 < v0) {
            let v2 = v0 - v1;
            let v3 = if (v2 < arg6) {
                v2
            } else {
                arg6
            };
            if (v3 > 0) {
                pool_withdraw_scallop<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v3, arg7);
            };
        };
    }

    public fun org_withdraw_scallop<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg7), 13906835565912850434);
        pool_withdraw_scallop<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun pool_invest_scallop<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"scallop");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg3, &v0), 13906834483581353990);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg6), 13906834487876059138);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg6);
        let v2 = ScallopPoolMarketCoinKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists<ScallopPoolMarketCoinKey>(v1, v2)) {
            let v3 = ScallopPoolMarketCoinKey{dummy_field: false};
            0x2::coin::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_object_field::borrow_mut<ScallopPoolMarketCoinKey, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1, v3), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::split_balance_for_invest<T0>(arg0, arg5, arg6), arg6), arg4, arg6));
        } else {
            let v4 = ScallopPoolMarketCoinKey{dummy_field: false};
            0x2::dynamic_object_field::add<ScallopPoolMarketCoinKey, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1, v4, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::split_balance_for_invest<T0>(arg0, arg5, arg6), arg6), arg4, arg6));
        };
        let v5 = ScallopPoolPositionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ScallopPoolPositionKey>(v1, v5)) {
            let v6 = ScallopPoolPositionKey{dummy_field: false};
            let v7 = 0x2::dynamic_field::borrow_mut<ScallopPoolPositionKey, ScallopPosition>(v1, v6);
            v7.deposited_value = v7.deposited_value + arg5;
        } else {
            let v8 = ScallopPoolPositionKey{dummy_field: false};
            let v9 = ScallopPosition{deposited_value: arg5};
            0x2::dynamic_field::add<ScallopPoolPositionKey, ScallopPosition>(v1, v8, v9);
        };
        let v10 = ScallopInvested{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
            amount    : arg5,
        };
        0x2::event::emit<ScallopInvested>(v10);
    }

    public(friend) fun pool_withdraw_scallop<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"scallop");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg4, &v0), 13906834642495143942);
        let v1 = ScallopPoolMarketCoinKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<ScallopPoolMarketCoinKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v1), 13906834646790242312);
        let v2 = ScallopPoolMarketCoinKey{dummy_field: false};
        let v3 = 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_object_field::borrow<ScallopPoolMarketCoinKey, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v2));
        let (v4, v5, v6, v7) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg2)), 0x1::type_name::get<T0>()));
        assert!(v7 > 0, 13906834702625341456);
        assert!(v4 + v5 >= v6, 13906834706920177678);
        let v8 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div((arg6 as u128), (v7 as u128), ((v4 + v5 - v6) as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up());
        if (0x1::option::is_some<u128>(&v8)) {
            let v9 = (0x1::option::destroy_some<u128>(v8) as u64) + 1;
            let v10 = if (v9 >= v3) {
                v3
            } else {
                v9
            };
            let v11 = v10 >= v3;
            let v12 = if (v11) {
                let v13 = ScallopPoolMarketCoinKey{dummy_field: false};
                0x2::dynamic_object_field::remove<ScallopPoolMarketCoinKey, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg4), v13)
            } else {
                let v14 = ScallopPoolMarketCoinKey{dummy_field: false};
                0x2::coin::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_object_field::borrow_mut<ScallopPoolMarketCoinKey, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg4), v14), v10, arg7)
            };
            let v15 = ScallopPoolPositionKey{dummy_field: false};
            let v16 = 0x2::dynamic_field::borrow<ScallopPoolPositionKey, ScallopPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v15).deposited_value;
            let v17 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, v12, arg5, arg7);
            let v18 = 0x2::coin::value<T0>(&v17);
            let v19 = if (v11) {
                v16
            } else {
                let v20 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div((v16 as u128), (v10 as u128), (v3 as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up());
                if (0x1::option::is_some<u128>(&v20)) {
                    (0x1::option::destroy_some<u128>(v20) as u64)
                } else {
                    0x1::option::destroy_none<u128>(v20);
                    abort 13906834891603640332
                }
            };
            let v21 = if (v18 > v19) {
                v18 - v19
            } else {
                0
            };
            let v22 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v21, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::org_yield_fee_bps(arg3), 10000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
            if (0x1::option::is_some<u64>(&v22)) {
                let v23 = 0x1::option::destroy_some<u64>(v22);
                if (v23 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v17, v23, arg7), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg3));
                };
                0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::merge_balance_from_yield<T0>(arg0, 0x2::coin::into_balance<T0>(v17));
                if (v11) {
                    let v24 = ScallopPoolPositionKey{dummy_field: false};
                    let ScallopPosition {  } = 0x2::dynamic_field::remove<ScallopPoolPositionKey, ScallopPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg4), v24);
                } else {
                    let v25 = ScallopPoolPositionKey{dummy_field: false};
                    let v26 = if (v16 > v19) {
                        v16 - v19
                    } else {
                        0
                    };
                    0x2::dynamic_field::borrow_mut<ScallopPoolPositionKey, ScallopPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg4), v25).deposited_value = v26;
                };
                let v27 = ScallopReturned{
                    object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
                    gross     : v18,
                    yield_fee : v23,
                    net       : v18 - v23,
                };
                0x2::event::emit<ScallopReturned>(v27);
                return
            } else {
                0x1::option::destroy_none<u64>(v22);
                abort 13906834917373444108
            };
        } else {
            0x1::option::destroy_none<u128>(v8);
            abort 13906834741279784972
        };
    }

    public fun vault_invest_scallop<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"scallop");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg4, &v0), 13906835084876775430);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg7), 13906835089171611652);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, arg1);
        let v2 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg4);
        let v3 = ScallopVaultMarketCoinKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists<ScallopVaultMarketCoinKey>(v2, v3)) {
            let v4 = ScallopVaultMarketCoinKey{dummy_field: false};
            0x2::coin::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_object_field::borrow_mut<ScallopVaultMarketCoinKey, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v2, v4), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::split_bucket_for_invest<T0>(v1, arg6), arg7), arg5, arg7));
        } else {
            let v5 = ScallopVaultMarketCoinKey{dummy_field: false};
            0x2::dynamic_object_field::add<ScallopVaultMarketCoinKey, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v2, v5, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::split_bucket_for_invest<T0>(v1, arg6), arg7), arg5, arg7));
        };
        let v6 = ScallopVaultPositionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ScallopVaultPositionKey>(v2, v6)) {
            let v7 = ScallopVaultPositionKey{dummy_field: false};
            let v8 = 0x2::dynamic_field::borrow_mut<ScallopVaultPositionKey, ScallopPosition>(v2, v7);
            v8.deposited_value = v8.deposited_value + arg6;
        } else {
            let v9 = ScallopVaultPositionKey{dummy_field: false};
            let v10 = ScallopPosition{deposited_value: arg6};
            0x2::dynamic_field::add<ScallopVaultPositionKey, ScallopPosition>(v2, v9, v10);
        };
        let v11 = ScallopInvested{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg7)),
            amount    : arg6,
        };
        0x2::event::emit<ScallopInvested>(v11);
    }

    public fun vault_withdraw_scallop<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg5: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"scallop");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg5, &v0), 13906835248085532678);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg7), 13906835252380368900);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, arg1);
        let v2 = ScallopVaultMarketCoinKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<ScallopVaultMarketCoinKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg5), v2), 13906835269560631306);
        let v3 = ScallopVaultMarketCoinKey{dummy_field: false};
        let v4 = ScallopVaultPositionKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow<ScallopVaultPositionKey, ScallopPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg5), v4).deposited_value;
        let v6 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::dynamic_object_field::remove<ScallopVaultMarketCoinKey, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg5), v3), arg6, arg7);
        let v7 = 0x2::coin::value<T0>(&v6);
        let v8 = if (v7 > v5) {
            v7 - v5
        } else {
            0
        };
        let v9 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v8, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::vault_yield_fee_bps(arg4), 10000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u64>(&v9)) {
            let v10 = 0x1::option::destroy_some<u64>(v9);
            if (v10 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, v10, arg7), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg4));
            };
            0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::merge_bucket_from_yield<T0>(v1, 0x2::coin::into_balance<T0>(v6));
            let v11 = ScallopVaultPositionKey{dummy_field: false};
            let ScallopPosition {  } = 0x2::dynamic_field::remove<ScallopVaultPositionKey, ScallopPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg5), v11);
            let v12 = ScallopReturned{
                object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg7)),
                gross     : v7,
                yield_fee : v10,
                net       : v7 - v10,
            };
            0x2::event::emit<ScallopReturned>(v12);
            return
        } else {
            0x1::option::destroy_none<u64>(v9);
            abort 13906835325395337228
        };
    }

    // decompiled from Move bytecode v7
}

