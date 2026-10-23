module 0x147fc64fb4d1377811596b14f9c1aba6944d3f420336bcc77505f2999c534e45::exec {
    public fun assert_min(arg0: &0x2::coin::Coin<0x2::sui::SUI>, arg1: u64) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= arg1, 1);
    }

    fun b_quote_to_sui<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg1: u64, arg2: u128) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, 0x2::sui::SUI>(arg0, true, true, arg1, arg2);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) == 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0)
        } else {
            0
        }
    }

    fun b_swap_to_sui<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return 0x2::coin::zero<0x2::sui::SUI>(arg5)
        };
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg4, arg0, arg1, true, true, v0, arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v4), arg5)), 0x2::balance::zero<0x2::sui::SUI>(), v4);
        keep_or_zero<T0>(arg2, arg5);
        0x2::coin::from_balance<0x2::sui::SUI>(v2, arg5)
    }

    public fun bluefin_direct_cycle<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        bluefin_direct_cycle_n<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, 1, arg19, arg20)
    }

    public fun bluefin_direct_cycle_n<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        check(arg21);
        let v0 = !arg14;
        let v1 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg1), arg18, v0);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg16)) {
            let v6 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v5));
            if (v6 > 0) {
                let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, T2>(arg1, v0, false, v6, v1);
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v7) == 0) {
                    let v8 = sub0(s_quote_n<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v6, arg14, arg19, arg20), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v7));
                    if (v8 > v2) {
                        v3 = v8;
                        v4 = v6;
                    };
                };
            };
            v5 = v5 + 1;
        };
        if (v3 <= arg17) {
            return (0x2::coin::zero<T1>(arg21), 0x2::coin::zero<T2>(arg21))
        };
        let (v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg20, arg0, arg1, v0, false, v4, v1);
        let v12 = v11;
        if (arg14) {
            0x2::balance::destroy_zero<T2>(v10);
            let v15 = 0x2::coin::from_balance<T1>(v9, arg21);
            let v16 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v15, arg19, arg20, arg21);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v16, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v12), arg21)), v12);
            (0x2::coin::zero<T1>(arg21), v16)
        } else {
            0x2::balance::destroy_zero<T1>(v9);
            let v17 = 0x2::coin::from_balance<T2>(v10, arg21);
            let v18 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v17, arg19, arg20, arg21);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v18, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v12), arg21)), 0x2::balance::zero<T2>(), v12);
            (v18, 0x2::coin::zero<T2>(arg21))
        }
    }

    fun bs_quote_b_to_sui<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg1: u64, arg2: u128) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, T0>(arg0, false, true, arg1, arg2);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) == 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0)
        } else {
            0
        }
    }

    fun bs_quote_pay_sui<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg1: u64, arg2: u128) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, T0>(arg0, true, false, arg1, arg2);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) == 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0)
        } else {
            0
        }
    }

    fun bs_swap_b_to_sui<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return 0x2::coin::zero<0x2::sui::SUI>(arg5)
        };
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T0>(arg4, arg0, arg1, false, true, v0, arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v4), arg5)), v4);
        keep_or_zero<T0>(arg2, arg5);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5)
    }

    fun c_quote_to_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, true, true, arg1);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0)) {
            0
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
        }
    }

    public fun cetus_direct_cycle<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        cetus_direct_cycle_n<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, 1, arg18, arg19)
    }

    public fun cetus_direct_cycle_n<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        check(arg20);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg16)) {
            let v4 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, T1>(arg1, arg14, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = sub0(s_quote_n<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v4, arg14, arg18, arg19), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                    if (v6 > v0) {
                        v1 = v6;
                        v2 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg17) {
            return (0x2::coin::zero<T1>(arg20), 0x2::coin::zero<T2>(arg20))
        };
        if (arg14) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg1, true, false, v2, 4295048016, arg19);
            let v12 = v11;
            0x2::balance::destroy_zero<T2>(v9);
            let v13 = 0x2::coin::from_balance<T1>(v10, arg20);
            let v14 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v13, arg18, arg19, arg20);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg1, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v12), arg20)), 0x2::balance::zero<T1>(), v12);
            (0x2::coin::zero<T1>(arg20), v14)
        } else {
            let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg1, false, false, v2, 79226673515401279992447579055, arg19);
            let v18 = v17;
            0x2::balance::destroy_zero<T1>(v16);
            let v19 = 0x2::coin::from_balance<T2>(v15, arg20);
            let v20 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v19, arg18, arg19, arg20);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg1, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v20, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v18), arg20)), v18);
            (v20, 0x2::coin::zero<T2>(arg20))
        }
    }

    public fun cetus_direct_cycle_n_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: bool, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        check(arg21);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg17)) {
            let v4 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, T1>(arg2, arg15, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = sub0(s_quote_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v4, arg15, arg19, arg20), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                    if (v6 > v0) {
                        v1 = v6;
                        v2 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg18) {
            return (0x2::coin::zero<T1>(arg21), 0x2::coin::zero<T2>(arg21))
        };
        if (arg15) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T2, T1>(arg0, arg2, arg1, true, false, v2, 4295048016, arg20);
            let v12 = v11;
            0x2::balance::destroy_zero<T2>(v9);
            let v13 = 0x2::coin::from_balance<T1>(v10, arg21);
            let v14 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v13, arg19, arg20, arg21);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T2, T1>(arg0, arg2, arg1, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v12), arg21)), 0x2::balance::zero<T1>(), v12);
            (0x2::coin::zero<T1>(arg21), v14)
        } else {
            let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T2, T1>(arg0, arg2, arg1, false, false, v2, 79226673515401279992447579055, arg20);
            let v18 = v17;
            0x2::balance::destroy_zero<T1>(v16);
            let v19 = 0x2::coin::from_balance<T2>(v15, arg21);
            let v20 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v19, arg19, arg20, arg21);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T2, T1>(arg0, arg2, arg1, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v20, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v18), arg21)), v18);
            (v20, 0x2::coin::zero<T2>(arg21))
        }
    }

    public fun cetus_direct_cycle_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: bool, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        cetus_direct_cycle_n_p<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, 1, arg19, arg20)
    }

    public fun cetus_sui_cycle_buy<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        cetus_sui_cycle_buy_n<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, 1, arg18, arg19)
    }

    public fun cetus_sui_cycle_buy_n<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg20);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg16)) {
            let v4 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, 0x2::sui::SUI>(arg1, false, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = sub0(c_quote_to_sui<T1>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v4, false, arg18, arg19)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                    if (v6 > v0) {
                        v1 = v6;
                        v2 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg17) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg20)
        };
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, 0x2::sui::SUI>(arg0, arg1, false, false, v2, 79226673515401279992447579055, arg19);
        let v10 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let v11 = 0x2::coin::from_balance<T2>(v7, arg20);
        let v12 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v11, arg18, arg19, arg20);
        let v13 = swap_all<T1>(arg0, arg2, v12, arg19);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T2>(), 0x2::balance::split<0x2::sui::SUI>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v10)), v10);
        0x2::coin::from_balance<0x2::sui::SUI>(v13, arg20)
    }

    public fun cetus_sui_cycle_buy_n_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg21);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg17)) {
            let v4 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, 0x2::sui::SUI>(arg2, false, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = sub0(c_quote_to_sui<T1>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v4, false, arg19, arg20)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                    if (v6 > v0) {
                        v1 = v6;
                        v2 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg21)
        };
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T2, 0x2::sui::SUI>(arg0, arg2, arg1, false, false, v2, 79226673515401279992447579055, arg20);
        let v10 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let v11 = 0x2::coin::from_balance<T2>(v7, arg21);
        let v12 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v11, arg19, arg20, arg21);
        let v13 = swap_all_p<T1>(arg0, arg1, arg3, v12, arg20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T2, 0x2::sui::SUI>(arg0, arg2, arg1, 0x2::balance::zero<T2>(), 0x2::balance::split<0x2::sui::SUI>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v10)), v10);
        0x2::coin::from_balance<0x2::sui::SUI>(v13, arg21)
    }

    public fun cetus_sui_cycle_buy_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        cetus_sui_cycle_buy_n_p<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, 1, arg19, arg20)
    }

    public fun cetus_sui_cycle_sell<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        cetus_sui_cycle_sell_n<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, 1, arg18, arg19)
    }

    public fun cetus_sui_cycle_sell_n<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg20);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg16)) {
            let v4 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg1, false, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = sub0(c_quote_to_sui<T2>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v4, true, arg18, arg19)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                    if (v6 > v0) {
                        v1 = v6;
                        v2 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg17) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg20)
        };
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, false, false, v2, 79226673515401279992447579055, arg19);
        let v10 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg20);
        let v12 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v11, arg18, arg19, arg20);
        let v13 = swap_all<T2>(arg0, arg2, v12, arg19);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v10)), v10);
        0x2::coin::from_balance<0x2::sui::SUI>(v13, arg20)
    }

    public fun cetus_sui_cycle_sell_n_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg21);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg17)) {
            let v4 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg2, false, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = sub0(c_quote_to_sui<T2>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v4, true, arg19, arg20)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                    if (v6 > v0) {
                        v1 = v6;
                        v2 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg21)
        };
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, 0x2::sui::SUI>(arg0, arg2, arg1, false, false, v2, 79226673515401279992447579055, arg20);
        let v10 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg21);
        let v12 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v11, arg19, arg20, arg21);
        let v13 = swap_all_p<T2>(arg0, arg1, arg3, v12, arg20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, 0x2::sui::SUI>(arg0, arg2, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v10)), v10);
        0x2::coin::from_balance<0x2::sui::SUI>(v13, arg21)
    }

    public fun cetus_sui_cycle_sell_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        cetus_sui_cycle_sell_n_p<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, 1, arg19, arg20)
    }

    fun check(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xfda31f3b2ef24019a5554a64ad326128b6c08bd6e9835f6f143ad02a80b92f2e, 0);
    }

    fun clamp_n(arg0: u64) : u64 {
        if (arg0 == 0) {
            1
        } else if (arg0 > 8) {
            8
        } else {
            arg0
        }
    }

    fun d_quote_sui_to<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64) {
        if (arg1 == 0) {
            return (0, 0)
        };
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<0x2::sui::SUI, T0>(arg0, arg1, arg2);
        (v1, v0)
    }

    fun d_quote_to_sui<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<0x2::sui::SUI, T0>(arg0, arg1, arg2);
        v0
    }

    fun d_swap_to_sui<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return 0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<0x2::sui::SUI, T0>(arg0, arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        keep_or_zero<T0>(v1, arg3);
        v0
    }

    public fun deep_cycle<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: vector<u64>, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        deep_cycle_n<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, 1, arg17, arg18)
    }

    public fun deep_cycle_fx<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: vector<u64>, arg16: u64, arg17: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg18: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg19: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg20: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg21: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        deep_cycle_fx_n<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, 1, arg22, arg23)
    }

    public fun deep_cycle_fx_n<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: vector<u64>, arg16: u64, arg17: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg18: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg19: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg20: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg21: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg22: u64, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        check(arg24);
        let (_, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T1, T2>(arg0);
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&arg15)) {
            let v7 = frac(arg14, *0x1::vector::borrow<u64>(&arg15, v6));
            let v8 = if (arg13 || v1 == 0) {
                v7
            } else {
                v7 - v7 % v1
            };
            if (v8 > 0) {
                let v9 = if (arg13) {
                    let (v10, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T1, T2>(arg0, v8, arg23);
                    sub0(s_quote_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v10, true, arg22, arg23), v8)
                } else {
                    let (_, v14, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T1, T2>(arg0, v8, arg23);
                    sub0(s_quote_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v14, false, arg22, arg23), v8)
                };
                if (v9 > v3) {
                    v4 = v9;
                    v5 = v8;
                };
            };
            v6 = v6 + 1;
        };
        if (v4 <= arg16) {
            return (0x2::coin::zero<T1>(arg24), 0x2::coin::zero<T2>(arg24))
        };
        if (arg13) {
            let (v18, v19) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T1, T2>(arg0, v5, arg24);
            let v20 = fx_buy_base<T1, T2>(arg0, v18, arg17, arg18, arg19, arg20, arg21, arg23, arg24);
            let v21 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v20, arg22, arg23, arg24);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T1, T2>(arg0, 0x2::coin::split<T2>(&mut v21, v5, arg24), v19);
            (0x2::coin::zero<T1>(arg24), v21)
        } else {
            let (v22, v23) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T1, T2>(arg0, v5, arg24);
            let v24 = fx_sell_base<T1, T2>(arg0, v22, arg17, arg18, arg19, arg20, arg21, arg23, arg24);
            let v25 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v24, arg22, arg23, arg24);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T1, T2>(arg0, 0x2::coin::split<T1>(&mut v25, v5, arg24), v23);
            (v25, 0x2::coin::zero<T2>(arg24))
        }
    }

    public fun deep_cycle_hop<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: vector<u64>, arg16: u64, arg17: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        deep_cycle_hop_n<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, 1, arg18, arg19)
    }

    public fun deep_cycle_hop_n<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: vector<u64>, arg16: u64, arg17: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        check(arg20);
        let (_, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T1, T2>(arg0);
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&arg15)) {
            let v7 = frac(arg14, *0x1::vector::borrow<u64>(&arg15, v6));
            let v8 = if (arg13 || v1 == 0) {
                v7
            } else {
                v7 - v7 % v1
            };
            if (v8 > 0) {
                let v9 = if (arg13) {
                    let (v10, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T1, T2>(arg0, v8, arg19);
                    sub0(s_quote_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v10, true, arg18, arg19), v8)
                } else {
                    let (_, v14, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T1, T2>(arg0, v8, arg19);
                    sub0(s_quote_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v14, false, arg18, arg19), v8)
                };
                if (v9 > v3) {
                    v4 = v9;
                    v5 = v8;
                };
            };
            v6 = v6 + 1;
        };
        if (v4 <= arg16) {
            return (0x2::coin::zero<T1>(arg20), 0x2::coin::zero<T2>(arg20))
        };
        if (arg13) {
            let (v18, v19) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T1, T2>(arg0, v5, arg20);
            let v20 = hop_buy_base<T1, T2>(arg0, v18, arg17, arg19, arg20);
            let v21 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v20, arg18, arg19, arg20);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T1, T2>(arg0, 0x2::coin::split<T2>(&mut v21, v5, arg20), v19);
            (0x2::coin::zero<T1>(arg20), v21)
        } else {
            let (v22, v23) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T1, T2>(arg0, v5, arg20);
            let v24 = hop_sell_base<T1, T2>(arg0, v22, arg17, arg19, arg20);
            let v25 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v24, arg18, arg19, arg20);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T1, T2>(arg0, 0x2::coin::split<T1>(&mut v25, v5, arg20), v23);
            (v25, 0x2::coin::zero<T2>(arg20))
        }
    }

    public fun deep_cycle_n<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: vector<u64>, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        check(arg19);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg15)) {
            let v4 = frac(arg14, *0x1::vector::borrow<u64>(&arg15, v3));
            if (v4 > 0) {
                let v5 = if (arg13) {
                    let (v6, v7, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T1, T2>(arg0, v4, arg18);
                    sub0(s_quote_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v6, true, arg17, arg18) + v7, v4)
                } else {
                    let (v9, v10, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T1, T2>(arg0, v4, arg18);
                    sub0(s_quote_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v10, false, arg17, arg18) + v9, v4)
                };
                if (v5 > v0) {
                    v1 = v5;
                    v2 = v4;
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg16) {
            return (0x2::coin::zero<T1>(arg19), 0x2::coin::zero<T2>(arg19))
        };
        if (arg13) {
            let (v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T1, T2>(arg0, v2, arg19);
            let (v16, v17, v18) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg0, v14, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg19), 0, arg18, arg19);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v18);
            let v19 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v16, arg17, arg18, arg19);
            0x2::coin::join<T2>(&mut v19, v17);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T1, T2>(arg0, 0x2::coin::split<T2>(&mut v19, v2, arg19), v15);
            (0x2::coin::zero<T1>(arg19), v19)
        } else {
            let (v20, v21) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T1, T2>(arg0, v2, arg19);
            let (v22, v23, v24) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg0, v20, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg19), 0, arg18, arg19);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v24);
            let v25 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v23, arg17, arg18, arg19);
            0x2::coin::join<T1>(&mut v25, v22);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T1, T2>(arg0, 0x2::coin::split<T1>(&mut v25, v2, arg19), v21);
            (v25, 0x2::coin::zero<T2>(arg19))
        }
    }

    fun frac(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun fx_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg5: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg6: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::coin::value<T1>(&arg1));
        let v1 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T1, T0>(arg3, arg4, arg5, arg1, 18446744073709551615, 1000000, 18446744073709551615, v0, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg6, arg8);
        let v2 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T1, T0, T0>(&mut v1, arg6, arg8);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_y_to_x<T0, T1>(arg2, &mut v2, arg0, 0, arg7, arg8);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T1, T0, T1>(&mut v1, v2, arg6);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T1, T0>(arg3, arg5, v1, arg6, arg7, arg8)
    }

    fun fx_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::Store, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg5: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg6: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::coin::value<T0>(&arg1));
        let v1 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T0, T1>(arg3, arg4, arg5, arg1, 18446744073709551615, 1000000, 18446744073709551615, v0, 0x1::option::none<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>(), arg6, arg8);
        let v2 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T0, T1, T1>(&mut v1, arg6, arg8);
        0xc3bcd467604d19ab2e2e87079e0f7dadba5a71f7c84f2b749b671e3e147dc2e::swap_router::swap_exact_x_to_y<T0, T1>(arg2, &mut v2, arg0, 0, arg7, arg8);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T0, T1, T0>(&mut v1, v2, arg6);
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T0, T1>(arg3, arg5, v1, arg6, arg7, arg8)
    }

    fun h_quote_sui_to<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64) {
        if (arg1 == 0) {
            return (0, 0)
        };
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<0x2::sui::SUI, T0>(arg0, arg1, arg2);
        (v1, v0)
    }

    fun h_quote_to_sui<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<0x2::sui::SUI, T0>(arg0, arg1, arg2);
        v0
    }

    fun h_swap_to_sui<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return 0x2::coin::zero<0x2::sui::SUI>(arg4)
        };
        hop_buy_base<0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3, arg4)
    }

    fun hop_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::start<T1, T0>(arg1, 0);
        let v2 = v1;
        0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::end_returns<T0>(v2, 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::swap_b2a<T0, T1>(&v2, v0, arg0, arg3, arg2, arg4))
    }

    fun hop_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::start<T0, T1>(arg1, 0);
        let v2 = v1;
        0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::end_returns<T1>(v2, 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::swap_a2b<T0, T1>(&v2, v0, arg0, arg3, arg2, arg4))
    }

    fun keep_or_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    fun lim_of(arg0: u128, arg1: u64, arg2: bool) : u128 {
        let v0 = arg0 * (arg1 as u128) / 10000;
        if (arg2) {
            if (arg0 > v0 + 4295048016) {
                arg0 - v0
            } else {
                4295048016 + 1
            }
        } else {
            let v2 = arg0 + v0;
            if (v2 < 79226673515401279992447579055) {
                v2
            } else {
                79226673515401279992447579055 - 1
            }
        }
    }

    fun lot_down<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: u64) : u64 {
        let (_, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, T0>(arg0);
        if (v1 == 0) {
            arg1
        } else {
            arg1 - arg1 % v1
        }
    }

    fun s_buy_n<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T2>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = clamp_n(arg10);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg2, arg3, &mut arg9, 0x2::coin::value<T2>(&arg9), arg11, arg12);
        0x2::coin::destroy_zero<T2>(arg9);
        let v2 = 0x2::coin::zero<T3>(arg12);
        let v3 = 0x2::coin::value<T4>(&v1) / v0;
        let v4 = 1;
        while (v4 < v0) {
            if (v3 > 0) {
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg5, arg7, arg11), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg6, arg8, arg11), &mut v2, &mut v1, false, v3, 0, arg11, arg12);
            };
            v4 = v4 + 1;
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg5, arg7, arg11), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg6, arg8, arg11), &mut v2, &mut v1, false, 0x2::coin::value<T4>(&v1), 0, arg11, arg12);
        0x2::coin::destroy_zero<T4>(v1);
        0x2::coin::destroy_zero<T3>(v2);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T3>(arg1, arg3, &mut v2, 0x2::coin::value<T3>(&v2), arg11, arg12)
    }

    fun s_quote<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: &0x2::clock::Clock) : u64 {
        if (arg12 == 0 || arg12 < arg9) {
            return 0
        };
        let v0 = if (arg13) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg12, arg14)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg12, arg14)
        };
        if (v0 == 0 || !safe<T3, T4, T5>(arg0, v0, arg10, arg11, arg13)) {
            return 0
        };
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::quote_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg5, arg7, arg14), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg6, arg8, arg14), v0, arg13, arg14);
        if (arg13) {
            let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg14);
            if (v3 > 0x2::balance::value<T2>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::funds_available<T0, T2, T4>(arg2))) {
                0
            } else {
                v3
            }
        } else {
            let v4 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg14);
            if (v4 > 0x2::balance::value<T1>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::funds_available<T0, T1, T3>(arg1))) {
                0
            } else {
                v4
            }
        }
    }

    fun s_quote_n<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: &0x2::clock::Clock) : u64 {
        let v0 = clamp_n(arg14);
        if (v0 == 1) {
            return s_quote<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15)
        };
        if (arg12 < arg9) {
            return 0
        };
        let v1 = s_quote<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, arg10, arg11, arg12 / v0, arg13, arg15);
        if (v1 == 0) {
            return 0
        };
        let v2 = (((v1 as u128) * (v0 as u128)) as u64);
        let v3 = if (arg13) {
            0x2::balance::value<T2>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::funds_available<T0, T2, T4>(arg2))
        } else {
            0x2::balance::value<T1>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::funds_available<T0, T1, T3>(arg1))
        };
        if (v2 > v3) {
            return 0
        };
        v2 - v2 / 10000
    }

    fun s_sell_n<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = clamp_n(arg10);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg1, arg3, &mut arg9, 0x2::coin::value<T1>(&arg9), arg11, arg12);
        0x2::coin::destroy_zero<T1>(arg9);
        let v2 = 0x2::coin::zero<T4>(arg12);
        let v3 = 0x2::coin::value<T3>(&v1) / v0;
        let v4 = 1;
        while (v4 < v0) {
            if (v3 > 0) {
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg5, arg7, arg11), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg6, arg8, arg11), &mut v1, &mut v2, true, v3, 0, arg11, arg12);
            };
            v4 = v4 + 1;
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg5, arg7, arg11), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg6, arg8, arg11), &mut v1, &mut v2, true, 0x2::coin::value<T3>(&v1), 0, arg11, arg12);
        0x2::coin::destroy_zero<T3>(v1);
        0x2::coin::destroy_zero<T4>(v2);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T2, T4>(arg2, arg3, &mut v2, 0x2::coin::value<T4>(&v2), arg11, arg12)
    }

    fun safe<T0, T1, T2: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : bool {
        let (v0, v1) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T2>(arg0);
        let v2 = if (arg4) {
            v1
        } else {
            v0
        };
        let v3 = (v2 as u256);
        let v4 = (arg1 as u256) * (arg2 as u256) / 1000000000000;
        let v5 = (arg3 as u256);
        v4 * v4 >= v5 * v3 && v4 * v4 * 120000000000000 >= v5 * v3 * v3
    }

    fun sub0(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun sui_buy_bfsu_bf<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg21);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, T2>(arg1), arg18, true);
        let v1 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, 0x2::sui::SUI>(arg2), arg18, true);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg16)) {
            let v6 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v5));
            if (v6 > 0) {
                let v7 = bs_quote_pay_sui<T2>(arg1, v6, v0);
                if (v7 > 0) {
                    let v8 = sub0(b_quote_to_sui<T1>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v6, false, arg19, arg20), v1), v7);
                    if (v8 > v2) {
                        v3 = v8;
                        v4 = v6;
                    };
                };
            };
            v5 = v5 + 1;
        };
        if (v3 <= arg17) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg21)
        };
        let (v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T2>(arg20, arg0, arg1, true, false, v4, v0);
        let v12 = v11;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v13 = 0x2::coin::from_balance<T2>(v10, arg21);
        let v14 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v13, arg19, arg20, arg21);
        let v15 = b_swap_to_sui<T1>(arg0, arg2, v14, v1, arg20, arg21);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T2>(arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v15, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T2>(&v12), arg21)), 0x2::balance::zero<T2>(), v12);
        v15
    }

    public fun sui_buy_bfsu_cetus<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg22);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, T2>(arg1), arg19, true);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg17)) {
            let v5 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v4));
            if (v5 > 0) {
                let v6 = bs_quote_pay_sui<T2>(arg1, v5, v0);
                if (v6 > 0) {
                    let v7 = sub0(c_quote_to_sui<T1>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v5, false, arg20, arg21)), v6);
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg22)
        };
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T2>(arg21, arg0, arg1, true, false, v3, v0);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let v12 = 0x2::coin::from_balance<T2>(v9, arg22);
        let v13 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v12, arg20, arg21, arg22);
        let v14 = swap_all<T1>(arg2, arg3, v13, arg21);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T2>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v14, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T2>(&v11)), 0x2::balance::zero<T2>(), v11);
        0x2::coin::from_balance<0x2::sui::SUI>(v14, arg22)
    }

    public fun sui_buy_bfsu_cetus_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg7: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg8: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg9: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u64>, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg23);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, T2>(arg1), arg20, true);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg18)) {
            let v5 = frac(arg17, *0x1::vector::borrow<u64>(&arg18, v4));
            if (v5 > 0) {
                let v6 = bs_quote_pay_sui<T2>(arg1, v5, v0);
                if (v6 > 0) {
                    let v7 = sub0(c_quote_to_sui<T1>(arg4, s_quote_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v5, false, arg21, arg22)), v6);
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg19) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg23)
        };
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T2>(arg22, arg0, arg1, true, false, v3, v0);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let v12 = 0x2::coin::from_balance<T2>(v9, arg23);
        let v13 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v12, arg21, arg22, arg23);
        let v14 = swap_all_p<T1>(arg2, arg3, arg4, v13, arg22);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T2>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v14, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T2>(&v11)), 0x2::balance::zero<T2>(), v11);
        0x2::coin::from_balance<0x2::sui::SUI>(v14, arg23)
    }

    public fun sui_buy_bfsu_turbos<T0, T1, T2, T3, T4, T5: drop, T6>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, 0x2::sui::SUI, T6>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg23);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, T2>(arg1), arg19, true);
        let v1 = lim_of(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T1, 0x2::sui::SUI, T6>(arg2), arg20, true);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg17)) {
            let v6 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v5));
            if (v6 > 0) {
                let v7 = bs_quote_pay_sui<T2>(arg1, v6, v0);
                if (v7 > 0) {
                    let v8 = sub0(t_quote_in<T1, 0x2::sui::SUI, T6>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v6, false, arg21, arg22), v1), v7);
                    if (v8 > v2) {
                        v3 = v8;
                        v4 = v6;
                    };
                };
            };
            v5 = v5 + 1;
        };
        if (v3 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg23)
        };
        let (v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T2>(arg22, arg0, arg1, true, false, v4, v0);
        let v12 = v11;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v13 = 0x2::coin::from_balance<T2>(v10, arg23);
        let v14 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v13, arg21, arg22, arg23);
        let v15 = t_swap_a_to_sui<T1, T6>(arg2, v14, v1, arg3, arg22, arg23);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T2>(arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v15, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T2>(&v12), arg23)), 0x2::balance::zero<T2>(), v12);
        v15
    }

    public fun sui_buy_cetus_bf<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg22);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, 0x2::sui::SUI>(arg3), arg19, true);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg17)) {
            let v5 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v4));
            if (v5 > 0) {
                let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, 0x2::sui::SUI>(arg1, false, false, v5);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6)) {
                    let v7 = sub0(b_quote_to_sui<T1>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v5, false, arg20, arg21), v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v6) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg22)
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, 0x2::sui::SUI>(arg0, arg1, false, false, v3, 79226673515401279992447579055, arg21);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T2>(v8, arg22);
        let v13 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v12, arg20, arg21, arg22);
        let v14 = b_swap_to_sui<T1>(arg2, arg3, v13, v0, arg21, arg22);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v11), arg22)), v11);
        v14
    }

    public fun sui_buy_cetus_bf_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg7: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg8: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg9: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u64>, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg23);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, 0x2::sui::SUI>(arg4), arg20, true);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg18)) {
            let v5 = frac(arg17, *0x1::vector::borrow<u64>(&arg18, v4));
            if (v5 > 0) {
                let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, 0x2::sui::SUI>(arg2, false, false, v5);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6)) {
                    let v7 = sub0(b_quote_to_sui<T1>(arg4, s_quote_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v5, false, arg21, arg22), v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v6) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg19) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg23)
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T2, 0x2::sui::SUI>(arg0, arg2, arg1, false, false, v3, 79226673515401279992447579055, arg22);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T2>(v8, arg23);
        let v13 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v12, arg21, arg22, arg23);
        let v14 = b_swap_to_sui<T1>(arg3, arg4, v13, v0, arg22, arg23);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T2, 0x2::sui::SUI>(arg0, arg2, arg1, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v11), arg23)), v11);
        v14
    }

    public fun sui_buy_cetus_turbos<T0, T1, T2, T3, T4, T5: drop, T6>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, 0x2::sui::SUI, T6>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg22);
        let v0 = lim_of(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T1, 0x2::sui::SUI, T6>(arg2), arg19, true);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg17)) {
            let v5 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v4));
            if (v5 > 0) {
                let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, 0x2::sui::SUI>(arg1, false, false, v5);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6)) {
                    let v7 = sub0(t_quote_in<T1, 0x2::sui::SUI, T6>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v5, false, arg20, arg21), v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v6) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg22)
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, 0x2::sui::SUI>(arg0, arg1, false, false, v3, 79226673515401279992447579055, arg21);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T2>(v8, arg22);
        let v13 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v12, arg20, arg21, arg22);
        let v14 = t_swap_a_to_sui<T1, T6>(arg2, v13, v0, arg3, arg21, arg22);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v11), arg22)), v11);
        v14
    }

    public fun sui_buy_cetus_turbos_p<T0, T1, T2, T3, T4, T5: drop, T6>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, 0x2::sui::SUI, T6>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg7: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg8: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg9: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u64>, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg23);
        let v0 = lim_of(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T1, 0x2::sui::SUI, T6>(arg3), arg20, true);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg18)) {
            let v5 = frac(arg17, *0x1::vector::borrow<u64>(&arg18, v4));
            if (v5 > 0) {
                let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, 0x2::sui::SUI>(arg2, false, false, v5);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6)) {
                    let v7 = sub0(t_quote_in<T1, 0x2::sui::SUI, T6>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v5, false, arg21, arg22), v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v6) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg19) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg23)
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T2, 0x2::sui::SUI>(arg0, arg2, arg1, false, false, v3, 79226673515401279992447579055, arg22);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T2>(v8, arg23);
        let v13 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v12, arg21, arg22, arg23);
        let v14 = t_swap_a_to_sui<T1, T6>(arg3, v13, v0, arg4, arg22, arg23);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T2, 0x2::sui::SUI>(arg0, arg2, arg1, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v11), arg23)), v11);
        v14
    }

    public fun sui_buy_deep_bf<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg21);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, 0x2::sui::SUI>(arg2), arg18, true);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg16)) {
            let v5 = lot_down<T2>(arg0, frac(arg15, *0x1::vector::borrow<u64>(&arg16, v4)));
            if (v5 > 0) {
                let (v6, v7) = d_quote_sui_to<T2>(arg0, v5, arg20);
                let v8 = sub0(b_quote_to_sui<T1>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v6, false, arg19, arg20), v0) + v7, v5);
                if (v8 > v1) {
                    v2 = v8;
                    v3 = v5;
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg17) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg21)
        };
        let (v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T2>(arg0, v3, arg21);
        let (v11, v12, v13) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<0x2::sui::SUI, T2>(arg0, v9, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg21), 0, arg20, arg21);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v13);
        let v14 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v12, arg19, arg20, arg21);
        let v15 = b_swap_to_sui<T1>(arg1, arg2, v14, v0, arg20, arg21);
        0x2::coin::join<0x2::sui::SUI>(&mut v15, v11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T2>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v15, v3, arg21), v10);
        v15
    }

    public fun sui_buy_deep_bf_hop<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg1: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg22);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, 0x2::sui::SUI>(arg3), arg19, true);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg17)) {
            let v5 = lot_down<T2>(arg0, frac(arg16, *0x1::vector::borrow<u64>(&arg17, v4)));
            if (v5 > 0) {
                let (v6, _) = h_quote_sui_to<T2>(arg0, v5, arg21);
                let v8 = sub0(b_quote_to_sui<T1>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v6, false, arg20, arg21), v0), v5);
                if (v8 > v1) {
                    v2 = v8;
                    v3 = v5;
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg22)
        };
        let (v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T2>(arg0, v3, arg22);
        let v11 = hop_sell_base<0x2::sui::SUI, T2>(arg0, v9, arg1, arg21, arg22);
        let v12 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v11, arg20, arg21, arg22);
        let v13 = b_swap_to_sui<T1>(arg2, arg3, v12, v0, arg21, arg22);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T2>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v13, v3, arg22), v10);
        v13
    }

    public fun sui_buy_deep_cetus<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg20);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg16)) {
            let v4 = lot_down<T2>(arg0, frac(arg15, *0x1::vector::borrow<u64>(&arg16, v3)));
            if (v4 > 0) {
                let (v5, v6) = d_quote_sui_to<T2>(arg0, v4, arg19);
                let v7 = sub0(c_quote_to_sui<T1>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v5, false, arg18, arg19)) + v6, v4);
                if (v7 > v0) {
                    v1 = v7;
                    v2 = v4;
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg17) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg20)
        };
        let (v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T2>(arg0, v2, arg20);
        let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<0x2::sui::SUI, T2>(arg0, v8, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg20), 0, arg19, arg20);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v12);
        let v13 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v11, arg18, arg19, arg20);
        let v14 = 0x2::coin::from_balance<0x2::sui::SUI>(swap_all<T1>(arg1, arg2, v13, arg19), arg20);
        0x2::coin::join<0x2::sui::SUI>(&mut v14, v10);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T2>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v14, v2, arg20), v9);
        v14
    }

    public fun sui_buy_deep_cetus_hop<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg1: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg21);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg17)) {
            let v4 = lot_down<T2>(arg0, frac(arg16, *0x1::vector::borrow<u64>(&arg17, v3)));
            if (v4 > 0) {
                let (v5, _) = h_quote_sui_to<T2>(arg0, v4, arg20);
                let v7 = sub0(c_quote_to_sui<T1>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v5, false, arg19, arg20)), v4);
                if (v7 > v0) {
                    v1 = v7;
                    v2 = v4;
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg21)
        };
        let (v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T2>(arg0, v2, arg21);
        let v10 = hop_sell_base<0x2::sui::SUI, T2>(arg0, v8, arg1, arg20, arg21);
        let v11 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v10, arg19, arg20, arg21);
        let v12 = 0x2::coin::from_balance<0x2::sui::SUI>(swap_all<T1>(arg2, arg3, v11, arg20), arg21);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T2>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v12, v2, arg21), v9);
        v12
    }

    public fun sui_buy_deep_cetus_hop_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg1: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg7: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg8: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg9: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u64>, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg22);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg18)) {
            let v4 = lot_down<T2>(arg0, frac(arg17, *0x1::vector::borrow<u64>(&arg18, v3)));
            if (v4 > 0) {
                let (v5, _) = h_quote_sui_to<T2>(arg0, v4, arg21);
                let v7 = sub0(c_quote_to_sui<T1>(arg4, s_quote_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v5, false, arg20, arg21)), v4);
                if (v7 > v0) {
                    v1 = v7;
                    v2 = v4;
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg19) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg22)
        };
        let (v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T2>(arg0, v2, arg22);
        let v10 = hop_sell_base<0x2::sui::SUI, T2>(arg0, v8, arg1, arg21, arg22);
        let v11 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v10, arg20, arg21, arg22);
        let v12 = 0x2::coin::from_balance<0x2::sui::SUI>(swap_all_p<T1>(arg2, arg3, arg4, v11, arg21), arg22);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T2>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v12, v2, arg22), v9);
        v12
    }

    public fun sui_buy_deep_cetus_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg21);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg17)) {
            let v4 = lot_down<T2>(arg0, frac(arg16, *0x1::vector::borrow<u64>(&arg17, v3)));
            if (v4 > 0) {
                let (v5, v6) = d_quote_sui_to<T2>(arg0, v4, arg20);
                let v7 = sub0(c_quote_to_sui<T1>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v5, false, arg19, arg20)) + v6, v4);
                if (v7 > v0) {
                    v1 = v7;
                    v2 = v4;
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg21)
        };
        let (v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T2>(arg0, v2, arg21);
        let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<0x2::sui::SUI, T2>(arg0, v8, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg21), 0, arg20, arg21);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v12);
        let v13 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v11, arg19, arg20, arg21);
        let v14 = 0x2::coin::from_balance<0x2::sui::SUI>(swap_all_p<T1>(arg1, arg2, arg3, v13, arg20), arg21);
        0x2::coin::join<0x2::sui::SUI>(&mut v14, v10);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T2>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v14, v2, arg21), v9);
        v14
    }

    public fun sui_buy_deep_turbos<T0, T1, T2, T3, T4, T5: drop, T6>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, 0x2::sui::SUI, T6>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg21);
        let v0 = lim_of(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T1, 0x2::sui::SUI, T6>(arg1), arg18, true);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg16)) {
            let v5 = lot_down<T2>(arg0, frac(arg15, *0x1::vector::borrow<u64>(&arg16, v4)));
            if (v5 > 0) {
                let (v6, v7) = d_quote_sui_to<T2>(arg0, v5, arg20);
                let v8 = sub0(t_quote_in<T1, 0x2::sui::SUI, T6>(arg1, s_quote_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v6, false, arg19, arg20), v0) + v7, v5);
                if (v8 > v1) {
                    v2 = v8;
                    v3 = v5;
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg17) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg21)
        };
        let (v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T2>(arg0, v3, arg21);
        let (v11, v12, v13) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<0x2::sui::SUI, T2>(arg0, v9, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg21), 0, arg20, arg21);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v13);
        let v14 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v12, arg19, arg20, arg21);
        let v15 = t_swap_a_to_sui<T1, T6>(arg1, v14, v0, arg2, arg20, arg21);
        0x2::coin::join<0x2::sui::SUI>(&mut v15, v11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T2>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v15, v3, arg21), v10);
        v15
    }

    public fun sui_buy_deep_turbos_hop<T0, T1, T2, T3, T4, T5: drop, T6>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg1: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, 0x2::sui::SUI, T6>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg22);
        let v0 = lim_of(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T1, 0x2::sui::SUI, T6>(arg2), arg19, true);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg17)) {
            let v5 = lot_down<T2>(arg0, frac(arg16, *0x1::vector::borrow<u64>(&arg17, v4)));
            if (v5 > 0) {
                let (v6, _) = h_quote_sui_to<T2>(arg0, v5, arg21);
                let v8 = sub0(t_quote_in<T1, 0x2::sui::SUI, T6>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v6, false, arg20, arg21), v0), v5);
                if (v8 > v1) {
                    v2 = v8;
                    v3 = v5;
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg22)
        };
        let (v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T2>(arg0, v3, arg22);
        let v11 = hop_sell_base<0x2::sui::SUI, T2>(arg0, v9, arg1, arg21, arg22);
        let v12 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v11, arg20, arg21, arg22);
        let v13 = t_swap_a_to_sui<T1, T6>(arg2, v12, v0, arg3, arg21, arg22);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T2>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v13, v3, arg22), v10);
        v13
    }

    public fun sui_sell_bf_bfsu<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg21);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, 0x2::sui::SUI>(arg1), arg18, false);
        let v1 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, T2>(arg2), arg18, false);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg16)) {
            let v6 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v5));
            if (v6 > 0) {
                let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, 0x2::sui::SUI>(arg1, false, false, v6, v0);
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v7) == 0) {
                    let v8 = sub0(bs_quote_b_to_sui<T2>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v6, true, arg19, arg20), v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v7));
                    if (v8 > v2) {
                        v3 = v8;
                        v4 = v6;
                    };
                };
            };
            v5 = v5 + 1;
        };
        if (v3 <= arg17) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg21)
        };
        let (v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, 0x2::sui::SUI>(arg20, arg0, arg1, false, false, v4, v0);
        let v12 = v11;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
        let v13 = 0x2::coin::from_balance<T1>(v9, arg21);
        let v14 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v13, arg19, arg20, arg21);
        let v15 = bs_swap_b_to_sui<T2>(arg0, arg2, v14, v1, arg20, arg21);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v15, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v12), arg21)), v12);
        v15
    }

    public fun sui_sell_bf_cetus<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg22);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, 0x2::sui::SUI>(arg1), arg19, false);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg17)) {
            let v5 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v4));
            if (v5 > 0) {
                let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, 0x2::sui::SUI>(arg1, false, false, v5, v0);
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v6) == 0) {
                    let v7 = sub0(c_quote_to_sui<T2>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v5, true, arg20, arg21)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg22)
        };
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, 0x2::sui::SUI>(arg21, arg0, arg1, false, false, v3, v0);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg22);
        let v13 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v12, arg20, arg21, arg22);
        let v14 = swap_all<T2>(arg2, arg3, v13, arg21);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v14, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v11)), v11);
        0x2::coin::from_balance<0x2::sui::SUI>(v14, arg22)
    }

    public fun sui_sell_bf_cetus_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg7: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg8: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg9: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u64>, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg23);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, 0x2::sui::SUI>(arg1), arg20, false);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg18)) {
            let v5 = frac(arg17, *0x1::vector::borrow<u64>(&arg18, v4));
            if (v5 > 0) {
                let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, 0x2::sui::SUI>(arg1, false, false, v5, v0);
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v6) == 0) {
                    let v7 = sub0(c_quote_to_sui<T2>(arg4, s_quote_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v5, true, arg21, arg22)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg19) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg23)
        };
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, 0x2::sui::SUI>(arg22, arg0, arg1, false, false, v3, v0);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg23);
        let v13 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v12, arg21, arg22, arg23);
        let v14 = swap_all_p<T2>(arg2, arg3, arg4, v13, arg22);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v14, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v11)), v11);
        0x2::coin::from_balance<0x2::sui::SUI>(v14, arg23)
    }

    public fun sui_sell_bf_deep<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg21);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, 0x2::sui::SUI>(arg1), arg18, false);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg16)) {
            let v5 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v4));
            if (v5 > 0) {
                let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, 0x2::sui::SUI>(arg1, false, false, v5, v0);
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v6) == 0) {
                    let v7 = sub0(d_quote_to_sui<T2>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v5, true, arg19, arg20), arg20), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg17) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg21)
        };
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, 0x2::sui::SUI>(arg20, arg0, arg1, false, false, v3, v0);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg21);
        let v13 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v12, arg19, arg20, arg21);
        let v14 = d_swap_to_sui<T2>(arg2, v13, arg20, arg21);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v14, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v11), arg21)), v11);
        v14
    }

    public fun sui_sell_bf_deep_hop<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg3: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg22);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, 0x2::sui::SUI>(arg1), arg19, false);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg17)) {
            let v5 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v4));
            if (v5 > 0) {
                let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, 0x2::sui::SUI>(arg1, false, false, v5, v0);
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v6) == 0) {
                    let v7 = sub0(h_quote_to_sui<T2>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v5, true, arg20, arg21), arg21), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg22)
        };
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, 0x2::sui::SUI>(arg21, arg0, arg1, false, false, v3, v0);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg22);
        let v13 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v12, arg20, arg21, arg22);
        let v14 = h_swap_to_sui<T2>(arg2, v13, arg3, arg21, arg22);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v14, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v11), arg22)), v11);
        v14
    }

    public fun sui_sell_bf_turbos<T0, T1, T2, T3, T4, T5: drop, T6>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, T2, T6>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg23);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, 0x2::sui::SUI>(arg1), arg19, false);
        let v1 = lim_of(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, T2, T6>(arg2), arg20, false);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg17)) {
            let v6 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v5));
            if (v6 > 0) {
                let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, 0x2::sui::SUI>(arg1, false, false, v6, v0);
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v7) == 0) {
                    let v8 = sub0(t_quote_in<0x2::sui::SUI, T2, T6>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v6, true, arg21, arg22), v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v7));
                    if (v8 > v2) {
                        v3 = v8;
                        v4 = v6;
                    };
                };
            };
            v5 = v5 + 1;
        };
        if (v3 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg23)
        };
        let (v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, 0x2::sui::SUI>(arg22, arg0, arg1, false, false, v4, v0);
        let v12 = v11;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
        let v13 = 0x2::coin::from_balance<T1>(v9, arg23);
        let v14 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v13, arg21, arg22, arg23);
        let v15 = t_swap_b_to_sui<T2, T6>(arg2, v14, v1, arg3, arg22, arg23);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v15, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v12), arg23)), v12);
        v15
    }

    public fun sui_sell_cetus_bfsu<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg22);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, T2>(arg3), arg19, false);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg17)) {
            let v5 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v4));
            if (v5 > 0) {
                let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg1, false, false, v5);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6)) {
                    let v7 = sub0(bs_quote_b_to_sui<T2>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v5, true, arg20, arg21), v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v6) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg22)
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, false, false, v3, 79226673515401279992447579055, arg21);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg22);
        let v13 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v12, arg20, arg21, arg22);
        let v14 = bs_swap_b_to_sui<T2>(arg2, arg3, v13, v0, arg21, arg22);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v11), arg22)), v11);
        v14
    }

    public fun sui_sell_cetus_bfsu_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T2>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg7: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg8: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg9: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u64>, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg23);
        let v0 = lim_of(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, T2>(arg4), arg20, false);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg18)) {
            let v5 = frac(arg17, *0x1::vector::borrow<u64>(&arg18, v4));
            if (v5 > 0) {
                let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg2, false, false, v5);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6)) {
                    let v7 = sub0(bs_quote_b_to_sui<T2>(arg4, s_quote_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v5, true, arg21, arg22), v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v6) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg19) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg23)
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, 0x2::sui::SUI>(arg0, arg2, arg1, false, false, v3, 79226673515401279992447579055, arg22);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg23);
        let v13 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v12, arg21, arg22, arg23);
        let v14 = bs_swap_b_to_sui<T2>(arg3, arg4, v13, v0, arg22, arg23);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, 0x2::sui::SUI>(arg0, arg2, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v11), arg23)), v11);
        v14
    }

    public fun sui_sell_cetus_deep<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg20);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg16)) {
            let v4 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg1, false, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = sub0(d_quote_to_sui<T2>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v4, true, arg18, arg19), arg19), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                    if (v6 > v0) {
                        v1 = v6;
                        v2 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg17) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg20)
        };
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, false, false, v2, 79226673515401279992447579055, arg19);
        let v10 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg20);
        let v12 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v11, arg18, arg19, arg20);
        let v13 = d_swap_to_sui<T2>(arg2, v12, arg19, arg20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v10), arg20)), v10);
        v13
    }

    public fun sui_sell_cetus_deep_hop<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg3: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg21);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg17)) {
            let v4 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg1, false, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = sub0(h_quote_to_sui<T2>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v4, true, arg19, arg20), arg20), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                    if (v6 > v0) {
                        v1 = v6;
                        v2 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg21)
        };
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, false, false, v2, 79226673515401279992447579055, arg20);
        let v10 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg21);
        let v12 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v11, arg19, arg20, arg21);
        let v13 = h_swap_to_sui<T2>(arg2, v12, arg3, arg20, arg21);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v10), arg21)), v10);
        v13
    }

    public fun sui_sell_cetus_deep_hop_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg4: &mut 0x61c859dff13c38604fd8403b57042864f9810b6135b2a506f39ca6c12b570c3::deepbook::HopSponsoredTokens, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg7: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg8: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg9: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u64>, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg22);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg18)) {
            let v4 = frac(arg17, *0x1::vector::borrow<u64>(&arg18, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg2, false, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = sub0(h_quote_to_sui<T2>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v4, true, arg20, arg21), arg21), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                    if (v6 > v0) {
                        v1 = v6;
                        v2 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg19) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg22)
        };
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, 0x2::sui::SUI>(arg0, arg2, arg1, false, false, v2, 79226673515401279992447579055, arg21);
        let v10 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg22);
        let v12 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v11, arg20, arg21, arg22);
        let v13 = h_swap_to_sui<T2>(arg3, v12, arg4, arg21, arg22);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, 0x2::sui::SUI>(arg0, arg2, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v10), arg22)), v10);
        v13
    }

    public fun sui_sell_cetus_deep_p<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T2>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg21);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg17)) {
            let v4 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg2, false, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = sub0(d_quote_to_sui<T2>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v4, true, arg19, arg20), arg20), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                    if (v6 > v0) {
                        v1 = v6;
                        v2 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg21)
        };
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, 0x2::sui::SUI>(arg0, arg2, arg1, false, false, v2, 79226673515401279992447579055, arg20);
        let v10 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg21);
        let v12 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v11, arg19, arg20, arg21);
        let v13 = d_swap_to_sui<T2>(arg3, v12, arg20, arg21);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, 0x2::sui::SUI>(arg0, arg2, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v10), arg21)), v10);
        v13
    }

    public fun sui_sell_cetus_turbos<T0, T1, T2, T3, T4, T5: drop, T6>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, T2, T6>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg22);
        let v0 = lim_of(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, T2, T6>(arg2), arg19, false);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg17)) {
            let v5 = frac(arg16, *0x1::vector::borrow<u64>(&arg17, v4));
            if (v5 > 0) {
                let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg1, false, false, v5);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6)) {
                    let v7 = sub0(t_quote_in<0x2::sui::SUI, T2, T6>(arg2, s_quote_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v5, true, arg20, arg21), v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v6) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg18) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg22)
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, false, false, v3, 79226673515401279992447579055, arg21);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg22);
        let v13 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v12, arg20, arg21, arg22);
        let v14 = t_swap_b_to_sui<T2, T6>(arg2, v13, v0, arg3, arg21, arg22);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v11), arg22)), v11);
        v14
    }

    public fun sui_sell_cetus_turbos_p<T0, T1, T2, T3, T4, T5: drop, T6>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, T2, T6>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg7: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg8: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg9: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg10: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u64>, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg23);
        let v0 = lim_of(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, T2, T6>(arg3), arg20, false);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg18)) {
            let v5 = frac(arg17, *0x1::vector::borrow<u64>(&arg18, v4));
            if (v5 > 0) {
                let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg2, false, false, v5);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6)) {
                    let v7 = sub0(t_quote_in<0x2::sui::SUI, T2, T6>(arg3, s_quote_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v5, true, arg21, arg22), v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v6) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6));
                    if (v7 > v1) {
                        v2 = v7;
                        v3 = v5;
                    };
                };
            };
            v4 = v4 + 1;
        };
        if (v2 <= arg19) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg23)
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T1, 0x2::sui::SUI>(arg0, arg2, arg1, false, false, v3, 79226673515401279992447579055, arg22);
        let v11 = v10;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg23);
        let v13 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v12, arg21, arg22, arg23);
        let v14 = t_swap_b_to_sui<T2, T6>(arg3, v13, v0, arg4, arg22, arg23);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T1, 0x2::sui::SUI>(arg0, arg2, arg1, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v11), arg23)), v11);
        v14
    }

    fun swap_all<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, v0, 4295048016, arg3);
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        v2
    }

    fun swap_all_p<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg3);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, 0x2::sui::SUI>(arg0, arg2, arg1, true, true, v0, 4295048016, arg4);
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, 0x2::sui::SUI>(arg0, arg2, arg1, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        v2
    }

    fun t_quote_in<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: u128) : u64 {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0);
        if (v0 == 0 || arg1 == 0) {
            return 0
        };
        let (_, v2, v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap::compute_swap(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), arg2, v0, (arg1 as u128), true, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0));
        if (v2 + v4 < (arg1 as u128)) {
            return 0
        };
        (v3 as u64)
    }

    fun t_quote_out<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: u128) : u64 {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0);
        if (v0 == 0 || arg1 == 0) {
            return 0
        };
        let (_, v2, v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap::compute_swap(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), arg2, v0, (arg1 as u128), false, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0));
        if (v3 < (arg1 as u128)) {
            return 0
        };
        ((v2 + v4) as u64) + 1
    }

    fun t_swap_a_to_sui<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return 0x2::coin::zero<0x2::sui::SUI>(arg5)
        };
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, arg1);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, 0x2::sui::SUI, T1>(arg0, v1, v0, 0, arg2, true, 0x2::tx_context::sender(arg5), 18446744073709551615, arg4, arg3, arg5);
        keep_or_zero<T0>(v3, arg5);
        v2
    }

    fun t_swap_b_to_sui<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return 0x2::coin::zero<0x2::sui::SUI>(arg5)
        };
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, arg1);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<0x2::sui::SUI, T0, T1>(arg0, v1, v0, 0, arg2, true, 0x2::tx_context::sender(arg5), 18446744073709551615, arg4, arg3, arg5);
        keep_or_zero<T0>(v3, arg5);
        v2
    }

    public fun to_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg4);
        0x2::coin::from_balance<0x2::sui::SUI>(swap_all<T0>(arg0, arg1, arg2, arg3), arg4)
    }

    public fun to_sui_p<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg5);
        0x2::coin::from_balance<0x2::sui::SUI>(swap_all_p<T0>(arg0, arg1, arg2, arg3, arg4), arg5)
    }

    public fun turbos_direct_cycle_n<T0, T1, T2, T3, T4, T5: drop, T6>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T6>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        check(arg21);
        let v0 = !arg14;
        let v1 = lim_of(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T1, T2, T6>(arg0), arg18, v0);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg16)) {
            let v6 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v5));
            if (v6 > 0) {
                let v7 = t_quote_out<T1, T2, T6>(arg0, v6, v1);
                if (v7 > 0) {
                    let v8 = sub0(s_quote_n<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v6, arg14, arg19, arg20), v7);
                    if (v8 > v2) {
                        v3 = v8;
                        v4 = v6;
                    };
                };
            };
            v5 = v5 + 1;
        };
        if (v3 <= arg17) {
            return (0x2::coin::zero<T1>(arg21), 0x2::coin::zero<T2>(arg21))
        };
        let (v9, v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T1, T2, T6>(arg0, 0x2::tx_context::sender(arg21), v0, (v4 as u128), false, v1, arg20, arg1, arg21);
        let v12 = v11;
        let (_, _, v15) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T1, T2>(&v12);
        if (arg14) {
            0x2::coin::destroy_zero<T2>(v10);
            let v18 = s_sell_n<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v9, arg19, arg20, arg21);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T1, T2, T6>(arg0, 0x2::coin::zero<T1>(arg21), 0x2::coin::split<T2>(&mut v18, v15, arg21), v12, arg1);
            (0x2::coin::zero<T1>(arg21), v18)
        } else {
            0x2::coin::destroy_zero<T1>(v9);
            let v19 = s_buy_n<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v10, arg19, arg20, arg21);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T1, T2, T6>(arg0, 0x2::coin::split<T1>(&mut v19, v15, arg21), 0x2::coin::zero<T2>(arg21), v12, arg1);
            (v19, 0x2::coin::zero<T2>(arg21))
        }
    }

    // decompiled from Move bytecode v7
}

