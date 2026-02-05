module 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_keeper {
    fun assert_queue_covers_enabled<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: &vector<u8>) {
        let v0 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_enabled_protocol_ids<T0>(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            assert!(queue_contains(arg1, *0x1::vector::borrow<u8>(&v0, v1)), 1);
            v1 = v1 + 1;
        };
    }

    fun build_rebalance_plans<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: u64) : (vector<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>, vector<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_total_assets<T0>(arg0);
        let v1 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_total_enabled_ratio<T0>(arg0);
        assert!(v0 > 0, 3);
        assert!(v1 > 0, 3);
        let v2 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_withdraw_queue<T0>(arg0);
        let v3 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_supply_queue<T0>(arg0);
        assert_queue_covers_enabled<T0>(arg0, &v2);
        assert_queue_covers_enabled<T0>(arg0, &v3);
        let v4 = 0x1::vector::empty<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>();
        let v5 = 0x1::vector::empty<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>();
        let v6 = (arg1 as u128);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u8>(&v2)) {
            let v8 = *0x1::vector::borrow<u8>(&v2, v7);
            if (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_protocol_enabled<T0>(arg0, v8)) {
                let v9 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_math::mul_div(v0, (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_protocol_ratio<T0>(arg0, v8) as u128), (v1 as u128));
                let v10 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_protocol_balance<T0>(arg0, v8);
                if (v10 > v9) {
                    let v11 = v10 - v9;
                    let v12 = if (v9 == 0) {
                        10000
                    } else {
                        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_math::mul_div(v11, 10000, v9)
                    };
                    if (v12 >= v6) {
                        0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v4, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(v8, v11));
                    };
                };
            };
            v7 = v7 + 1;
        };
        let v13 = 0;
        while (v13 < 0x1::vector::length<u8>(&v3)) {
            let v14 = *0x1::vector::borrow<u8>(&v3, v13);
            if (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_protocol_enabled<T0>(arg0, v14)) {
                let v15 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_math::mul_div(v0, (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_protocol_ratio<T0>(arg0, v14) as u128), (v1 as u128));
                let v16 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_protocol_balance<T0>(arg0, v14);
                if (v16 < v15) {
                    let v17 = v15 - v16;
                    let v18 = if (v15 == 0) {
                        0
                    } else {
                        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_math::mul_div(v17, 10000, v15)
                    };
                    if (v18 >= v6) {
                        0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v5, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(v14, v17));
                    };
                };
            };
            v13 = v13 + 1;
        };
        let v19 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::total_amount(&v4);
        let v20 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::total_amount(&v5);
        assert!(v19 > 0, 3);
        let v21 = if (v19 > v20) {
            v19 - v20
        } else {
            v20 - v19
        };
        assert!(v21 <= 10, 2);
        (v4, v5)
    }

    fun deposit_to_vault<T0, T1>(arg0: &mut 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u128, arg3: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::market::Hearn, arg4: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0 && 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_protocol_enabled<T0>(arg0, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT())) {
            let v0 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings::exists_<0x2::balance::Balance<T1>>(v0, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT())) {
                0x2::balance::join<T1>(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings::borrow_mut<0x2::balance::Balance<T1>>(v0, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT()), 0x2::coin::into_balance<T1>(0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::deposit<T0, T1>(arg4, arg3, 0x2::coin::take<T0>(arg1, (arg2 as u64), arg6), arg5, arg6)));
            } else {
                0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings::store<0x2::balance::Balance<T1>>(v0, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT(), 0x2::coin::into_balance<T1>(0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::deposit<T0, T1>(arg4, arg3, 0x2::coin::take<T0>(arg1, (arg2 as u64), arg6), arg5, arg6)));
            };
        };
    }

    fun queue_contains(arg0: &vector<u8>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun rebalance<T0, T1, T2>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::LLVGlobal, arg1: &mut 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg2: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::market::Hearn, arg3: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<T0, T1>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg5: u64, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::assert_version(arg0);
        assert!(!0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::is_global_paused(arg0), 5);
        assert!(!0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_paused<T0>(arg1), 4);
        let v0 = 0x2::clock::timestamp_ms(arg15);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::assert_keeper<T0>(arg1, 0x2::tx_context::sender(arg16));
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::assert_rebalance_allowed<T0>(arg1, v0);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_validation::validate_l1_l3_protocols<T0>(arg1, 0x2::object::id<0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<T0, T1>>(arg3), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg4), arg5, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg7), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg8), arg10, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg9), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg11), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg12));
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_validation::validate_navi_oracle<T0>(arg1, 0x2::object::id<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg13));
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::sync_l1_l3_balances<T0, T1, T2>(arg1, arg3, arg2, arg4, arg7, arg8, arg10, arg15);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::accrue_fees<T0>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_total_assets<T0>(arg1), v0);
        let (v1, _) = build_rebalance_plans<T0>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_min_rebalance_deviation_bps<T0>(arg1));
        let v3 = v1;
        let v4 = 0x2::balance::zero<T0>();
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&v3)) {
            let v7 = *0x1::vector::borrow<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&v3, v6);
            let v8 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::protocol_id(&v7);
            let v9 = if (v8 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT()) {
                let (v10, v11) = withdraw_from_vault<T0, T1>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::amount(&v7), arg2, arg3, arg15, arg16);
                0x2::balance::join<T0>(&mut v4, v10);
                v11
            } else if (v8 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SUILEND()) {
                let (v12, v13) = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::withdraw_from_suilend<T0, T2>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::amount(&v7), arg4, arg5, arg15, arg16);
                0x2::balance::join<T0>(&mut v4, v12);
                v13
            } else if (v8 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SCALLOP()) {
                let (v14, v15) = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::withdraw_from_scallop<T0>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::amount(&v7), arg6, arg7, arg15, arg16);
                0x2::balance::join<T0>(&mut v4, v14);
                v15
            } else {
                assert!(v8 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_NAVI(), 2);
                let (v16, v17) = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::withdraw_from_navi<T0>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::amount(&v7), arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
                0x2::balance::join<T0>(&mut v4, v16);
                v17
            };
            0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::record_withdraw<T0>(arg1, v8, v9);
            v5 = v5 + v9;
            v6 = v6 + 1;
        };
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::sync_l1_l3_balances<T0, T1, T2>(arg1, arg3, arg2, arg4, arg7, arg8, arg10, arg15);
        let (_, v19) = build_rebalance_plans<T0>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_min_rebalance_deviation_bps<T0>(arg1));
        let v20 = v19;
        let v21 = 0;
        let v22 = 0;
        while (v22 < 0x1::vector::length<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&v20)) {
            let v23 = (0x2::balance::value<T0>(&v4) as u128);
            if (v23 == 0) {
                break
            };
            let v24 = *0x1::vector::borrow<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&v20, v22);
            let v25 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::protocol_id(&v24);
            let v26 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::amount(&v24);
            let v27 = if (v26 > v23) {
                v23
            } else {
                v26
            };
            if (v27 > 0) {
                if (v25 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT()) {
                    let v28 = &mut v4;
                    deposit_to_vault<T0, T1>(arg1, v28, v27, arg2, arg3, arg15, arg16);
                } else if (v25 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SUILEND()) {
                    let v29 = 0x1::vector::empty<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>();
                    0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v29, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(v25, v27));
                    0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::deposit_to_suilend<T0, T2>(arg1, &mut v4, &v29, arg4, arg5, arg15, arg16);
                } else if (v25 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SCALLOP()) {
                    let v30 = 0x1::vector::empty<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>();
                    0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v30, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(v25, v27));
                    0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::deposit_to_scallop<T0>(arg1, &mut v4, &v30, arg6, arg7, arg15, arg16);
                } else {
                    assert!(v25 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_NAVI(), 2);
                    let v31 = 0x1::vector::empty<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>();
                    0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v31, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(v25, v27));
                    0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::deposit_to_navi<T0>(arg1, &mut v4, &v31, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
                };
                0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::record_deposit<T0>(arg1, v25, v27);
                v21 = v21 + v27;
            };
            v22 = v22 + 1;
        };
        let v32 = 0x2::balance::value<T0>(&v4);
        if (v32 > 0) {
            let v33 = *0x1::vector::borrow<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&v20, 0);
            let v34 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::protocol_id(&v33);
            let v35 = (v32 as u128);
            if (v34 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT()) {
                let v36 = &mut v4;
                deposit_to_vault<T0, T1>(arg1, v36, v35, arg2, arg3, arg15, arg16);
            } else if (v34 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SUILEND()) {
                let v37 = 0x1::vector::empty<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>();
                0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v37, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(v34, v35));
                0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::deposit_to_suilend<T0, T2>(arg1, &mut v4, &v37, arg4, arg5, arg15, arg16);
            } else if (v34 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SCALLOP()) {
                let v38 = 0x1::vector::empty<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>();
                0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v38, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(v34, v35));
                0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::deposit_to_scallop<T0>(arg1, &mut v4, &v38, arg6, arg7, arg15, arg16);
            } else if (v34 == 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_NAVI()) {
                let v39 = 0x1::vector::empty<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>();
                0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v39, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(v34, v35));
                0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::deposit_to_navi<T0>(arg1, &mut v4, &v39, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
            };
            0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::record_deposit<T0>(arg1, v34, v35);
            v21 = v21 + v35;
        };
        0x2::balance::destroy_zero<T0>(v4);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::update_last_rebalance<T0>(arg1, v0);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_events::emit_rebalanced(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::id<T0>(arg1), v5, v21, v0);
    }

    fun select_vault_withdraw_amount(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : (u64, u128) {
        if (arg2 > (arg1 as u128)) {
            (arg1, arg3)
        } else {
            ((arg2 as u64), arg0)
        }
    }

    fun withdraw_from_vault<T0, T1>(arg0: &mut 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: u128, arg2: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::market::Hearn, arg3: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u128) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = v1;
        if (arg1 > 0) {
            let v3 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings::exists_<0x2::balance::Balance<T1>>(v3, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT())) {
                let v4 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings::borrow_mut<0x2::balance::Balance<T1>>(v3, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT());
                let v5 = 0x2::balance::value<T1>(v4);
                if (v5 > 0) {
                    let (v6, v7) = select_vault_withdraw_amount(arg1, v5, 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::preview_withdraw<T0, T1>(arg3, arg2, arg1), 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::preview_redeem<T0, T1>(arg3, arg2, (v5 as u128)));
                    if (v6 == 0 || v7 == 0) {
                        return (v0, v1)
                    };
                    let (v8, v9) = 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::withdraw<T0, T1>(arg3, arg2, 0x2::coin::take<T1>(v4, v6, arg5), v7, arg4, arg5);
                    let v10 = v9;
                    let v11 = v8;
                    v2 = v1 + (0x2::coin::value<T0>(&v11) as u128);
                    0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v11));
                    if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v10)) {
                        0x2::balance::join<T1>(v4, 0x2::coin::into_balance<T1>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v10)));
                    } else {
                        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v10);
                    };
                };
            };
        };
        (v0, v2)
    }

    // decompiled from Move bytecode v6
}

