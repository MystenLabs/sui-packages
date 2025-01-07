module 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::rebalance_stg {
    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        rebalance_cap_id: 0x2::object::ID,
        lower_tick: u32,
        upper_tick: u32,
        lower_trigger_price: u128,
        upper_trigger_price: u128,
        current_sqrt_price: u128,
        timestamp_ms: u64,
        last_rebalance_time: u64,
        lp_residual_event_a: 0x1::option::Option<LpResidualEvent>,
        lp_residual_event_b: 0x1::option::Option<LpResidualEvent>,
    }

    struct LpResidualEvent has copy, drop {
        vault_id: 0x2::object::ID,
        rebalance_cap_id: 0x2::object::ID,
        lp_coin_a: u64,
        lp_coin_b: u64,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        is_a: bool,
        swap_amt: u64,
        residual_coin_a: u64,
        residual_coin_b: u64,
        timestamp_ms: u64,
    }

    fun emit_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u32, arg4: u32, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: 0x1::option::Option<LpResidualEvent>, arg10: 0x1::option::Option<LpResidualEvent>) {
        let v0 = RebalanceEvent{
            vault_id            : arg0,
            rebalance_cap_id    : arg1,
            lower_tick          : arg3,
            upper_tick          : arg4,
            lower_trigger_price : arg5,
            upper_trigger_price : arg6,
            current_sqrt_price  : arg2,
            timestamp_ms        : arg7,
            last_rebalance_time : arg8,
            lp_residual_event_a : arg9,
            lp_residual_event_b : arg10,
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    public fun lp_residual_amount<T0, T1, T2>(arg0: &mut 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::Vault<T0, T1, T2>, arg1: &mut 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: &0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::RebalanceCap, arg6: &0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::version_stg::Version, arg7: &0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::version::Version, arg8: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<LpResidualEvent>, 0x1::option::Option<LpResidualEvent>) {
        0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::version_stg::assert_current_version(arg6);
        0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::assert_rebalance_cap<T0, T1, T2>(arg0, arg5, arg8);
        0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let v0 = 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::pool::sqrt_price<T0, T1>(arg1);
        let (v1, v2) = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::slippage<T0, T1, T2>(arg0);
        let v3 = 0x1::option::none<LpResidualEvent>();
        let v4 = 0x1::option::none<LpResidualEvent>();
        if (arg3 && (0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::free_balance_a_val<T0, T1, T2>(arg0) > 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::free_threshold_a<T0, T1, T2>(arg0) || arg4 > 0)) {
            let v5 = if (arg4 == 0) {
                let (v6, _) = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0, arg1, 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::free_balance_a_val<T0, T1, T2>(arg0), true, 10);
                v6
            } else {
                arg4
            };
            let v8 = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::get_free_balance_a<T0, T1, T2>(arg0);
            assert!(v5 <= 0x2::balance::value<T0>(&v8), 10);
            let (v9, v10) = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::utils_stg::swap<T0, T1>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v5), arg8), 0x2::coin::zero<T1>(arg8), true, true, v5, 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::utils_stg::slippage_adjusted_sqrt_price(true, v1, v2, v0), arg2, arg7, arg8);
            let v11 = v10;
            0x2::coin::destroy_zero<T0>(v9);
            let v12 = 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::pool::sqrt_price<T0, T1>(arg1);
            let (v13, v14) = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::get_position_tick_range<T0, T1, T2>(arg0);
            let (_, v16, v17) = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::utils_stg::check_is_fix_coin_a(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::tick_math::get_sqrt_price_at_tick(v13), 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::tick_math::get_sqrt_price_at_tick(v14), v12, 0x2::balance::value<T0>(&v8), 0x2::coin::value<T1>(&v11));
            let (v18, v19) = 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::liquidity::add_liquidity<T0, T1>(arg1, 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::position_borrow_mut<T0, T1, T2>(arg0), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v16), arg8), 0x2::coin::split<T1>(&mut v11, v17, arg8), 0, 0, arg2, arg7, arg8);
            let v20 = v19;
            let v21 = v18;
            0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::add_free_balance_a<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(v21));
            0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::add_free_balance_b<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(v20));
            0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::add_free_balance_a<T0, T1, T2>(arg0, v8);
            0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::add_free_balance_b<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(v11));
            let v22 = LpResidualEvent{
                vault_id          : 0x2::object::id<0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::Vault<T0, T1, T2>>(arg0),
                rebalance_cap_id  : 0x2::object::id<0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::RebalanceCap>(arg5),
                lp_coin_a         : v16 - 0x2::coin::value<T0>(&v21),
                lp_coin_b         : v17 - 0x2::coin::value<T1>(&v20),
                before_sqrt_price : v0,
                after_sqrt_price  : v12,
                is_a              : arg3,
                swap_amt          : v5,
                residual_coin_a   : 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b   : 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::free_balance_b_val<T0, T1, T2>(arg0),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg2),
            };
            0x1::option::fill<LpResidualEvent>(&mut v3, v22);
            0x2::event::emit<LpResidualEvent>(v22);
        };
        if (!arg3 && (0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::free_balance_b_val<T0, T1, T2>(arg0) > 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::free_threshold_b<T0, T1, T2>(arg0) || arg4 > 0)) {
            let v23 = if (arg4 == 0) {
                let (v24, _) = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0, arg1, 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::free_balance_b_val<T0, T1, T2>(arg0), false, 10);
                v24
            } else {
                arg4
            };
            let v26 = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::get_free_balance_b<T0, T1, T2>(arg0);
            assert!(v23 <= 0x2::balance::value<T1>(&v26), 11);
            let (v27, v28) = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::utils_stg::swap<T0, T1>(arg1, 0x2::coin::zero<T0>(arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v26, v23), arg8), false, true, v23, 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::utils_stg::slippage_adjusted_sqrt_price(false, v1, v2, v0), arg2, arg7, arg8);
            let v29 = v27;
            0x2::coin::destroy_zero<T1>(v28);
            let v30 = 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::pool::sqrt_price<T0, T1>(arg1);
            let (v31, v32) = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::get_position_tick_range<T0, T1, T2>(arg0);
            let (_, v34, v35) = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::utils_stg::check_is_fix_coin_a(0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::tick_math::get_sqrt_price_at_tick(v31), 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::tick_math::get_sqrt_price_at_tick(v32), v30, 0x2::coin::value<T0>(&v29), 0x2::balance::value<T1>(&v26));
            let (v36, v37) = 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::liquidity::add_liquidity<T0, T1>(arg1, 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::position_borrow_mut<T0, T1, T2>(arg0), 0x2::coin::split<T0>(&mut v29, v34, arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v26, v35), arg8), 0, 0, arg2, arg7, arg8);
            let v38 = v37;
            let v39 = v36;
            0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::add_free_balance_b<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(v38));
            0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::add_free_balance_a<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(v39));
            0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::add_free_balance_b<T0, T1, T2>(arg0, v26);
            0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::add_free_balance_a<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(v29));
            let v40 = LpResidualEvent{
                vault_id          : 0x2::object::id<0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::Vault<T0, T1, T2>>(arg0),
                rebalance_cap_id  : 0x2::object::id<0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::RebalanceCap>(arg5),
                lp_coin_a         : 0x2::coin::value<T0>(&v39),
                lp_coin_b         : 0x2::coin::value<T1>(&v38),
                before_sqrt_price : v0,
                after_sqrt_price  : v30,
                is_a              : arg3,
                swap_amt          : v23,
                residual_coin_a   : 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b   : 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::free_balance_b_val<T0, T1, T2>(arg0),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg2),
            };
            0x1::option::fill<LpResidualEvent>(&mut v4, v40);
            0x2::event::emit<LpResidualEvent>(v40);
        };
        (v3, v4)
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::Vault<T0, T1, T2>, arg1: &mut 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::pool::Pool<T0, T1>, arg2: &0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::RebalanceCap, arg3: &mut 0x2::clock::Clock, arg4: &0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::version_stg::Version, arg5: &0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::assert_rebalance_cap<T0, T1, T2>(arg0, arg2, arg6);
        0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let v0 = 0x852221d796eaeb9680897ff2b77d2ba607c8a4fdd9a9f76e9eedd787deccc216::pool::sqrt_price<T0, T1>(arg1);
        let v1 = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::lower_trigger_price<T0, T1, T2>(arg0);
        let v2 = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::upper_trigger_price<T0, T1, T2>(arg0);
        assert!(v0 <= v1 || v0 >= v2 || v1 == 0 && v2 == 0, 0);
        let (v3, v4) = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::utils_stg::close_position<T0, T1, T2>(arg0, arg1, arg3, arg4, arg5, arg6);
        let v5 = v4;
        let v6 = v3;
        let (v7, v8, v9, v10) = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::utils_stg::create_position<T0, T1, T2>(arg0, arg1, &mut v6, &mut v5, arg3, arg5, arg6);
        0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::update_ticks_info<T0, T1, T2>(arg0, v7, v8);
        0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::update_trigger_ticks_info<T0, T1, T2>(arg0, v9, v10);
        0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::add_free_balance_a<T0, T1, T2>(arg0, v6);
        0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::add_free_balance_b<T0, T1, T2>(arg0, v5);
        let (v11, _) = lp_residual_amount<T0, T1, T2>(arg0, arg1, arg3, true, 0, arg2, arg4, arg5, arg6);
        let (_, v14) = lp_residual_amount<T0, T1, T2>(arg0, arg1, arg3, false, 0, arg2, arg4, arg5, arg6);
        0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::set_rebalance_time<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg3));
        emit_event(0x2::object::id<0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::Vault<T0, T1, T2>>(arg0), 0x2::object::id<0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::RebalanceCap>(arg2), v0, v7, v8, v9, v10, 0x2::clock::timestamp_ms(arg3), 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::vault_stg::last_rebalance_time<T0, T1, T2>(arg0), v11, v14);
    }

    // decompiled from Move bytecode v6
}

