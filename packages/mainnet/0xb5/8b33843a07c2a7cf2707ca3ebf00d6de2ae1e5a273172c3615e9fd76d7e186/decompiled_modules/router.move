module 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::router {
    struct CalculatedRouterSwapResult has copy, drop, store {
        amount_in: u64,
        amount_medium: u64,
        amount_out: u64,
        is_exceed: bool,
        current_sqrt_price_ab: u128,
        current_sqrt_price_cd: u128,
        target_sqrt_price_ab: u128,
        target_sqrt_price_cd: u128,
    }

    struct CalculatedRouterSwapResultEvent has copy, drop, store {
        data: CalculatedRouterSwapResult,
    }

    public fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg5) {
            assert!(v6 == arg6, 1);
            assert!(v7 >= arg7, 2);
        } else {
            assert!(v7 == arg6, 1);
            assert!(v6 <= arg7, 3);
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v6, arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v6, arg10)))
        };
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg10));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg10));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v3);
        (arg2, arg3)
    }

    public fun UpdateCalculatedRouterSwapResult(arg0: &mut CalculatedRouterSwapResult, arg1: u64, arg2: u64, arg3: bool) : &mut CalculatedRouterSwapResult {
        arg0.amount_in = arg1;
        arg0.amount_out = arg2;
        arg0.is_exceed = arg3;
        arg0
    }

    public fun calculate_router_swap_result<T0, T1, T2, T3>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: bool, arg3: bool, arg4: bool, arg5: u64) {
        if (arg4) {
            let v0 = 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap<T0, T1>(arg0, arg2, arg4, arg5);
            let v1 = 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_amount_out(&v0);
            if (0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_is_exceed(&v0) || v1 > 18446744073709551615) {
                let v2 = CalculatedRouterSwapResult{
                    amount_in             : 0,
                    amount_medium         : 0,
                    amount_out            : 0,
                    is_exceed             : true,
                    current_sqrt_price_ab : 0,
                    current_sqrt_price_cd : 0,
                    target_sqrt_price_ab  : 0,
                    target_sqrt_price_cd  : 0,
                };
                let v3 = CalculatedRouterSwapResultEvent{data: v2};
                0x2::event::emit<CalculatedRouterSwapResultEvent>(v3);
            } else {
                let v4 = (v1 as u64);
                let v5 = 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap<T2, T3>(arg1, arg3, arg4, v4);
                let v6 = 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_amount_out(&v5);
                if (v6 > 18446744073709551615) {
                    let v7 = CalculatedRouterSwapResult{
                        amount_in             : 0,
                        amount_medium         : 0,
                        amount_out            : 0,
                        is_exceed             : true,
                        current_sqrt_price_ab : 0,
                        current_sqrt_price_cd : 0,
                        target_sqrt_price_ab  : 0,
                        target_sqrt_price_cd  : 0,
                    };
                    let v8 = CalculatedRouterSwapResultEvent{data: v7};
                    0x2::event::emit<CalculatedRouterSwapResultEvent>(v8);
                } else {
                    let v9 = CalculatedRouterSwapResult{
                        amount_in             : arg5,
                        amount_medium         : v4,
                        amount_out            : (v6 as u64),
                        is_exceed             : 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_is_exceed(&v0) || 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_is_exceed(&v5),
                        current_sqrt_price_ab : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
                        current_sqrt_price_cd : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg1),
                        target_sqrt_price_ab  : 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_after_sqrt_price(&v0),
                        target_sqrt_price_cd  : 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_after_sqrt_price(&v5),
                    };
                    let v10 = CalculatedRouterSwapResultEvent{data: v9};
                    0x2::event::emit<CalculatedRouterSwapResultEvent>(v10);
                };
            };
        } else {
            let v11 = 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap<T2, T3>(arg1, arg3, arg4, arg5);
            let v12 = 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_is_exceed(&v11);
            let v13 = 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_amount_in(&v11);
            if (v12 || v13 > 18446744073709551615) {
                let v14 = CalculatedRouterSwapResult{
                    amount_in             : 0,
                    amount_medium         : 0,
                    amount_out            : 0,
                    is_exceed             : true,
                    current_sqrt_price_ab : 0,
                    current_sqrt_price_cd : 0,
                    target_sqrt_price_ab  : 0,
                    target_sqrt_price_cd  : 0,
                };
                let v15 = CalculatedRouterSwapResultEvent{data: v14};
                0x2::event::emit<CalculatedRouterSwapResultEvent>(v15);
            } else {
                let v16 = (v13 as u64);
                let v17 = (0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_fee_amount(&v11) as u64);
                let v18 = 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap<T0, T1>(arg0, arg2, arg4, v16 + v17);
                let v19 = 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_amount_in(&v18);
                if (v19 > 18446744073709551615) {
                    let v20 = CalculatedRouterSwapResult{
                        amount_in             : 0,
                        amount_medium         : 0,
                        amount_out            : 0,
                        is_exceed             : true,
                        current_sqrt_price_ab : 0,
                        current_sqrt_price_cd : 0,
                        target_sqrt_price_ab  : 0,
                        target_sqrt_price_cd  : 0,
                    };
                    let v21 = CalculatedRouterSwapResultEvent{data: v20};
                    0x2::event::emit<CalculatedRouterSwapResultEvent>(v21);
                } else {
                    let v22 = CalculatedRouterSwapResult{
                        amount_in             : (v19 as u64) + (0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_fee_amount(&v18) as u64),
                        amount_medium         : v16 + v17,
                        amount_out            : arg5,
                        is_exceed             : 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_is_exceed(&v18) || v12,
                        current_sqrt_price_ab : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
                        current_sqrt_price_cd : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg1),
                        target_sqrt_price_ab  : 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_after_sqrt_price(&v18),
                        target_sqrt_price_cd  : 0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::expect_swap::expect_swap_result_after_sqrt_price(&v11),
                    };
                    let v23 = CalculatedRouterSwapResultEvent{data: v22};
                    0x2::event::emit<CalculatedRouterSwapResultEvent>(v23);
                };
            };
        };
    }

    public entry fun swap_ab_bc<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            let v0 = 0x2::coin::zero<T1>(arg13);
            let (v1, v2) = swap<T0, T1>(arg0, arg1, arg3, v0, true, true, arg6, arg8, arg10, arg12, arg13);
            let v3 = v2;
            let v4 = 0x2::coin::value<T1>(&v3);
            assert!(v4 >= arg7, 0);
            let (v5, v6) = swap<T1, T2>(arg0, arg2, v3, arg4, true, true, v4, arg9, arg11, arg12, arg13);
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T1>(v5, 0x2::tx_context::sender(arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T2>(v6, 0x2::tx_context::sender(arg13));
        } else {
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, false, arg7, arg11, arg12);
            let v10 = v9;
            let v11 = 0x2::coin::from_balance<T1>(v7, arg13);
            let (v12, v13) = swap<T0, T1>(arg0, arg1, arg3, v11, true, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v10), arg8, arg10, arg12, arg13);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::coin::into_balance<T1>(v13), 0x2::balance::zero<T2>(), v10);
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T0>(v12, 0x2::tx_context::sender(arg13));
            0x2::coin::join<T2>(&mut arg4, 0x2::coin::from_balance<T2>(v8, arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T2>(arg4, 0x2::tx_context::sender(arg13));
        };
    }

    public entry fun swap_ab_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            let v0 = 0x2::coin::zero<T1>(arg13);
            let (v1, v2) = swap<T0, T1>(arg0, arg1, arg3, v0, true, arg5, arg6, arg8, arg10, arg12, arg13);
            let v3 = v2;
            let v4 = 0x2::coin::value<T1>(&v3);
            assert!(v4 >= arg7, 0);
            let (v5, v6) = swap<T2, T1>(arg0, arg2, arg4, v3, false, true, v4, arg9, arg11, arg12, arg13);
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T1>(v6, 0x2::tx_context::sender(arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T2>(v5, 0x2::tx_context::sender(arg13));
        } else {
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, false, arg7, arg11, arg12);
            let v10 = v9;
            let v11 = 0x2::coin::from_balance<T1>(v8, arg13);
            let (v12, v13) = swap<T0, T1>(arg0, arg1, arg3, v11, true, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v10), arg8, arg10, arg12, arg13);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(v13), v10);
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T0>(v12, 0x2::tx_context::sender(arg13));
            0x2::coin::join<T2>(&mut arg4, 0x2::coin::from_balance<T2>(v7, arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T2>(arg4, 0x2::tx_context::sender(arg13));
        };
    }

    public entry fun swap_ba_bc<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            let v0 = 0x2::coin::zero<T1>(arg13);
            let (v1, v2) = swap<T1, T0>(arg0, arg1, v0, arg3, false, arg5, arg6, arg8, arg10, arg12, arg13);
            let v3 = v1;
            let v4 = 0x2::coin::value<T1>(&v3);
            assert!(v4 >= arg7, 0);
            let (v5, v6) = swap<T1, T2>(arg0, arg2, v3, arg4, true, true, v4, arg9, arg11, arg12, arg13);
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T1>(v5, 0x2::tx_context::sender(arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T2>(v6, 0x2::tx_context::sender(arg13));
        } else {
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, false, arg7, arg11, arg12);
            let v10 = v9;
            let v11 = 0x2::coin::from_balance<T1>(v7, arg13);
            let (v12, v13) = swap<T1, T0>(arg0, arg1, v11, arg3, false, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v10), arg8, arg10, arg12, arg13);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::coin::into_balance<T1>(v12), 0x2::balance::zero<T2>(), v10);
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T0>(v13, 0x2::tx_context::sender(arg13));
            0x2::coin::join<T2>(&mut arg4, 0x2::coin::from_balance<T2>(v8, arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T2>(arg4, 0x2::tx_context::sender(arg13));
        };
    }

    public entry fun swap_ba_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            let v0 = 0x2::coin::zero<T1>(arg13);
            let (v1, v2) = swap<T1, T0>(arg0, arg1, v0, arg3, false, true, arg6, arg8, arg10, arg12, arg13);
            let v3 = v1;
            let v4 = 0x2::coin::value<T1>(&v3);
            assert!(v4 >= arg7, 0);
            let (v5, v6) = swap<T2, T1>(arg0, arg2, arg4, v3, false, arg5, v4, arg9, arg11, arg12, arg13);
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T1>(v6, 0x2::tx_context::sender(arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T2>(v5, 0x2::tx_context::sender(arg13));
        } else {
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, false, arg7, arg11, arg12);
            let v10 = v9;
            let v11 = 0x2::coin::from_balance<T1>(v8, arg13);
            let (v12, v13) = swap<T1, T0>(arg0, arg1, v11, arg3, false, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v10), arg8, arg10, arg12, arg13);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(v12), v10);
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T0>(v13, 0x2::tx_context::sender(arg13));
            0x2::coin::join<T2>(&mut arg4, 0x2::coin::from_balance<T2>(v7, arg13));
            0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be::utils::send_coin<T2>(arg4, 0x2::tx_context::sender(arg13));
        };
    }

    // decompiled from Move bytecode v6
}

