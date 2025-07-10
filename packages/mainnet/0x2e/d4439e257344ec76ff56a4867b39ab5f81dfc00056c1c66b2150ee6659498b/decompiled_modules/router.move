module 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::router {
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

    public fun swap<T0, T1>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::RewarderGlobalVault, arg2: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u128, arg9: bool, arg10: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::stats::Stats, arg11: &0x6b50d71d78317657f9b69a59a8c257b52af91309a237157a3cd1f2622bf09490::price_provider::PriceProvider, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg6 && arg9) {
            let v0 = if (arg5) {
                0x2::coin::value<T0>(&arg3)
            } else {
                0x2::coin::value<T1>(&arg4)
            };
            arg7 = v0;
        };
        let (v1, v2, v3) = 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg10, arg11, arg12);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::swap_pay_amount<T0, T1>(&v4);
        let v8 = if (arg5) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        if (arg6) {
            assert!(v7 == arg7, 1);
        } else {
            assert!(v8 == arg7, 1);
        };
        let (v9, v10) = if (arg5) {
            assert!(0x2::coin::value<T0>(&arg3) >= v7, 4);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v7, arg13)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v7, arg13)))
        };
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v6, arg13));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v5, arg13));
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::repay_flash_swap<T0, T1>(arg0, arg2, v9, v10, v4);
        (arg3, arg4)
    }

    public fun calculate_router_swap_result<T0, T1, T2, T3>(arg0: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T0, T1>, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T2, T3>, arg2: bool, arg3: bool, arg4: bool, arg5: u64) {
        if (arg4) {
            let v0 = 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap<T0, T1>(arg0, arg2, arg4, arg5);
            let v1 = 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_amount_out(&v0);
            if (0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_is_exceed(&v0) || v1 > 18446744073709551615) {
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
                let v5 = 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap<T2, T3>(arg1, arg3, arg4, v4);
                let v6 = 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_amount_out(&v5);
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
                    let v9 = 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_is_exceed(&v0) || 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_is_exceed(&v5);
                    let v10 = CalculatedRouterSwapResult{
                        amount_in             : arg5,
                        amount_medium         : v4,
                        amount_out            : (v6 as u64),
                        is_exceed             : v9,
                        current_sqrt_price_ab : 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::current_sqrt_price<T0, T1>(arg0),
                        current_sqrt_price_cd : 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::current_sqrt_price<T2, T3>(arg1),
                        target_sqrt_price_ab  : 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_after_sqrt_price(&v0),
                        target_sqrt_price_cd  : 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_after_sqrt_price(&v5),
                    };
                    let v11 = CalculatedRouterSwapResultEvent{data: v10};
                    0x2::event::emit<CalculatedRouterSwapResultEvent>(v11);
                };
            };
        } else {
            let v12 = 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap<T2, T3>(arg1, arg3, arg4, arg5);
            let v13 = 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_is_exceed(&v12);
            let v14 = 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_amount_in(&v12);
            if (v13 || v14 > 18446744073709551615) {
                let v15 = CalculatedRouterSwapResult{
                    amount_in             : 0,
                    amount_medium         : 0,
                    amount_out            : 0,
                    is_exceed             : true,
                    current_sqrt_price_ab : 0,
                    current_sqrt_price_cd : 0,
                    target_sqrt_price_ab  : 0,
                    target_sqrt_price_cd  : 0,
                };
                let v16 = CalculatedRouterSwapResultEvent{data: v15};
                0x2::event::emit<CalculatedRouterSwapResultEvent>(v16);
            } else {
                let v17 = (v14 as u64);
                let v18 = (0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_fee_amount(&v12) as u64);
                let v19 = 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap<T0, T1>(arg0, arg2, arg4, v17 + v18);
                let v20 = 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_amount_in(&v19);
                if (v20 > 18446744073709551615) {
                    let v21 = CalculatedRouterSwapResult{
                        amount_in             : 0,
                        amount_medium         : 0,
                        amount_out            : 0,
                        is_exceed             : true,
                        current_sqrt_price_ab : 0,
                        current_sqrt_price_cd : 0,
                        target_sqrt_price_ab  : 0,
                        target_sqrt_price_cd  : 0,
                    };
                    let v22 = CalculatedRouterSwapResultEvent{data: v21};
                    0x2::event::emit<CalculatedRouterSwapResultEvent>(v22);
                } else {
                    let v23 = 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_is_exceed(&v19) || v13;
                    let v24 = CalculatedRouterSwapResult{
                        amount_in             : (v20 as u64) + (0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_fee_amount(&v19) as u64),
                        amount_medium         : v17 + v18,
                        amount_out            : arg5,
                        is_exceed             : v23,
                        current_sqrt_price_ab : 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::current_sqrt_price<T0, T1>(arg0),
                        current_sqrt_price_cd : 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::current_sqrt_price<T2, T3>(arg1),
                        target_sqrt_price_ab  : 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_after_sqrt_price(&v19),
                        target_sqrt_price_cd  : 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::expect_swap::expect_swap_result_after_sqrt_price(&v12),
                    };
                    let v25 = CalculatedRouterSwapResultEvent{data: v24};
                    0x2::event::emit<CalculatedRouterSwapResultEvent>(v25);
                };
            };
        };
    }

    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 4);
    }

    public fun swap_ab_bc<T0, T1, T2>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::RewarderGlobalVault, arg2: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T0, T1>, arg3: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T1, T2>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::stats::Stats, arg12: &0x6b50d71d78317657f9b69a59a8c257b52af91309a237157a3cd1f2622bf09490::price_provider::PriceProvider, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg14);
            let (v3, v4) = swap<T0, T1>(arg0, arg1, arg2, arg4, v2, true, true, arg7, arg9, false, arg11, arg12, arg13, arg14);
            let v5 = v4;
            let (v6, v7) = swap<T1, T2>(arg0, arg1, arg3, v5, arg5, true, true, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg12, arg13, arg14);
            let v8 = v6;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v3, v7)
        } else {
            let (v9, v10, v11) = 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::flash_swap<T1, T2>(arg0, arg1, arg3, true, false, arg8, arg10, arg11, arg12, arg13);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v9, arg14);
            let (v14, v15) = swap<T0, T1>(arg0, arg1, arg2, arg4, v13, true, false, 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::swap_pay_amount<T1, T2>(&v12), arg9, false, arg11, arg12, arg13, arg14);
            0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::repay_flash_swap<T1, T2>(arg0, arg3, 0x2::coin::into_balance<T1>(v15), 0x2::balance::zero<T2>(), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v10, arg14));
            (v14, arg5)
        }
    }

    public fun swap_ab_cb<T0, T1, T2>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::RewarderGlobalVault, arg2: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T0, T1>, arg3: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T2, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::stats::Stats, arg12: &0x2::clock::Clock, arg13: &0x6b50d71d78317657f9b69a59a8c257b52af91309a237157a3cd1f2622bf09490::price_provider::PriceProvider, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg14);
            let (v3, v4) = swap<T0, T1>(arg0, arg1, arg2, arg4, v2, true, arg6, arg7, arg9, false, arg11, arg13, arg12, arg14);
            let v5 = v4;
            let (v6, v7) = swap<T2, T1>(arg0, arg1, arg3, arg5, v5, false, true, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg13, arg12, arg14);
            let v8 = v7;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v3, v6)
        } else {
            let (v9, v10, v11) = 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::flash_swap<T2, T1>(arg0, arg1, arg3, false, false, arg8, arg10, arg11, arg13, arg12);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v10, arg14);
            let (v14, v15) = swap<T0, T1>(arg0, arg1, arg2, arg4, v13, true, false, 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::swap_pay_amount<T2, T1>(&v12), arg9, false, arg11, arg13, arg12, arg14);
            0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(v15), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v9, arg14));
            (v14, arg5)
        }
    }

    public fun swap_ba_bc<T0, T1, T2>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::RewarderGlobalVault, arg2: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T1, T0>, arg3: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T1, T2>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::stats::Stats, arg12: &0x6b50d71d78317657f9b69a59a8c257b52af91309a237157a3cd1f2622bf09490::price_provider::PriceProvider, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg14);
            let (v3, v4) = swap<T1, T0>(arg0, arg1, arg2, v2, arg4, false, arg6, arg7, arg9, false, arg11, arg12, arg13, arg14);
            let v5 = v3;
            let (v6, v7) = swap<T1, T2>(arg0, arg1, arg3, v5, arg5, true, true, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg12, arg13, arg14);
            let v8 = v6;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v4, v7)
        } else {
            let (v9, v10, v11) = 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::flash_swap<T1, T2>(arg0, arg1, arg3, true, false, arg8, arg10, arg11, arg12, arg13);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v9, arg14);
            let (v14, v15) = swap<T1, T0>(arg0, arg1, arg2, v13, arg4, false, false, 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::swap_pay_amount<T1, T2>(&v12), arg9, false, arg11, arg12, arg13, arg14);
            0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::repay_flash_swap<T1, T2>(arg0, arg3, 0x2::coin::into_balance<T1>(v14), 0x2::balance::zero<T2>(), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v10, arg14));
            (v15, arg5)
        }
    }

    public fun swap_ba_cb<T0, T1, T2>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::RewarderGlobalVault, arg2: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T1, T0>, arg3: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T2, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::stats::Stats, arg12: &0x6b50d71d78317657f9b69a59a8c257b52af91309a237157a3cd1f2622bf09490::price_provider::PriceProvider, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg14);
            let (v3, v4) = swap<T1, T0>(arg0, arg1, arg2, v2, arg4, false, true, arg7, arg9, false, arg11, arg12, arg13, arg14);
            let v5 = v3;
            let (v6, v7) = swap<T2, T1>(arg0, arg1, arg3, arg5, v5, false, arg6, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg12, arg13, arg14);
            let v8 = v7;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v4, v6)
        } else {
            let (v9, v10, v11) = 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::flash_swap<T2, T1>(arg0, arg1, arg3, false, false, arg8, arg10, arg11, arg12, arg13);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v10, arg14);
            let (v14, v15) = swap<T1, T0>(arg0, arg1, arg2, v13, arg4, false, false, 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::swap_pay_amount<T2, T1>(&v12), arg9, false, arg11, arg12, arg13, arg14);
            0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(v14), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v9, arg14));
            (v15, arg5)
        }
    }

    // decompiled from Move bytecode v6
}

