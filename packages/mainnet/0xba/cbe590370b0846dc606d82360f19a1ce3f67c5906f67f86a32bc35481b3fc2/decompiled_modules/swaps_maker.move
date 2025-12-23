module 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_maker {
    public(friend) fun close_all_positions(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::OpenPoolPositions, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_low_fee_pool_id();
        let v0 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(0);
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::close_pool_position(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_high_fee_pool_id();
        let v1 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(1);
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::close_pool_position(&v1, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::mmt_pool_id();
        let v2 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::new_integration();
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::close_pool_position(&v2, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public(friend) fun set_correct_liquidity(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::OpenPoolPositions, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg12: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swaps_maker_enabled(arg0)) {
            return
        };
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_low_fee_pool_id();
        let v0 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(0);
        let v1 = &v0;
        let v2 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_price(v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v3 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_maker_threshold_bps_times_1k(arg0) * arg13 / 10000 / 1000;
        let v4 = v3;
        if (arg14 > 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_min_volatility_for_multiple_times_1k(arg0)) {
            v4 = v3 * (10000 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_volatility_multiplier_factor_times_10(arg0) * (arg14 - 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_min_volatility_for_multiple_times_1k(arg0))) / 10000;
        };
        let v5 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::abs_diff(v2, arg13) + v4 <= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_received_rebates_per_value(v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v2);
        if (arg14 >= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_max_volatility_for_multiple_times_1k(arg0)) {
            v5 = false;
        };
        if (!v5) {
            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::close_pool_position(v1, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
        } else {
            let v6 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_parameters(v1, arg0);
            if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_enabled(v6)) {
            } else {
                let v7 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_tick_spacing(v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
                let v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_tick_index(v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12), v7);
                let v9 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v8, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1)), v7);
                let v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v8, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1)), v7);
                let v11 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_position_info(v1, arg1);
                if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::position_info_lower_tick_index(&v11) == v9 && 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::position_info_upper_tick_index(&v11) == v10) {
                } else {
                    0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::close_pool_position(v1, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
                    let v12 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg2);
                    let v13 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg2);
                    let v14 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_maximum_usdc_liquidity(arg0);
                    let v15 = if (v12 < v14) {
                        v12
                    } else {
                        v14
                    };
                    let v16 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_maximum_sui_liquidity(arg0);
                    let v17 = if (v13 < v16) {
                        v13
                    } else {
                        v16
                    };
                    let v18 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_quantity_multiplier_times_1k(v6);
                    let v19 = v15 * v18 / 1000;
                    let v20 = v17 * v18 / 1000;
                    if (v19 < 1 * 1000000 || v20 < 1 * 1000000000) {
                    } else {
                        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::open_pool_position(v1, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v9, v10, v19, v20, arg15, arg16);
                    };
                };
            };
        };
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_high_fee_pool_id();
        let v21 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(1);
        let v22 = &v21;
        let v23 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_price(v22, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v24 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_maker_threshold_bps_times_1k(arg0) * arg13 / 10000 / 1000;
        let v25 = v24;
        if (arg14 > 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_min_volatility_for_multiple_times_1k(arg0)) {
            v25 = v24 * (10000 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_volatility_multiplier_factor_times_10(arg0) * (arg14 - 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_min_volatility_for_multiple_times_1k(arg0))) / 10000;
        };
        let v26 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::abs_diff(v23, arg13) + v25 <= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_received_rebates_per_value(v22, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v23);
        if (arg14 >= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_max_volatility_for_multiple_times_1k(arg0)) {
            v26 = false;
        };
        if (!v26) {
            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::close_pool_position(v22, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
        } else {
            let v27 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_parameters(v22, arg0);
            if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_enabled(v27)) {
            } else {
                let v28 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_tick_spacing(v22, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
                let v29 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_tick_index(v22, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12), v28);
                let v30 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v29, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1)), v28);
                let v31 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v29, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1)), v28);
                let v32 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_position_info(v22, arg1);
                if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::position_info_lower_tick_index(&v32) == v30 && 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::position_info_upper_tick_index(&v32) == v31) {
                } else {
                    0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::close_pool_position(v22, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
                    let v33 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg2);
                    let v34 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg2);
                    let v35 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_maximum_usdc_liquidity(arg0);
                    let v36 = if (v33 < v35) {
                        v33
                    } else {
                        v35
                    };
                    let v37 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_maximum_sui_liquidity(arg0);
                    let v38 = if (v34 < v37) {
                        v34
                    } else {
                        v37
                    };
                    let v39 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_quantity_multiplier_times_1k(v27);
                    let v40 = v36 * v39 / 1000;
                    let v41 = v38 * v39 / 1000;
                    if (v40 < 1 * 1000000 || v41 < 1 * 1000000000) {
                    } else {
                        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::open_pool_position(v22, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v30, v31, v40, v41, arg15, arg16);
                    };
                };
            };
        };
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::mmt_pool_id();
        let v42 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::new_integration();
        let v43 = &v42;
        let v44 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_current_price(v43, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v45 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_maker_threshold_bps_times_1k(arg0) * arg13 / 10000 / 1000;
        let v46 = v45;
        if (arg14 > 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_min_volatility_for_multiple_times_1k(arg0)) {
            v46 = v45 * (10000 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_volatility_multiplier_factor_times_10(arg0) * (arg14 - 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_min_volatility_for_multiple_times_1k(arg0))) / 10000;
        };
        let v47 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::abs_diff(v44, arg13) + v46 <= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_received_rebates_per_value(v43, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v44);
        if (arg14 >= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_max_volatility_for_multiple_times_1k(arg0)) {
            v47 = false;
        };
        if (!v47) {
            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::close_pool_position(v43, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
        } else {
            let v48 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_parameters(v43, arg0);
            if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_enabled(v48)) {
            } else {
                let v49 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_tick_spacing(v43, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
                let v50 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_current_tick_index(v43, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12), v49);
                let v51 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v50, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1)), v49);
                let v52 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v50, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1)), v49);
                let v53 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_current_position_info(v43, arg1);
                if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::position_info_lower_tick_index(&v53) == v51 && 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::position_info_upper_tick_index(&v53) == v52) {
                } else {
                    0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::close_pool_position(v43, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
                    let v54 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg2);
                    let v55 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg2);
                    let v56 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_maximum_usdc_liquidity(arg0);
                    let v57 = if (v54 < v56) {
                        v54
                    } else {
                        v56
                    };
                    let v58 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_maximum_sui_liquidity(arg0);
                    let v59 = if (v55 < v58) {
                        v55
                    } else {
                        v58
                    };
                    let v60 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_quantity_multiplier_times_1k(v48);
                    let v61 = v57 * v60 / 1000;
                    let v62 = v59 * v60 / 1000;
                    if (v61 < 1 * 1000000 || v62 < 1 * 1000000000) {
                    } else {
                        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::open_pool_position(v43, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v51, v52, v61, v62, arg15, arg16);
                    };
                };
            };
        };
    }

    public(friend) fun try_remove_liquidity_to_make_balance_available(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::OpenPoolPositions, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg12: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_low_fee_pool_id();
        let v0 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(0);
        if (arg13 <= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg1) && arg14 <= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg1)) {
        } else {
            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::close_pool_position(&v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
        };
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_high_fee_pool_id();
        let v1 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(1);
        if (arg13 <= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg1) && arg14 <= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg1)) {
        } else {
            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::close_pool_position(&v1, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
        };
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::mmt_pool_id();
        let v2 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::new_integration();
        if (arg13 <= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg1) && arg14 <= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg1)) {
        } else {
            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::close_pool_position(&v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
        };
    }

    // decompiled from Move bytecode v6
}

