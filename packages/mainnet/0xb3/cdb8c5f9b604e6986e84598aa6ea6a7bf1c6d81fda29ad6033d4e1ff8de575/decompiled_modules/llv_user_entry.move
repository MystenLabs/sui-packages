module 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_user_entry {
    public entry fun deposit<T0, T1, T2>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::LLVGlobal, arg1: &mut 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::market::Hearn, arg5: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<T0, T1>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg7: u64, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: u8, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::assert_version(arg0);
        assert!(!0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::is_global_paused(arg0), 5);
        assert!(!0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_paused<T0>(arg1), 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_validation::validate_l1_l3_protocols<T0>(arg1, 0x2::object::id<0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<T0, T1>>(arg5), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg6), arg7, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg9), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg10), arg12, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg11), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg13), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg14));
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::sync_l1_l3_balances<T0, T1, T2>(arg1, arg5, arg4, arg6, arg9, arg10, arg12, arg15);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::accrue_fees<T0>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_total_assets<T0>(arg1), 0x2::clock::timestamp_ms(arg15));
        let v1 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::calculate_deposit<T0>(arg1, v0);
        let v2 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::allocation(&v1);
        let v3 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::shares_to_mint(&v1);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::verify_min_shares(v3, arg3);
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        let v5 = &mut v4;
        deposit_to_vault<T0, T1>(arg1, v5, v2, arg4, arg5, arg15, arg16);
        let v6 = &mut v4;
        deposit_to_l3<T0, T2>(arg1, v6, v2, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::record_deposit_and_mint_position<T0>(arg1, &v1, v2, 0x2::tx_context::sender(arg16), (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::total_amount(v2) as u64), v3, arg15, arg16);
    }

    public entry fun withdraw<T0, T1, T2>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::LLVGlobal, arg1: &mut 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg2: 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<T0>, arg3: u128, arg4: u64, arg5: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::market::Hearn, arg6: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg8: u64, arg9: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg10: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg17: &mut 0x3::sui_system::SuiSystemState, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::assert_version(arg0);
        assert!(!0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::is_global_paused(arg0), 5);
        assert!(!0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_paused<T0>(arg1), 1);
        assert!(arg3 > 0, 2);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_validation::validate_l1_l3_protocols<T0>(arg1, 0x2::object::id<0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<T0, T1>>(arg6), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg7), arg8, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg10), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg11), arg13, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg12), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg14), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg15));
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_validation::validate_navi_oracle<T0>(arg1, 0x2::object::id<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg16));
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::sync_l1_l3_balances<T0, T1, T2>(arg1, arg6, arg5, arg7, arg10, arg11, arg13, arg18);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::accrue_fees<T0>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_total_assets<T0>(arg1), 0x2::clock::timestamp_ms(arg18));
        let v0 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::calculate_withdraw_by_shares<T0>(arg1, &arg2, arg3);
        let v1 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::assets_to_receive(&v0);
        let v2 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::recall_plan(&v0);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::verify_min_assets(v1, arg4);
        let (v3, v4, v5, v6) = withdraw_from_l3<T0, T2>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::get_amount(v2, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_NAVI()), 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::get_amount(v2, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SCALLOP()), 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::get_amount(v2, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SUILEND()), arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        let v7 = v3;
        let (v8, v9) = withdraw_from_vault<T0, T1>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::get_amount(v2, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT()), arg5, arg6, arg18, arg19);
        0x2::balance::join<T0>(&mut v7, v8);
        let v10 = 0x2::balance::value<T0>(&v7);
        assert!((v10 as u128) >= (arg4 as u128), 4);
        let v11 = if ((v10 as u128) >= v1) {
            0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::shares_to_burn(&v0)
        } else {
            0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_math::mul_div(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::shares_to_burn(&v0), (v10 as u128), v1)
        };
        let v12 = build_actual_recall_plan(v9, 0, v6, v5, v4);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::record_withdraw<T0>(arg1, &v0, &v12, v10, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::id<T0>(&arg2), 0x2::tx_context::sender(arg19), arg18);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg19), 0x2::tx_context::sender(arg19));
        if (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::deduct_from_position<T0>(arg1, &mut arg2, v11, (v10 as u128)) == 0) {
            0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::destroy_empty_position<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<T0>>(arg2, 0x2::tx_context::sender(arg19));
        };
    }

    public fun get_min_deposit<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>) : u64 {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_min_deposit<T0>(arg0)
    }

    public fun get_protocol_balance<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: u8) : u128 {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_protocol_balance<T0>(arg0, arg1)
    }

    public fun get_protocol_ratio<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: u8) : u64 {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_protocol_ratio<T0>(arg0, arg1)
    }

    public fun is_protocol_enabled<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: u8) : bool {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_protocol_enabled<T0>(arg0, arg1)
    }

    fun build_actual_recall_plan(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : vector<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount> {
        let v0 = 0x1::vector::empty<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>();
        if (arg0 > 0) {
            0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v0, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT(), arg0));
        };
        if (arg1 > 0) {
            0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v0, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_CETUS(), arg1));
        };
        if (arg2 > 0) {
            0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v0, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SUILEND(), arg2));
        };
        if (arg3 > 0) {
            0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v0, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SCALLOP(), arg3));
        };
        if (arg4 > 0) {
            0x1::vector::push_back<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>(&mut v0, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::create(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_NAVI(), arg4));
        };
        v0
    }

    public entry fun deposit_sui<T0, T1, T2>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::LLVGlobal, arg1: &mut 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u128, arg4: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::market::Hearn, arg5: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg13: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg16: u64, arg17: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg18: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg21: u8, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::assert_version(arg0);
        assert!(!0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::is_global_paused(arg0), 5);
        assert!(!0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_paused<0x2::sui::SUI>(arg1), 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 2);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_validation::validate_all_protocols(arg1, 0x2::object::id<0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<0x2::sui::SUI, T0>>(arg5), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>>(arg7), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg8), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg9), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg10), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg11), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(arg12), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg13), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>>(arg15), arg16, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg18), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg19), arg21, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>>(arg20), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg22), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg23));
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::sync_all_balances<T0, T1, T2>(arg1, arg5, arg4, arg7, arg12, arg13, arg15, arg18, arg19, arg21, arg24);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::accrue_fees<0x2::sui::SUI>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_total_assets<0x2::sui::SUI>(arg1), 0x2::clock::timestamp_ms(arg24));
        let v1 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::calculate_deposit<0x2::sui::SUI>(arg1, v0);
        let v2 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::allocation(&v1);
        let v3 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::shares_to_mint(&v1);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::verify_min_shares(v3, arg3);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v5 = &mut v4;
        deposit_to_vault<0x2::sui::SUI, T0>(arg1, v5, v2, arg4, arg5, arg24, arg25);
        let v6 = &mut v4;
        deposit_to_cetus_sui<T2>(arg1, v6, v2, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg24, arg25);
        let v7 = &mut v4;
        deposit_to_l3<0x2::sui::SUI, T1>(arg1, v7, v2, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
        if (0x2::balance::value<0x2::sui::SUI>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg25), 0x2::tx_context::sender(arg25));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
        };
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::record_deposit_and_mint_position<0x2::sui::SUI>(arg1, &v1, v2, 0x2::tx_context::sender(arg25), (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::total_amount(v2) as u64), v3, arg24, arg25);
    }

    fun deposit_to_cetus_sui<T0>(arg0: &mut 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<0x2::sui::SUI>, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: &vector<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::get_amount(arg2, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_CETUS());
        if (v0 > 0 && 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_protocol_enabled<0x2::sui::SUI>(arg0, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_CETUS())) {
            let v1 = ((v0 / 2) as u64);
            let v2 = 0x2::coin::take<0x2::sui::SUI>(arg1, v1, arg13);
            let v3 = 0x237ad858d1cf5ecf0298ffe59048e937d9fbcae721048b97883c648dfecdc842::cetus_vault_adapter::stake_sui_for_hasui(arg11, arg10, 0x2::coin::take<0x2::sui::SUI>(arg1, (v0 as u64) - v1, arg13), @0x0, arg13);
            let v4 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::borrow_uid_mut<0x2::sui::SUI>(arg0);
            if (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings::exists_<0x2::balance::Balance<T0>>(v4, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_CETUS())) {
                0x2::balance::join<T0>(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings::borrow_mut<0x2::balance::Balance<T0>>(v4, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_CETUS()), 0x2::coin::into_balance<T0>(0x237ad858d1cf5ecf0298ffe59048e937d9fbcae721048b97883c648dfecdc842::cetus_vault_adapter::deposit<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, v2, v3, 0x2::coin::value<0x2::sui::SUI>(&v2), 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v3), true, arg12, arg13)));
            } else {
                0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings::store<0x2::balance::Balance<T0>>(v4, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_CETUS(), 0x2::coin::into_balance<T0>(0x237ad858d1cf5ecf0298ffe59048e937d9fbcae721048b97883c648dfecdc842::cetus_vault_adapter::deposit<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, v2, v3, 0x2::coin::value<0x2::sui::SUI>(&v2), 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v3), true, arg12, arg13)));
            };
        };
    }

    fun deposit_to_l3<T0, T1>(arg0: &mut 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &vector<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: u64, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::deposit_to_suilend<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg12, arg13);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::deposit_to_scallop<T0>(arg0, arg1, arg2, arg5, arg6, arg12, arg13);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::deposit_to_navi<T0>(arg0, arg1, arg2, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun deposit_to_vault<T0, T1>(arg0: &mut 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &vector<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>, arg3: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::market::Hearn, arg4: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::get_amount(arg2, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT());
        if (v0 > 0 && 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_protocol_enabled<T0>(arg0, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT())) {
            let v1 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::borrow_uid_mut<T0>(arg0);
            if (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings::exists_<0x2::balance::Balance<T1>>(v1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT())) {
                0x2::balance::join<T1>(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings::borrow_mut<0x2::balance::Balance<T1>>(v1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT()), 0x2::coin::into_balance<T1>(0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::deposit<T0, T1>(arg4, arg3, 0x2::coin::take<T0>(arg1, (v0 as u64), arg6), arg5, arg6)));
            } else {
                0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::protocol_holdings::store<0x2::balance::Balance<T1>>(v1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT(), 0x2::coin::into_balance<T1>(0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::deposit<T0, T1>(arg4, arg3, 0x2::coin::take<T0>(arg1, (v0 as u64), arg6), arg5, arg6)));
            };
        };
    }

    public fun destroy_empty_position<T0>(arg0: 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<T0>) {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::destroy_empty_position<T0>(arg0);
    }

    public fun estimate_position_profit<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<T0>) : (u128, bool) {
        let v0 = estimate_position_value<T0>(arg0, arg1);
        let v1 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::deposited_assets<T0>(arg1);
        if (v0 >= v1) {
            (v0 - v1, true)
        } else {
            (v1 - v0, false)
        }
    }

    public fun estimate_position_value<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<T0>) : u128 {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_math::calculate_assets_for_shares(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::total_shares<T0>(arg0), 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_total_assets<T0>(arg0), 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::shares<T0>(arg1))
    }

    public fun is_pool_paused<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>) : bool {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_paused<T0>(arg0)
    }

    public fun is_position_empty<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<T0>) : bool {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::is_empty<T0>(arg0)
    }

    public fun pool_total_assets<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>) : u128 {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_total_assets<T0>(arg0)
    }

    public fun pool_total_shares<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>) : u128 {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::total_shares<T0>(arg0)
    }

    public fun pool_yield_index<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>) : u128 {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::global_yield_index<T0>(arg0)
    }

    public fun position_deposited_assets<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<T0>) : u128 {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::deposited_assets<T0>(arg0)
    }

    public fun position_shares<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<T0>) : u128 {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::shares<T0>(arg0)
    }

    public fun preview_deposit<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: u64) : (u128, vector<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::calculate_deposit<T0>(arg0, arg1);
        (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::shares_to_mint(&v0), *0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_deposit::allocation(&v0))
    }

    public fun preview_withdraw_all<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<T0>) : (u128, u128, vector<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::calculate_withdraw_all<T0>(arg0, arg1);
        (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::shares_to_burn(&v0), 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::assets_to_receive(&v0), *0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::recall_plan(&v0))
    }

    public fun preview_withdraw_by_assets<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<T0>, arg2: u64) : (u128, vector<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::calculate_withdraw_by_assets<T0>(arg0, arg1, arg2);
        (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::shares_to_burn(&v0), *0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::recall_plan(&v0))
    }

    public fun preview_withdraw_by_shares<T0>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<T0>, arg2: u128) : (u128, vector<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::calculate_withdraw_by_shares<T0>(arg0, arg1, arg2);
        (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::assets_to_receive(&v0), *0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::recall_plan(&v0))
    }

    fun select_vault_withdraw_amount(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : (u64, u128) {
        if (arg2 > (arg1 as u128)) {
            (arg1, arg3)
        } else {
            ((arg2 as u64), arg0)
        }
    }

    fun withdraw_from_l3<T0, T1>(arg0: &mut 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<T0>, arg1: u128, arg2: u128, arg3: u128, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: u64, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u128, u128, u128) {
        let v0 = 0x2::balance::zero<T0>();
        let (v1, v2) = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::withdraw_from_navi<T0>(arg0, arg1, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        0x2::balance::join<T0>(&mut v0, v1);
        let (v3, v4) = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::withdraw_from_scallop<T0>(arg0, arg2, arg6, arg7, arg15, arg16);
        0x2::balance::join<T0>(&mut v0, v3);
        let (v5, v6) = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::withdraw_from_suilend<T0, T1>(arg0, arg3, arg4, arg5, arg15, arg16);
        0x2::balance::join<T0>(&mut v0, v5);
        (v0, v2, v4, v6)
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

    public entry fun withdraw_sui<T0, T1, T2>(arg0: &0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::LLVGlobal, arg1: &mut 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::LLVPool<0x2::sui::SUI>, arg2: 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<0x2::sui::SUI>, arg3: u128, arg4: u64, arg5: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::market::Hearn, arg6: &mut 0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg7: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg8: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg9: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg10: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg11: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg14: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg15: &mut 0x3::sui_system::SuiSystemState, arg16: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg17: u64, arg18: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg19: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg22: u8, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg24: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg25: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg26: &0x2::clock::Clock, arg27: &mut 0x2::tx_context::TxContext) {
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::assert_version(arg0);
        assert!(!0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_admin::is_global_paused(arg0), 5);
        assert!(!0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::is_paused<0x2::sui::SUI>(arg1), 1);
        assert!(arg3 > 0, 2);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_validation::validate_all_protocols(arg1, 0x2::object::id<0x1bbe8f1fee7bff4f9da9f709d707526a4ba8f543f2353f0998f745e8f152d034::meta_vault_core::Vault<0x2::sui::SUI, T0>>(arg6), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>>(arg8), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg9), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg10), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg11), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg12), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(arg13), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg14), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>>(arg16), arg17, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg19), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg20), arg22, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>>(arg21), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg23), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg24));
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_validation::validate_navi_oracle<0x2::sui::SUI>(arg1, 0x2::object::id<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg25));
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::sync_all_balances<T0, T1, T2>(arg1, arg6, arg5, arg8, arg13, arg14, arg16, arg19, arg20, arg22, arg26);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::accrue_fees<0x2::sui::SUI>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_pool::get_total_assets<0x2::sui::SUI>(arg1), 0x2::clock::timestamp_ms(arg26));
        let v0 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::calculate_withdraw_by_shares<0x2::sui::SUI>(arg1, &arg2, arg3);
        let v1 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::assets_to_receive(&v0);
        let v2 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::recall_plan(&v0);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::verify_min_assets(v1, arg4);
        let v3 = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::get_amount(v2, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_CETUS());
        let (v4, v5, v6, v7) = withdraw_from_l3<0x2::sui::SUI, T1>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::get_amount(v2, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_NAVI()), 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::get_amount(v2, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SCALLOP()), 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::get_amount(v2, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_SUILEND()), arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg15, arg26, arg27);
        let v8 = v4;
        let v9 = 0;
        if (v3 > 0) {
            let (v10, v11) = 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_protocol_ops::withdraw_from_cetus<T2>(arg1, v3, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg26, arg27);
            0x2::balance::join<0x2::sui::SUI>(&mut v8, v10);
            v9 = v11;
        };
        let (v12, v13) = withdraw_from_vault<0x2::sui::SUI, T0>(arg1, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::get_amount(v2, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_allocation_plan::PROTOCOL_VAULT()), arg5, arg6, arg26, arg27);
        0x2::balance::join<0x2::sui::SUI>(&mut v8, v12);
        let v14 = 0x2::balance::value<0x2::sui::SUI>(&v8);
        assert!((v14 as u128) >= (arg4 as u128), 4);
        let v15 = if ((v14 as u128) >= v1) {
            0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::shares_to_burn(&v0)
        } else {
            0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_math::mul_div(0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::shares_to_burn(&v0), (v14 as u128), v1)
        };
        let v16 = build_actual_recall_plan(v13, v9, v7, v6, v5);
        0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::record_withdraw<0x2::sui::SUI>(arg1, &v0, &v16, v14, 0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::id<0x2::sui::SUI>(&arg2), 0x2::tx_context::sender(arg27), arg26);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v8, arg27), 0x2::tx_context::sender(arg27));
        if (0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::deduct_from_position<0x2::sui::SUI>(arg1, &mut arg2, v15, (v14 as u128)) == 0) {
            0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_withdraw::destroy_empty_position<0x2::sui::SUI>(arg2);
        } else {
            0x2::transfer::public_transfer<0xb3cdb8c5f9b604e6986e84598aa6ea6a7bf1c6d81fda29ad6033d4e1ff8de575::llv_position::LLVPoolPosition<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg27));
        };
    }

    // decompiled from Move bytecode v6
}

