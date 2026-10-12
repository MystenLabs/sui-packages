module 0xbb379ed11b699a0a94bd63535563a60af2232ff6facaa1382c69ef85c2e47f36::exec {
    public fun assert_min(arg0: &0x2::coin::Coin<0x2::sui::SUI>, arg1: u64) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= arg1, 1);
    }

    public fun cetus_direct_cycle<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        check(arg19);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg16)) {
            let v4 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, T1>(arg1, arg14, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = sub0(s_quote<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v4, arg14, arg18), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                    if (v6 > v0) {
                        v1 = v6;
                        v2 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg17) {
            return (0x2::coin::zero<T1>(arg19), 0x2::coin::zero<T2>(arg19))
        };
        if (arg14) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg1, true, false, v2, 4295048016, arg18);
            let v12 = v11;
            0x2::balance::destroy_zero<T2>(v9);
            let v13 = 0x2::coin::from_balance<T1>(v10, arg19);
            let v14 = s_sell<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v13, arg18, arg19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg1, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v12), arg19)), 0x2::balance::zero<T1>(), v12);
            (0x2::coin::zero<T1>(arg19), v14)
        } else {
            let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg1, false, false, v2, 79226673515401279992447579055, arg18);
            let v18 = v17;
            0x2::balance::destroy_zero<T1>(v16);
            let v19 = 0x2::coin::from_balance<T2>(v15, arg19);
            let v20 = s_buy<T0, T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v19, arg18, arg19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg1, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v20, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v18), arg19)), v18);
            (v20, 0x2::coin::zero<T2>(arg19))
        }
    }

    public fun cetus_sui_cycle_buy<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg19);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg16)) {
            let v4 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, 0x2::sui::SUI>(arg1, false, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = s_quote<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v4, false, arg18);
                    if (v6 > 0) {
                        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg2, true, true, v6);
                        if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v7)) {
                            let v8 = sub0(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v7), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                            if (v8 > v0) {
                                v1 = v8;
                                v2 = v4;
                            };
                        };
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg17) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg19)
        };
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, 0x2::sui::SUI>(arg0, arg1, false, false, v2, 79226673515401279992447579055, arg18);
        let v12 = v11;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
        let v13 = 0x2::coin::from_balance<T2>(v9, arg19);
        let v14 = s_buy<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v13, arg18, arg19);
        let v15 = swap_all<T1>(arg0, arg2, v14, arg18);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T2>(), 0x2::balance::split<0x2::sui::SUI>(&mut v15, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v12)), v12);
        0x2::coin::from_balance<0x2::sui::SUI>(v15, arg19)
    }

    public fun cetus_sui_cycle_sell<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u64>, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg19);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg16)) {
            let v4 = frac(arg15, *0x1::vector::borrow<u64>(&arg16, v3));
            if (v4 > 0) {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg1, false, false, v4);
                if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    let v6 = s_quote<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v4, true, arg18);
                    if (v6 > 0) {
                        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T2, 0x2::sui::SUI>(arg2, true, true, v6);
                        if (!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v7)) {
                            let v8 = sub0(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v7), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v5) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v5));
                            if (v8 > v0) {
                                v1 = v8;
                                v2 = v4;
                            };
                        };
                    };
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg17) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg19)
        };
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, false, false, v2, 79226673515401279992447579055, arg18);
        let v12 = v11;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
        let v13 = 0x2::coin::from_balance<T1>(v9, arg19);
        let v14 = s_sell<T0, T1, T2, T3, T4, T5>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v13, arg18, arg19);
        let v15 = swap_all<T2>(arg0, arg2, v14, arg18);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v15, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v12)), v12);
        0x2::coin::from_balance<0x2::sui::SUI>(v15, arg19)
    }

    fun check(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xfda31f3b2ef24019a5554a64ad326128b6c08bd6e9835f6f143ad02a80b92f2e, 0);
    }

    public fun deep_cycle<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: vector<u64>, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        check(arg18);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg15)) {
            let v4 = frac(arg14, *0x1::vector::borrow<u64>(&arg15, v3));
            if (v4 > 0) {
                let v5 = if (arg13) {
                    let (v6, v7, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T1, T2>(arg0, v4, arg17);
                    sub0(s_quote<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v6, true, arg17) + v7, v4)
                } else {
                    let (v9, v10, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T1, T2>(arg0, v4, arg17);
                    sub0(s_quote<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v10, false, arg17) + v9, v4)
                };
                if (v5 > v0) {
                    v1 = v5;
                    v2 = v4;
                };
            };
            v3 = v3 + 1;
        };
        if (v1 <= arg16) {
            return (0x2::coin::zero<T1>(arg18), 0x2::coin::zero<T2>(arg18))
        };
        if (arg13) {
            let (v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T1, T2>(arg0, v2, arg18);
            let (v16, v17, v18) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg0, v14, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg18), 0, arg17, arg18);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v18);
            let v19 = s_sell<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v16, arg17, arg18);
            0x2::coin::join<T2>(&mut v19, v17);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T1, T2>(arg0, 0x2::coin::split<T2>(&mut v19, v2, arg18), v15);
            (0x2::coin::zero<T1>(arg18), v19)
        } else {
            let (v20, v21) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T1, T2>(arg0, v2, arg18);
            let (v22, v23, v24) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg0, v20, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg18), 0, arg17, arg18);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v24);
            let v25 = s_buy<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v23, arg17, arg18);
            0x2::coin::join<T1>(&mut v25, v22);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T1, T2>(arg0, 0x2::coin::split<T1>(&mut v25, v2, arg18), v21);
            (v25, 0x2::coin::zero<T2>(arg18))
        }
    }

    fun frac(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun s_buy<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg2, arg3, &mut arg9, 0x2::coin::value<T2>(&arg9), arg10, arg11);
        0x2::coin::destroy_zero<T2>(arg9);
        let v1 = 0x2::coin::zero<T3>(arg11);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg5, arg7, arg10), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg6, arg8, arg10), &mut v1, &mut v0, false, 0x2::coin::value<T4>(&v0), 0, arg10, arg11);
        0x2::coin::destroy_zero<T4>(v0);
        0x2::coin::destroy_zero<T3>(v1);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T3>(arg1, arg3, &mut v1, 0x2::coin::value<T3>(&v1), arg10, arg11)
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
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg14)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg14)
        }
    }

    fun s_sell<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg1, arg3, &mut arg9, 0x2::coin::value<T1>(&arg9), arg10, arg11);
        0x2::coin::destroy_zero<T1>(arg9);
        let v1 = 0x2::coin::zero<T4>(arg11);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg5, arg7, arg10), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg6, arg8, arg10), &mut v0, &mut v1, true, 0x2::coin::value<T3>(&v0), 0, arg10, arg11);
        0x2::coin::destroy_zero<T3>(v0);
        0x2::coin::destroy_zero<T4>(v1);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T2, T4>(arg2, arg3, &mut v1, 0x2::coin::value<T4>(&v1), arg10, arg11)
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

    public fun to_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check(arg4);
        0x2::coin::from_balance<0x2::sui::SUI>(swap_all<T0>(arg0, arg1, arg2, arg3), arg4)
    }

    // decompiled from Move bytecode v7
}

