module 0x8f0943975ec6f56f97e197713041b192e8ff9b4461c0a496bf129ed37b2866eb::suilend {
    struct SuilendPoolCTokenKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SuilendVaultCTokenKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SuilendPoolPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SuilendVaultPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SuilendPosition has store {
        deposited_value: u64,
    }

    struct SuilendInvested has copy, drop {
        object_id: 0x2::object::ID,
        amount: u64,
    }

    struct SuilendReturned has copy, drop {
        object_id: 0x2::object::ID,
        gross: u64,
        yield_fee: u64,
        net: u64,
    }

    public fun cover_claim_from_suilend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::claimable_amount<T0>(arg0, 0x2::tx_context::sender(arg6), arg4);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::balance_value<T0>(arg0);
        if (v1 < v0) {
            let v2 = v0 - v1;
            let v3 = if (v2 < arg5) {
                v2
            } else {
                arg5
            };
            if (v3 > 0) {
                pool_withdraw_suilend<T0>(arg0, arg1, arg2, arg3, arg4, v3, arg6);
            };
        };
    }

    public fun org_withdraw_suilend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg6), 13906835535848079362);
        pool_withdraw_suilend<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun pool_invest_suilend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"suilend");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg2, &v0), 13906834462106517510);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::org<T0>(arg0) == 0x2::tx_context::sender(arg5), 13906834466401222658);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut<T0>(arg0, arg5);
        let v2 = SuilendPoolCTokenKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists<SuilendPoolCTokenKey>(v1, v2)) {
            let v3 = SuilendPoolCTokenKey{dummy_field: false};
            0x2::coin::join<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(0x2::dynamic_object_field::borrow_mut<SuilendPoolCTokenKey, 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>>(v1, v3), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1), arg3, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::split_balance_for_invest<T0>(arg0, arg4, arg5), arg5), arg5));
        } else {
            let v4 = SuilendPoolCTokenKey{dummy_field: false};
            0x2::dynamic_object_field::add<SuilendPoolCTokenKey, 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>>(v1, v4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1), arg3, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::split_balance_for_invest<T0>(arg0, arg4, arg5), arg5), arg5));
        };
        let v5 = SuilendPoolPositionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SuilendPoolPositionKey>(v1, v5)) {
            let v6 = SuilendPoolPositionKey{dummy_field: false};
            let v7 = 0x2::dynamic_field::borrow_mut<SuilendPoolPositionKey, SuilendPosition>(v1, v6);
            v7.deposited_value = v7.deposited_value + arg4;
        } else {
            let v8 = SuilendPoolPositionKey{dummy_field: false};
            let v9 = SuilendPosition{deposited_value: arg4};
            0x2::dynamic_field::add<SuilendPoolPositionKey, SuilendPosition>(v1, v8, v9);
        };
        let v10 = SuilendInvested{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
            amount    : arg4,
        };
        0x2::event::emit<SuilendInvested>(v10);
    }

    public(friend) fun pool_withdraw_suilend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::StreamPool<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"suilend");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg3, &v0), 13906834625315274758);
        let v1 = SuilendPoolCTokenKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<SuilendPoolCTokenKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v1), 13906834629610373128);
        let v2 = SuilendPoolCTokenKey{dummy_field: false};
        let v3 = 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(0x2::dynamic_object_field::borrow<SuilendPoolCTokenKey, 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v2));
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg5), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1)))) + 1;
        let v5 = if (v4 >= v3) {
            v3
        } else {
            v4
        };
        let v6 = v5 >= v3;
        let v7 = if (v6) {
            let v8 = SuilendPoolCTokenKey{dummy_field: false};
            0x2::dynamic_object_field::remove<SuilendPoolCTokenKey, 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg3), v8)
        } else {
            let v9 = SuilendPoolCTokenKey{dummy_field: false};
            0x2::coin::split<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(0x2::dynamic_object_field::borrow_mut<SuilendPoolCTokenKey, 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg3), v9), v5, arg6)
        };
        let v10 = SuilendPoolPositionKey{dummy_field: false};
        let v11 = 0x2::dynamic_field::borrow<SuilendPoolPositionKey, SuilendPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0), v10).deposited_value;
        let v12 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1), arg4, v7, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(), arg6);
        let v13 = 0x2::coin::value<T0>(&v12);
        let v14 = if (v6) {
            v11
        } else {
            let v15 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div((v11 as u128), (v5 as u128), (v3 as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up());
            if (0x1::option::is_some<u128>(&v15)) {
                (0x1::option::destroy_some<u128>(v15) as u64)
            } else {
                0x1::option::destroy_none<u128>(v15);
                abort 13906834852948934668
            }
        };
        let v16 = if (v13 > v14) {
            v13 - v14
        } else {
            0
        };
        let v17 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v16, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::org_yield_fee_bps(arg2), 10000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u64>(&v17)) {
            let v18 = 0x1::option::destroy_some<u64>(v17);
            if (v18 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v12, v18, arg6), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg2));
            };
            0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::merge_balance_from_yield<T0>(arg0, 0x2::coin::into_balance<T0>(v12));
            if (v6) {
                let v19 = SuilendPoolPositionKey{dummy_field: false};
                let SuilendPosition {  } = 0x2::dynamic_field::remove<SuilendPoolPositionKey, SuilendPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg3), v19);
            } else {
                let v20 = SuilendPoolPositionKey{dummy_field: false};
                let v21 = if (v11 > v14) {
                    v11 - v14
                } else {
                    0
                };
                0x2::dynamic_field::borrow_mut<SuilendPoolPositionKey, SuilendPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid_mut_yield<T0>(arg0, arg3), v20).deposited_value = v21;
            };
            let v22 = SuilendReturned{
                object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::stream_pool::borrow_uid<T0>(arg0)),
                gross     : v13,
                yield_fee : v18,
                net       : v13 - v18,
            };
            0x2::event::emit<SuilendReturned>(v22);
            return
        } else {
            0x1::option::destroy_none<u64>(v17);
            abort 13906834878718738444
        };
    }

    public fun vault_invest_suilend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"suilend");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg3, &v0), 13906835041927102470);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg6), 13906835046221938692);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, arg1);
        let v2 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg3);
        let v3 = SuilendVaultCTokenKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists<SuilendVaultCTokenKey>(v2, v3)) {
            let v4 = SuilendVaultCTokenKey{dummy_field: false};
            0x2::coin::join<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(0x2::dynamic_object_field::borrow_mut<SuilendVaultCTokenKey, 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>>(v2, v4), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2), arg4, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::split_bucket_for_invest<T0>(v1, arg5), arg6), arg6));
        } else {
            let v5 = SuilendVaultCTokenKey{dummy_field: false};
            0x2::dynamic_object_field::add<SuilendVaultCTokenKey, 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>>(v2, v5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2), arg4, 0x2::coin::from_balance<T0>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::split_bucket_for_invest<T0>(v1, arg5), arg6), arg6));
        };
        let v6 = SuilendVaultPositionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SuilendVaultPositionKey>(v2, v6)) {
            let v7 = SuilendVaultPositionKey{dummy_field: false};
            let v8 = 0x2::dynamic_field::borrow_mut<SuilendVaultPositionKey, SuilendPosition>(v2, v7);
            v8.deposited_value = v8.deposited_value + arg5;
        } else {
            let v9 = SuilendVaultPositionKey{dummy_field: false};
            let v10 = SuilendPosition{deposited_value: arg5};
            0x2::dynamic_field::add<SuilendVaultPositionKey, SuilendPosition>(v2, v9, v10);
        };
        let v11 = SuilendInvested{
            object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg6)),
            amount    : arg5,
        };
        0x2::event::emit<SuilendInvested>(v11);
    }

    public fun vault_withdraw_suilend<T0>(arg0: &mut 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::EmployeeVault, arg1: 0x1::string::String, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolConfig, arg4: &0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::ProtocolRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"suilend");
        assert!(0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::is_approved(arg4, &v0), 13906835213725794310);
        assert!(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::owner(arg0) == 0x2::tx_context::sender(arg6), 13906835218020630532);
        let v1 = 0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::borrow_bucket_mut<T0>(arg0, arg1);
        let v2 = SuilendVaultCTokenKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<SuilendVaultCTokenKey>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg4), v2), 13906835235200892938);
        let v3 = SuilendVaultCTokenKey{dummy_field: false};
        let v4 = SuilendVaultPositionKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow<SuilendVaultPositionKey, SuilendPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg4), v4).deposited_value;
        let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2), arg5, 0x2::dynamic_object_field::remove<SuilendVaultCTokenKey, 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg4), v3), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(), arg6);
        let v7 = 0x2::coin::value<T0>(&v6);
        let v8 = if (v7 > v5) {
            v7 - v5
        } else {
            0
        };
        let v9 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u64::mul_div(v8, 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::vault_yield_fee_bps(arg3), 10000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u64>(&v9)) {
            let v10 = 0x1::option::destroy_some<u64>(v9);
            if (v10 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, v10, arg6), 0x6eae4d4c2c97ab2166f88cc310a4c6f0fc66e2f9583e01ad75c99b2951cfbbd::registry::treasury(arg3));
            };
            0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::merge_bucket_from_yield<T0>(v1, 0x2::coin::into_balance<T0>(v6));
            let v11 = SuilendVaultPositionKey{dummy_field: false};
            let SuilendPosition {  } = 0x2::dynamic_field::remove<SuilendVaultPositionKey, SuilendPosition>(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::bucket_uid_mut<T0>(v1, arg4), v11);
            let v12 = SuilendReturned{
                object_id : 0x2::object::uid_to_inner(0x4c582aea3efe99fb68deea8b71b96eda6fba06001ed5588da83799c09f9179b4::employee_vault::vault_uid_mut(arg0, arg6)),
                gross     : v7,
                yield_fee : v10,
                net       : v7 - v10,
            };
            0x2::event::emit<SuilendReturned>(v12);
            return
        } else {
            0x1::option::destroy_none<u64>(v9);
            abort 13906835303920500748
        };
    }

    // decompiled from Move bytecode v7
}

