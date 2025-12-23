module 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_taker {
    struct SwapAttempt has copy, drop {
        is_buy: bool,
        pool: 0x1::string::String,
        price_limit: u64,
        sqrt_price_limit: u128,
        pool_sqrt_price: u128,
        not_enough_balance: bool,
        made_swap: bool,
    }

    struct SwapMade has copy, drop {
        amount_sui: u64,
        amount_usdc: u64,
        is_buy: bool,
        pool: 0x1::string::String,
        timestamp: u64,
        balance_manager_id: 0x2::object::ID,
    }

    struct PoolPricePair has copy, drop {
        price: u64,
        pool_id: u64,
    }

    struct SwapResults has copy, drop {
        buy_prices: vector<PoolPricePair>,
        sell_prices: vector<PoolPricePair>,
        attempts: vector<SwapAttempt>,
        timestamp: u64,
    }

    public(friend) fun get_target_quantity(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::OrderManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: bool) : u64 {
        if (arg5 && arg3 >= arg4) {
            return 0
        };
        if (!arg5 && arg3 <= arg4) {
            return 0
        };
        let v0 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::abs_diff(arg3, arg4) * 1000 / arg4 / 10000;
        if (v0 < 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0)) {
            return 0
        };
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::skew_quantity_based_on_position(arg1, arg0, arg2, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_minimum_start_quantity(arg0) + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_step_start_quantity(arg0) * (v0 - 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0)) / 1000, arg5)
    }

    fun run_taker_buys(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::OpenPoolPositions, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg11: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg12: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg15: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg16: u64, arg17: &vector<PoolPricePair>, arg18: u64, arg19: &mut SwapResults, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PoolPricePair>(arg17)) {
            let v1 = 0x1::vector::borrow<PoolPricePair>(arg17, v0);
            if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::allowed_to_buy(arg0) && v1.price + arg18 <= arg16) {
                let v2 = v1.pool_id;
                if (v2 == 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_low_fee_pool_id()) {
                    let v3 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(0);
                    let v4 = &v3;
                    let v5 = SwapAttempt{
                        is_buy             : true,
                        pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_name(v4),
                        price_limit        : 0,
                        sqrt_price_limit   : 0,
                        pool_sqrt_price    : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_sqrt_price(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        not_enough_balance : false,
                        made_swap          : false,
                    };
                    let v5 = if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::taker_enabled(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_parameters(v4, arg0))) {
                        v5
                    } else {
                        let v6 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_sqrt_price(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v7 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0) * arg16 / 10000 / 1000;
                        let v8 = arg16 - v7 - arg16 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_fee_rate(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v5.price_limit = v8;
                        let v9 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::increase_sqrt_price(v4, v6, v8);
                        v5.sqrt_price_limit = v9;
                        if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::sui_is_coin_a(v4) && v6 >= v9 || !0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::sui_is_coin_a(v4) && v6 <= v9) {
                            v5
                        } else {
                            let (v10, _) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::estimate_buy_sell_price(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v12 = get_target_quantity(arg0, arg1, arg2, v10, arg16, true);
                            let v13 = v12;
                            let v14 = arg16 - v7;
                            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v12, v14), arg20, arg21);
                            let v15 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_base_at_price(arg0, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg2), v14);
                            if (v12 > v15) {
                                v13 = v15;
                            };
                            if (v13 < 1 * 1000000000) {
                                v5.not_enough_balance = true;
                                v5
                            } else {
                                let (v16, v17) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::swap_buy(v4, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v13, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v13, v14), v9, arg20, arg21);
                                let v18 = SwapMade{
                                    amount_sui         : v16,
                                    amount_usdc        : v17,
                                    is_buy             : true,
                                    pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_name(v4),
                                    timestamp          : 0x2::clock::timestamp_ms(arg20),
                                    balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<SwapMade>(v18);
                                v5.made_swap = true;
                                v5
                            }
                        }
                    };
                    0x1::vector::push_back<SwapAttempt>(&mut arg19.attempts, v5);
                } else if (v2 == 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_high_fee_pool_id()) {
                    let v19 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(1);
                    let v20 = &v19;
                    let v21 = SwapAttempt{
                        is_buy             : true,
                        pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_name(v20),
                        price_limit        : 0,
                        sqrt_price_limit   : 0,
                        pool_sqrt_price    : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_sqrt_price(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        not_enough_balance : false,
                        made_swap          : false,
                    };
                    let v21 = if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::taker_enabled(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_parameters(v20, arg0))) {
                        v21
                    } else {
                        let v22 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_sqrt_price(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v23 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0) * arg16 / 10000 / 1000;
                        let v24 = arg16 - v23 - arg16 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_fee_rate(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v21.price_limit = v24;
                        let v25 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::increase_sqrt_price(v20, v22, v24);
                        v21.sqrt_price_limit = v25;
                        if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::sui_is_coin_a(v20) && v22 >= v25 || !0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::sui_is_coin_a(v20) && v22 <= v25) {
                            v21
                        } else {
                            let (v26, _) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::estimate_buy_sell_price(v20, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v28 = get_target_quantity(arg0, arg1, arg2, v26, arg16, true);
                            let v29 = v28;
                            let v30 = arg16 - v23;
                            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v28, v30), arg20, arg21);
                            let v31 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_base_at_price(arg0, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg2), v30);
                            if (v28 > v31) {
                                v29 = v31;
                            };
                            if (v29 < 1 * 1000000000) {
                                v21.not_enough_balance = true;
                                v21
                            } else {
                                let (v32, v33) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::swap_buy(v20, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v29, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v29, v30), v25, arg20, arg21);
                                let v34 = SwapMade{
                                    amount_sui         : v32,
                                    amount_usdc        : v33,
                                    is_buy             : true,
                                    pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_name(v20),
                                    timestamp          : 0x2::clock::timestamp_ms(arg20),
                                    balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<SwapMade>(v34);
                                v21.made_swap = true;
                                v21
                            }
                        }
                    };
                    0x1::vector::push_back<SwapAttempt>(&mut arg19.attempts, v21);
                } else if (v2 == 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::mmt_pool_id()) {
                    let v35 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::new_integration();
                    let v36 = &v35;
                    let v37 = SwapAttempt{
                        is_buy             : true,
                        pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_name(v36),
                        price_limit        : 0,
                        sqrt_price_limit   : 0,
                        pool_sqrt_price    : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_current_sqrt_price(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        not_enough_balance : false,
                        made_swap          : false,
                    };
                    let v37 = if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::taker_enabled(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_parameters(v36, arg0))) {
                        v37
                    } else {
                        let v38 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_current_sqrt_price(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v39 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0) * arg16 / 10000 / 1000;
                        let v40 = arg16 - v39 - arg16 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_fee_rate(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v37.price_limit = v40;
                        let v41 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::increase_sqrt_price(v36, v38, v40);
                        v37.sqrt_price_limit = v41;
                        if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::sui_is_coin_a(v36) && v38 >= v41 || !0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::sui_is_coin_a(v36) && v38 <= v41) {
                            v37
                        } else {
                            let (v42, _) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::estimate_buy_sell_price(v36, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v44 = get_target_quantity(arg0, arg1, arg2, v42, arg16, true);
                            let v45 = v44;
                            let v46 = arg16 - v39;
                            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v44, v46), arg20, arg21);
                            let v47 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_base_at_price(arg0, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg2), v46);
                            if (v44 > v47) {
                                v45 = v47;
                            };
                            if (v45 < 1 * 1000000000) {
                                v37.not_enough_balance = true;
                                v37
                            } else {
                                let (v48, v49) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::swap_buy(v36, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v45, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v45, v46), v41, arg20, arg21);
                                let v50 = SwapMade{
                                    amount_sui         : v48,
                                    amount_usdc        : v49,
                                    is_buy             : true,
                                    pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_name(v36),
                                    timestamp          : 0x2::clock::timestamp_ms(arg20),
                                    balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<SwapMade>(v50);
                                v37.made_swap = true;
                                v37
                            }
                        }
                    };
                    0x1::vector::push_back<SwapAttempt>(&mut arg19.attempts, v37);
                } else if (v2 == 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::turbos_pool_id()) {
                    let v51 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::new_integration();
                    let v52 = &v51;
                    let v53 = SwapAttempt{
                        is_buy             : true,
                        pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_name(v52),
                        price_limit        : 0,
                        sqrt_price_limit   : 0,
                        pool_sqrt_price    : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_current_sqrt_price(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        not_enough_balance : false,
                        made_swap          : false,
                    };
                    let v53 = if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::taker_enabled(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_parameters(v52, arg0))) {
                        v53
                    } else {
                        let v54 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_current_sqrt_price(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v55 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0) * arg16 / 10000 / 1000;
                        let v56 = arg16 - v55 - arg16 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_fee_rate(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v53.price_limit = v56;
                        let v57 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::increase_sqrt_price(v52, v54, v56);
                        v53.sqrt_price_limit = v57;
                        if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::sui_is_coin_a(v52) && v54 >= v57 || !0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::sui_is_coin_a(v52) && v54 <= v57) {
                            v53
                        } else {
                            let (v58, _) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::estimate_buy_sell_price(v52, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v60 = get_target_quantity(arg0, arg1, arg2, v58, arg16, true);
                            let v61 = v60;
                            let v62 = arg16 - v55;
                            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v60, v62), arg20, arg21);
                            let v63 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_base_at_price(arg0, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg2), v62);
                            if (v60 > v63) {
                                v61 = v63;
                            };
                            if (v61 < 1 * 1000000000) {
                                v53.not_enough_balance = true;
                                v53
                            } else {
                                let (v64, v65) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::swap_buy(v52, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v61, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v61, v62), v57, arg20, arg21);
                                let v66 = SwapMade{
                                    amount_sui         : v64,
                                    amount_usdc        : v65,
                                    is_buy             : true,
                                    pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_name(v52),
                                    timestamp          : 0x2::clock::timestamp_ms(arg20),
                                    balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<SwapMade>(v66);
                                v53.made_swap = true;
                                v53
                            }
                        }
                    };
                    0x1::vector::push_back<SwapAttempt>(&mut arg19.attempts, v53);
                } else if (v2 == 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::bluefin_pool_id()) {
                    let v67 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::new_integration();
                    let v68 = &v67;
                    let v69 = SwapAttempt{
                        is_buy             : true,
                        pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_name(v68),
                        price_limit        : 0,
                        sqrt_price_limit   : 0,
                        pool_sqrt_price    : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_current_sqrt_price(v68, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        not_enough_balance : false,
                        made_swap          : false,
                    };
                    let v69 = if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::taker_enabled(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_parameters(v68, arg0))) {
                        v69
                    } else {
                        let v70 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_current_sqrt_price(v68, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v71 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0) * arg16 / 10000 / 1000;
                        let v72 = arg16 - v71 - arg16 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_fee_rate(v68, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v69.price_limit = v72;
                        let v73 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::increase_sqrt_price(v68, v70, v72);
                        v69.sqrt_price_limit = v73;
                        if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::sui_is_coin_a(v68) && v70 >= v73 || !0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::sui_is_coin_a(v68) && v70 <= v73) {
                            v69
                        } else {
                            let (v74, _) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::estimate_buy_sell_price(v68, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v76 = get_target_quantity(arg0, arg1, arg2, v74, arg16, true);
                            let v77 = v76;
                            let v78 = arg16 - v71;
                            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v76, v78), arg20, arg21);
                            let v79 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_base_at_price(arg0, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg2), v78);
                            if (v76 > v79) {
                                v77 = v79;
                            };
                            if (v77 < 1 * 1000000000) {
                                v69.not_enough_balance = true;
                                v69
                            } else {
                                let (v80, v81) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::swap_buy(v68, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v77, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg0, v77, v78), v73, arg20, arg21);
                                let v82 = SwapMade{
                                    amount_sui         : v80,
                                    amount_usdc        : v81,
                                    is_buy             : true,
                                    pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_name(v68),
                                    timestamp          : 0x2::clock::timestamp_ms(arg20),
                                    balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<SwapMade>(v82);
                                v69.made_swap = true;
                                v69
                            }
                        }
                    };
                    0x1::vector::push_back<SwapAttempt>(&mut arg19.attempts, v69);
                };
            };
            v0 = v0 + 1;
        };
    }

    fun run_taker_sells(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::OpenPoolPositions, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg11: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg12: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg15: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg16: u64, arg17: &vector<PoolPricePair>, arg18: u64, arg19: &mut SwapResults, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PoolPricePair>(arg17)) {
            let v1 = 0x1::vector::borrow<PoolPricePair>(arg17, v0);
            if (v1.price >= arg16 + arg18) {
                let v2 = v1.pool_id;
                if (v2 == 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_low_fee_pool_id()) {
                    let v3 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(0);
                    let v4 = &v3;
                    let v5 = SwapAttempt{
                        is_buy             : false,
                        pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_name(v4),
                        price_limit        : 0,
                        sqrt_price_limit   : 0,
                        pool_sqrt_price    : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_sqrt_price(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        not_enough_balance : false,
                        made_swap          : false,
                    };
                    let v5 = if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::taker_enabled(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_parameters(v4, arg0))) {
                        v5
                    } else {
                        let v6 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_sqrt_price(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v7 = arg16 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0) * arg16 / 10000 / 1000 + arg16 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_fee_rate(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v5.price_limit = v7;
                        let v8 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::decrease_sqrt_price(v4, v6, v7);
                        v5.sqrt_price_limit = v8;
                        if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::sui_is_coin_a(v4) && v6 <= v8 || !0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::sui_is_coin_a(v4) && v6 >= v8) {
                            v5
                        } else {
                            let (_, v10) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::estimate_buy_sell_price(v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v11 = get_target_quantity(arg0, arg1, arg2, v10, arg16, false);
                            let v12 = v11;
                            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v11, arg20, arg21);
                            let v13 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg2);
                            if (v11 > v13) {
                                v12 = v13;
                            };
                            if (v12 < 1 * 1000000000) {
                                v5.not_enough_balance = true;
                                v5
                            } else {
                                let (v14, v15) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::swap_sell(v4, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v12, v8, arg20, arg21);
                                let v16 = SwapMade{
                                    amount_sui         : v14,
                                    amount_usdc        : v15,
                                    is_buy             : false,
                                    pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_name(v4),
                                    timestamp          : 0x2::clock::timestamp_ms(arg20),
                                    balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<SwapMade>(v16);
                                v5.made_swap = true;
                                v5
                            }
                        }
                    };
                    0x1::vector::push_back<SwapAttempt>(&mut arg19.attempts, v5);
                } else if (v2 == 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_high_fee_pool_id()) {
                    let v17 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(1);
                    let v18 = &v17;
                    let v19 = SwapAttempt{
                        is_buy             : false,
                        pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_name(v18),
                        price_limit        : 0,
                        sqrt_price_limit   : 0,
                        pool_sqrt_price    : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_sqrt_price(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        not_enough_balance : false,
                        made_swap          : false,
                    };
                    let v19 = if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::taker_enabled(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_parameters(v18, arg0))) {
                        v19
                    } else {
                        let v20 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_current_sqrt_price(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v21 = arg16 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0) * arg16 / 10000 / 1000 + arg16 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_fee_rate(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v19.price_limit = v21;
                        let v22 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::decrease_sqrt_price(v18, v20, v21);
                        v19.sqrt_price_limit = v22;
                        if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::sui_is_coin_a(v18) && v20 <= v22 || !0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::sui_is_coin_a(v18) && v20 >= v22) {
                            v19
                        } else {
                            let (_, v24) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::estimate_buy_sell_price(v18, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v25 = get_target_quantity(arg0, arg1, arg2, v24, arg16, false);
                            let v26 = v25;
                            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v25, arg20, arg21);
                            let v27 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg2);
                            if (v25 > v27) {
                                v26 = v27;
                            };
                            if (v26 < 1 * 1000000000) {
                                v19.not_enough_balance = true;
                                v19
                            } else {
                                let (v28, v29) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::swap_sell(v18, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v26, v22, arg20, arg21);
                                let v30 = SwapMade{
                                    amount_sui         : v28,
                                    amount_usdc        : v29,
                                    is_buy             : false,
                                    pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::get_name(v18),
                                    timestamp          : 0x2::clock::timestamp_ms(arg20),
                                    balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<SwapMade>(v30);
                                v19.made_swap = true;
                                v19
                            }
                        }
                    };
                    0x1::vector::push_back<SwapAttempt>(&mut arg19.attempts, v19);
                } else if (v2 == 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::mmt_pool_id()) {
                    let v31 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::new_integration();
                    let v32 = &v31;
                    let v33 = SwapAttempt{
                        is_buy             : false,
                        pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_name(v32),
                        price_limit        : 0,
                        sqrt_price_limit   : 0,
                        pool_sqrt_price    : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_current_sqrt_price(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        not_enough_balance : false,
                        made_swap          : false,
                    };
                    let v33 = if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::taker_enabled(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_parameters(v32, arg0))) {
                        v33
                    } else {
                        let v34 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_current_sqrt_price(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v35 = arg16 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0) * arg16 / 10000 / 1000 + arg16 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_fee_rate(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v33.price_limit = v35;
                        let v36 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::decrease_sqrt_price(v32, v34, v35);
                        v33.sqrt_price_limit = v36;
                        if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::sui_is_coin_a(v32) && v34 <= v36 || !0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::sui_is_coin_a(v32) && v34 >= v36) {
                            v33
                        } else {
                            let (_, v38) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::estimate_buy_sell_price(v32, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v39 = get_target_quantity(arg0, arg1, arg2, v38, arg16, false);
                            let v40 = v39;
                            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v39, arg20, arg21);
                            let v41 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg2);
                            if (v39 > v41) {
                                v40 = v41;
                            };
                            if (v40 < 1 * 1000000000) {
                                v33.not_enough_balance = true;
                                v33
                            } else {
                                let (v42, v43) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::swap_sell(v32, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v40, v36, arg20, arg21);
                                let v44 = SwapMade{
                                    amount_sui         : v42,
                                    amount_usdc        : v43,
                                    is_buy             : false,
                                    pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::get_name(v32),
                                    timestamp          : 0x2::clock::timestamp_ms(arg20),
                                    balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<SwapMade>(v44);
                                v33.made_swap = true;
                                v33
                            }
                        }
                    };
                    0x1::vector::push_back<SwapAttempt>(&mut arg19.attempts, v33);
                } else if (v2 == 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::turbos_pool_id()) {
                    let v45 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::new_integration();
                    let v46 = &v45;
                    let v47 = SwapAttempt{
                        is_buy             : false,
                        pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_name(v46),
                        price_limit        : 0,
                        sqrt_price_limit   : 0,
                        pool_sqrt_price    : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_current_sqrt_price(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        not_enough_balance : false,
                        made_swap          : false,
                    };
                    let v47 = if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::taker_enabled(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_parameters(v46, arg0))) {
                        v47
                    } else {
                        let v48 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_current_sqrt_price(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v49 = arg16 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0) * arg16 / 10000 / 1000 + arg16 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_fee_rate(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v47.price_limit = v49;
                        let v50 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::decrease_sqrt_price(v46, v48, v49);
                        v47.sqrt_price_limit = v50;
                        if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::sui_is_coin_a(v46) && v48 <= v50 || !0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::sui_is_coin_a(v46) && v48 >= v50) {
                            v47
                        } else {
                            let (_, v52) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::estimate_buy_sell_price(v46, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v53 = get_target_quantity(arg0, arg1, arg2, v52, arg16, false);
                            let v54 = v53;
                            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v53, arg20, arg21);
                            let v55 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg2);
                            if (v53 > v55) {
                                v54 = v55;
                            };
                            if (v54 < 1 * 1000000000) {
                                v47.not_enough_balance = true;
                                v47
                            } else {
                                let (v56, v57) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::swap_sell(v46, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v54, v50, arg20, arg21);
                                let v58 = SwapMade{
                                    amount_sui         : v56,
                                    amount_usdc        : v57,
                                    is_buy             : false,
                                    pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::get_name(v46),
                                    timestamp          : 0x2::clock::timestamp_ms(arg20),
                                    balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<SwapMade>(v58);
                                v47.made_swap = true;
                                v47
                            }
                        }
                    };
                    0x1::vector::push_back<SwapAttempt>(&mut arg19.attempts, v47);
                } else if (v2 == 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::bluefin_pool_id()) {
                    let v59 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::new_integration();
                    let v60 = &v59;
                    let v61 = SwapAttempt{
                        is_buy             : false,
                        pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_name(v60),
                        price_limit        : 0,
                        sqrt_price_limit   : 0,
                        pool_sqrt_price    : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_current_sqrt_price(v60, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
                        not_enough_balance : false,
                        made_swap          : false,
                    };
                    let v61 = if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::taker_enabled(0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_parameters(v60, arg0))) {
                        v61
                    } else {
                        let v62 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_current_sqrt_price(v60, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                        let v63 = arg16 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0) * arg16 / 10000 / 1000 + arg16 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_fee_rate(v60, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) / 1000000;
                        v61.price_limit = v63;
                        let v64 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::decrease_sqrt_price(v60, v62, v63);
                        v61.sqrt_price_limit = v64;
                        if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::sui_is_coin_a(v60) && v62 <= v64 || !0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::sui_is_coin_a(v60) && v62 >= v64) {
                            v61
                        } else {
                            let (_, v66) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::estimate_buy_sell_price(v60, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
                            let v67 = get_target_quantity(arg0, arg1, arg2, v66, arg16, false);
                            let v68 = v67;
                            0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg15, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v67, arg20, arg21);
                            let v69 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg2);
                            if (v67 > v69) {
                                v68 = v69;
                            };
                            if (v68 < 1 * 1000000000) {
                                v61.not_enough_balance = true;
                                v61
                            } else {
                                let (v70, v71) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::swap_sell(v60, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v68, v64, arg20, arg21);
                                let v72 = SwapMade{
                                    amount_sui         : v70,
                                    amount_usdc        : v71,
                                    is_buy             : false,
                                    pool               : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::get_name(v60),
                                    timestamp          : 0x2::clock::timestamp_ms(arg20),
                                    balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                                };
                                0x2::event::emit<SwapMade>(v72);
                                v61.made_swap = true;
                                v61
                            }
                        }
                    };
                    0x1::vector::push_back<SwapAttempt>(&mut arg19.attempts, v61);
                };
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun try_swap_takers(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::OpenPoolPositions, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg11: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg12: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg15: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg16: u64, arg17: &mut u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swaps_taker_enabled(arg0)) {
            return
        };
        if (0x2::clock::timestamp_ms(arg18) < *arg17 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_cooldown_ms(arg0)) {
            return
        };
        let v0 = 0x1::vector::empty<PoolPricePair>();
        let v1 = 0x1::vector::empty<PoolPricePair>();
        let v2 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_low_fee_pool_id();
        let v3 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(0);
        let (v4, v5) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::estimate_buy_sell_price(&v3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v6 = PoolPricePair{
            price   : v4,
            pool_id : v2,
        };
        0x1::vector::push_back<PoolPricePair>(&mut v0, v6);
        let v7 = PoolPricePair{
            price   : v5,
            pool_id : v2,
        };
        0x1::vector::push_back<PoolPricePair>(&mut v1, v7);
        let v8 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::cetus_high_fee_pool_id();
        let v9 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::new_integration(1);
        let (v10, v11) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_cetus::estimate_buy_sell_price(&v9, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v12 = PoolPricePair{
            price   : v10,
            pool_id : v8,
        };
        0x1::vector::push_back<PoolPricePair>(&mut v0, v12);
        let v13 = PoolPricePair{
            price   : v11,
            pool_id : v8,
        };
        0x1::vector::push_back<PoolPricePair>(&mut v1, v13);
        let v14 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::mmt_pool_id();
        let v15 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::new_integration();
        let (v16, v17) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_mmt::estimate_buy_sell_price(&v15, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v18 = PoolPricePair{
            price   : v16,
            pool_id : v14,
        };
        0x1::vector::push_back<PoolPricePair>(&mut v0, v18);
        let v19 = PoolPricePair{
            price   : v17,
            pool_id : v14,
        };
        0x1::vector::push_back<PoolPricePair>(&mut v1, v19);
        let v20 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::turbos_pool_id();
        let v21 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::new_integration();
        let (v22, v23) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_turbos::estimate_buy_sell_price(&v21, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v24 = PoolPricePair{
            price   : v22,
            pool_id : v20,
        };
        0x1::vector::push_back<PoolPricePair>(&mut v0, v24);
        let v25 = PoolPricePair{
            price   : v23,
            pool_id : v20,
        };
        0x1::vector::push_back<PoolPricePair>(&mut v1, v25);
        let v26 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::bluefin_pool_id();
        let v27 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::new_integration();
        let (v28, v29) = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_bluefin::estimate_buy_sell_price(&v27, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v30 = PoolPricePair{
            price   : v28,
            pool_id : v26,
        };
        0x1::vector::push_back<PoolPricePair>(&mut v0, v30);
        let v31 = PoolPricePair{
            price   : v29,
            pool_id : v26,
        };
        0x1::vector::push_back<PoolPricePair>(&mut v1, v31);
        let v32 = SwapResults{
            buy_prices  : v0,
            sell_prices : v1,
            attempts    : 0x1::vector::empty<SwapAttempt>(),
            timestamp   : 0x2::clock::timestamp_ms(arg18),
        };
        let v33 = &mut v0;
        let v34 = 0x1::vector::length<PoolPricePair>(v33);
        if (v34 <= 1) {
        } else {
            let v35 = 0;
            while (v35 < v34) {
                let v36 = 0;
                let v37 = false;
                while (v36 < v34 - v35 - 1) {
                    let v38 = 0x1::vector::borrow<PoolPricePair>(v33, v36);
                    let v39 = 0x1::vector::borrow<PoolPricePair>(v33, v36 + 1);
                    let v40 = *v38;
                    let v41 = *v39;
                    if (!(v40.price < v41.price)) {
                        *0x1::vector::borrow_mut<PoolPricePair>(v33, v36) = *v39;
                        *0x1::vector::borrow_mut<PoolPricePair>(v33, v36 + 1) = *v38;
                        v37 = true;
                    };
                    v36 = v36 + 1;
                };
                if (!v37) {
                    break
                };
                v35 = v35 + 1;
            };
        };
        let v42 = &mut v1;
        let v43 = 0x1::vector::length<PoolPricePair>(v42);
        if (v43 <= 1) {
        } else {
            let v44 = 0;
            while (v44 < v43) {
                let v45 = 0;
                let v46 = false;
                while (v45 < v43 - v44 - 1) {
                    let v47 = 0x1::vector::borrow<PoolPricePair>(v42, v45);
                    let v48 = 0x1::vector::borrow<PoolPricePair>(v42, v45 + 1);
                    let v49 = *v47;
                    let v50 = *v48;
                    if (!(v49.price > v50.price)) {
                        *0x1::vector::borrow_mut<PoolPricePair>(v42, v45) = *v48;
                        *0x1::vector::borrow_mut<PoolPricePair>(v42, v45 + 1) = *v47;
                        v46 = true;
                    };
                    v45 = v45 + 1;
                };
                if (!v46) {
                    break
                };
                v44 = v44 + 1;
            };
        };
        let v51 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::swap_taker_threshold_bps_times_1k(arg0) * arg16 / 10000 / 1000;
        if (0x1::vector::borrow<PoolPricePair>(&v0, 0).price + v51 > arg16 && 0x1::vector::borrow<PoolPricePair>(&v1, 0).price < arg16 + v51) {
            0x2::event::emit<SwapResults>(v32);
            return
        };
        let v52 = &mut v32;
        run_taker_buys(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, &v0, v51, v52, arg18, arg19);
        let v53 = &mut v32;
        run_taker_sells(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, &v1, v51, v53, arg18, arg19);
        let v54 = &v32.attempts;
        let v55 = 0;
        while (v55 < 0x1::vector::length<SwapAttempt>(v54)) {
            if (0x1::vector::borrow<SwapAttempt>(v54, v55).made_swap) {
                *arg17 = 0x2::clock::timestamp_ms(arg18);
            };
            v55 = v55 + 1;
        };
        0x2::event::emit<SwapResults>(v32);
    }

    // decompiled from Move bytecode v6
}

