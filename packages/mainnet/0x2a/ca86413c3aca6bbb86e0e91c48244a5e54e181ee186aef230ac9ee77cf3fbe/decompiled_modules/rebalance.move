module 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::rebalance {
    public entry fun rebalance<T0, T1, T2>(arg0: &mut 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) - 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::last_rebalance_time<T0, T1, T2>(arg0) >= 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::min_rebalance_time<T0, T1, T2>(arg0), 0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) != 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::last_rebalance_sqrt_price<T0, T1, T2>(arg0), 0);
        0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::collect::fees<T0, T1, T2>(arg0, arg1, arg2, arg4);
        let (v0, v1) = 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::utils::close_position<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::utils::create_position<T0, T1, T2>(arg0, arg1, arg2, &mut v3, &mut v2, arg3, arg4);
        0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::add_free_balance_a<T0, T1, T2>(arg0, v3);
        0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::add_free_balance_b<T0, T1, T2>(arg0, v2);
        lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg4);
        lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg3, false, arg4);
    }

    fun calc_swap_amount(arg0: u64) : u64 {
        arg0 / 2
    }

    public fun lp_residual_amount<T0, T1, T2>(arg0: &mut 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg4 && 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::free_balance_a_val<T0, T1, T2>(arg0) > 0) {
            let v0 = 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::get_free_balance_a<T0, T1, T2>(arg0);
            let v1 = calc_swap_amount(0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::free_balance_a_val<T0, T1, T2>(arg0));
            let (v2, v3) = 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, v1), arg5), 0x2::coin::zero<T1>(arg5), true, true, v1, 4295048016, arg3, arg5);
            let v4 = v3;
            0x2::coin::destroy_zero<T0>(v2);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, v0, 0x2::coin::into_balance<T1>(v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::position_borrow_mut<T0, T1, T2>(arg0), 0x2::coin::value<T1>(&v4), false, arg3));
        };
        if (!arg4 && 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::free_balance_b_val<T0, T1, T2>(arg0) > 0) {
            let v5 = 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::get_free_balance_b<T0, T1, T2>(arg0);
            let v6 = calc_swap_amount(0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::free_balance_b_val<T0, T1, T2>(arg0));
            let (v7, v8) = 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v6), arg5), false, true, v6, 79226673515401279992447579055, arg3, arg5);
            let v9 = v7;
            0x2::coin::destroy_zero<T1>(v8);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::coin::into_balance<T0>(v9), v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0x2aca86413c3aca6bbb86e0e91c48244a5e54e181ee186aef230ac9ee77cf3fbe::vault::position_borrow_mut<T0, T1, T2>(arg0), 0x2::coin::value<T0>(&v9), true, arg3));
        };
    }

    // decompiled from Move bytecode v6
}

