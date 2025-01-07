module 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::drift {
    struct RebalanceAdapterReceipt<phantom T0, phantom T1> {
        asset_a: 0x2::balance::Balance<T0>,
        asset_b: 0x2::balance::Balance<T1>,
        vault_id: 0x2::object::ID,
        current_sqrt_price: u128,
        price_a_to_b: u64,
        price_b_to_a: u64,
        lower_tick_index: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32,
        upper_tick_index: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32,
        target_handler: u8,
    }

    struct DriftData has copy, drop, store {
        price_a_to_b: u64,
        price_b_to_a: u64,
        sqrt_price_a_to_b: u128,
        sqrt_price_b_to_a: u128,
        current_sqrt_price: u128,
    }

    public fun asset_ratio_receipt_consumer<T0, T1, T2, T3: copy + drop + store>(arg0: RebalanceAdapterReceipt<T0, T1>, arg1: &mut 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::Vault<T0, T1, T2, T3>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::RebalanceCap, arg4: &0x2::clock::Clock, arg5: &0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::version::Version, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = receipt_position_tick_index<T0, T1>(&arg0);
        let (v2, v3) = burn_receipt<T0, T1>(arg0);
        let v4 = v3;
        let v5 = v2;
        0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::utils::add_liquidity<T0, T1, T2, T3>(arg1, arg2, &mut v5, &mut v4, arg4, arg6, arg7);
        0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::update_ticks_info<T0, T1, T2, T3>(arg1, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v1));
        0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::add_free_balance_a<T0, T1, T2, T3>(arg1, v5);
        0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::add_free_balance_b<T0, T1, T2, T3>(arg1, v4);
        let (v6, _) = 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::common::lp_residual_amount<T0, T1, T2, T3>(arg1, arg2, arg4, true, 0, arg3, arg5, arg6, arg7);
        let (_, v9) = 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::common::lp_residual_amount<T0, T1, T2, T3>(arg1, arg2, arg4, false, 0, arg3, arg5, arg6, arg7);
        0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::set_rebalance_time<T0, T1, T2, T3>(arg1, 0x2::clock::timestamp_ms(arg4));
        0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::common::emit_rebalance_event(0x2::object::id<0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::Vault<T0, T1, T2, T3>>(arg1), 0x2::object::id<0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::RebalanceCap>(arg3), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg2), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v1), 0, 0, 0x2::clock::timestamp_ms(arg4), 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::last_rebalance_time<T0, T1, T2, T3>(arg1), v6, v9, 0x1::ascii::string(b"drift_vault"));
    }

    fun burn_receipt<T0, T1>(arg0: RebalanceAdapterReceipt<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let RebalanceAdapterReceipt {
            asset_a            : v0,
            asset_b            : v1,
            vault_id           : _,
            current_sqrt_price : _,
            price_a_to_b       : _,
            price_b_to_a       : _,
            lower_tick_index   : _,
            upper_tick_index   : _,
            target_handler     : _,
        } = arg0;
        (v0, v1)
    }

    public(friend) fun extract_assets<T0, T1>(arg0: &mut RebalanceAdapterReceipt<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::balance::split<T0>(&mut arg0.asset_a, 0x2::balance::value<T0>(&arg0.asset_a)), 0x2::balance::split<T1>(&mut arg0.asset_b, 0x2::balance::value<T1>(&arg0.asset_b)))
    }

    public(friend) fun fill_assets<T0, T1>(arg0: &mut RebalanceAdapterReceipt<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.asset_a, arg1);
        0x2::balance::join<T1>(&mut arg0.asset_b, arg2);
    }

    public fun get_vsui_stake_rate_sqrt_price(arg0: &mut 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64) {
        let (v0, v1) = if (0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0) >= 1000000000) {
            let v2 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::mint_ticket_non_entry(arg2, arg4, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x2::balance::split<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, 1000000000), arg5), arg5);
            assert!(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket::is_unlocked(&v2, arg5), 0);
            let v3 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::burn_ticket_non_entry(arg2, arg3, v2, arg5);
            let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
            0x2::balance::join<0x2::sui::SUI>(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
            (v4, (((1000000000 as u128) * 1000000000 / (v4 as u128)) as u64))
        } else {
            assert!(0x2::balance::value<0x2::sui::SUI>(arg1) >= 1000000000, 101);
            let v5 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::stake_non_entry(arg2, arg4, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg1, 1000000000), arg5), arg5);
            0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, 0x2::coin::into_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v5));
            ((((1000000000 as u128) * 1000000000 / (0x2::coin::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v5) as u128)) as u64), 0x2::coin::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v5))
        };
        (0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::utils::oracle_price_to_sqrt_price(v0, 9, 9), 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::utils::oracle_price_to_sqrt_price(v1, 9, 9), v0, v1)
    }

    public fun rebalance_vsui_sui<T0>(arg0: &mut 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::Vault<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::config::Drift>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg2: &0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::RebalanceCap, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg6: &0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::version::Version, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : RebalanceAdapterReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI> {
        0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::assert_rebalance_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::config::Drift>(arg0, arg2, arg9);
        0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::check_pool_compatibility<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::config::Drift>(arg0, arg1);
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg1);
        let (v1, v2) = 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::utils::close_position<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::config::Drift>(arg0, arg1, arg8, arg6, arg7, arg9);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = &mut v3;
        let (v7, v8, v9, v10) = get_vsui_stake_rate_sqrt_price(v5, v6, arg3, arg4, arg5, arg9);
        assert!(v7 > 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::config::drift_trigger_price(0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::borrow_config<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::config::Drift>(arg0)), 23);
        let (v11, v12) = 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::get_price_scalling<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::config::Drift>(arg0);
        let (v13, v14) = 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::utils::get_scalled_position_bounds(v0, v11, v12, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg1));
        0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::utils::create_position<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::config::Drift>(arg0, arg1, v14, v13, arg7, arg9);
        0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::utils::add_liquidity<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::config::Drift>(arg0, arg1, &mut v4, &mut v3, arg8, arg7, arg9);
        let v15 = DriftData{
            price_a_to_b       : v9,
            price_b_to_a       : v10,
            sqrt_price_a_to_b  : v7,
            sqrt_price_b_to_a  : v8,
            current_sqrt_price : v0,
        };
        0x2::event::emit<DriftData>(v15);
        RebalanceAdapterReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>{
            asset_a            : v4,
            asset_b            : v3,
            vault_id           : 0x2::object::id<0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::vault::Vault<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, T0, 0x4dc19e187906bc7394b398721c1247c10157c2c978887345554ab15817ab4f19::config::Drift>>(arg0),
            current_sqrt_price : v0,
            price_a_to_b       : v9,
            price_b_to_a       : v10,
            lower_tick_index   : v13,
            upper_tick_index   : v14,
            target_handler     : 1,
        }
    }

    public fun receipt_position_tick_index<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32) {
        (arg0.lower_tick_index, arg0.upper_tick_index)
    }

    public fun receipt_prices<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : (u128, u64, u64) {
        (arg0.current_sqrt_price, arg0.price_a_to_b, arg0.price_b_to_a)
    }

    public fun receipt_target_handler<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : u8 {
        arg0.target_handler
    }

    public fun receipt_vault_id<T0, T1>(arg0: &RebalanceAdapterReceipt<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

