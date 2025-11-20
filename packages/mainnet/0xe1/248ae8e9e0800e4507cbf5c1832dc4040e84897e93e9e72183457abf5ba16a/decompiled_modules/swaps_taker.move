module 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_taker {
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

    struct SwapResults has copy, drop {
        mmt_sell: u64,
        mmt_buy: u64,
        cetus_sell: u64,
        cetus_buy: u64,
        turbos_buy: u64,
        turbos_sell: u64,
        attempts: vector<SwapAttempt>,
        timestamp: u64,
    }

    struct PoolPricePair has copy, drop {
        price: u64,
        pool_id: u64,
    }

    fun sort_pool_prices_by_highest(arg0: PoolPricePair, arg1: PoolPricePair, arg2: PoolPricePair) : (PoolPricePair, PoolPricePair, PoolPricePair) {
        let (v0, v1) = if (arg0.price >= arg1.price) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = if (v3.price >= arg2.price) {
            (v3, arg2)
        } else {
            (arg2, v3)
        };
        let v6 = v5;
        let (v7, v8) = if (v2.price >= v6.price) {
            (v2, v6)
        } else {
            (v6, v2)
        };
        (v4, v7, v8)
    }

    fun sort_pool_prices_by_lowest(arg0: PoolPricePair, arg1: PoolPricePair, arg2: PoolPricePair) : (PoolPricePair, PoolPricePair, PoolPricePair) {
        let (v0, v1) = if (arg0.price <= arg1.price) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = if (v3.price <= arg2.price) {
            (v3, arg2)
        } else {
            (arg2, v3)
        };
        let v6 = v5;
        let (v7, v8) = if (v2.price <= v6.price) {
            (v2, v6)
        } else {
            (v6, v2)
        };
        (v4, v7, v8)
    }

    fun try_execute_swap(arg0: &0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::Parameters, arg1: &mut 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: u64, arg12: u64, arg13: bool, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : SwapAttempt {
        if (arg12 == 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::cetus_pool_id()) {
            let v1 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::new_integration();
            if (arg13) {
                let v2 = &v1;
                let v3 = SwapAttempt{
                    is_buy             : true,
                    pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_name(v2),
                    price_limit        : 0,
                    sqrt_price_limit   : 0,
                    pool_sqrt_price    : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_current_sqrt_price(v2, arg6),
                    not_enough_balance : false,
                    made_swap          : false,
                };
                let v4 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_threshold_bps_times_1k(arg0) * arg11 / 10000 / 1000;
                let v5 = arg11 - v4 - arg11 * 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_fee_rate(v2, arg6) / 1000000;
                v3.price_limit = v5;
                let v6 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::increase_sqrt_price(v2, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_current_sqrt_price(v2, arg6), v5);
                v3.sqrt_price_limit = v6;
                if (0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::sui_is_coin_a(v2) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_current_sqrt_price(v2, arg6) >= v6 || !0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::sui_is_coin_a(v2) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_current_sqrt_price(v2, arg6) <= v6) {
                    v3
                } else {
                    let (v7, _) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::estimate_buy_sell_price(v2, arg6);
                    let v9 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::get_target_quantity(arg0, arg1, arg2, v7, arg11, true);
                    let v10 = v9;
                    let v11 = arg11 - v4;
                    0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg10, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_quote_at_price(arg0, v9, v11), arg14, arg15);
                    let v12 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_base_at_price(arg0, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::get_available_quote_balance(arg0, arg2), v11);
                    if (v9 > v12) {
                        v10 = v12;
                    };
                    if (v10 < 1 * 1000000000) {
                        v3.not_enough_balance = true;
                        v3
                    } else {
                        let (v13, v14) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::swap_buy(v2, arg2, arg6, arg7, v10, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_quote_at_price(arg0, v10, v11), v6, arg14, arg15);
                        let v15 = SwapMade{
                            amount_sui         : v13,
                            amount_usdc        : v14,
                            is_buy             : true,
                            pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_name(v2),
                            timestamp          : 0x2::clock::timestamp_ms(arg14),
                            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<SwapMade>(v15);
                        v3.made_swap = true;
                        v3
                    }
                }
            } else {
                let v16 = &v1;
                let v17 = SwapAttempt{
                    is_buy             : false,
                    pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_name(v16),
                    price_limit        : 0,
                    sqrt_price_limit   : 0,
                    pool_sqrt_price    : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_current_sqrt_price(v16, arg6),
                    not_enough_balance : false,
                    made_swap          : false,
                };
                let v18 = arg11 + 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_threshold_bps_times_1k(arg0) * arg11 / 10000 / 1000 + arg11 * 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_fee_rate(v16, arg6) / 1000000;
                v17.price_limit = v18;
                let v19 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::decrease_sqrt_price(v16, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_current_sqrt_price(v16, arg6), v18);
                v17.sqrt_price_limit = v19;
                if (0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::sui_is_coin_a(v16) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_current_sqrt_price(v16, arg6) <= v19 || !0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::sui_is_coin_a(v16) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_current_sqrt_price(v16, arg6) >= v19) {
                    v17
                } else {
                    let (_, v21) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::estimate_buy_sell_price(v16, arg6);
                    let v22 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::get_target_quantity(arg0, arg1, arg2, v21, arg11, false);
                    let v23 = v22;
                    0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg10, v22, arg14, arg15);
                    let v24 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::get_available_base_balance(arg0, arg2);
                    if (v22 > v24) {
                        v23 = v24;
                    };
                    if (v23 < 1 * 1000000000) {
                        v17.not_enough_balance = true;
                        v17
                    } else {
                        let (v25, v26) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::swap_sell(v16, arg2, arg6, arg7, v23, v19, arg14, arg15);
                        let v27 = SwapMade{
                            amount_sui         : v25,
                            amount_usdc        : v26,
                            is_buy             : false,
                            pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::get_name(v16),
                            timestamp          : 0x2::clock::timestamp_ms(arg14),
                            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<SwapMade>(v27);
                        v17.made_swap = true;
                        v17
                    }
                }
            }
        } else if (arg12 == 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::mmt_pool_id()) {
            let v28 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::new_integration();
            if (arg13) {
                let v29 = &v28;
                let v30 = SwapAttempt{
                    is_buy             : true,
                    pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_name(v29),
                    price_limit        : 0,
                    sqrt_price_limit   : 0,
                    pool_sqrt_price    : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_current_sqrt_price(v29, arg4),
                    not_enough_balance : false,
                    made_swap          : false,
                };
                let v31 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_threshold_bps_times_1k(arg0) * arg11 / 10000 / 1000;
                let v32 = arg11 - v31 - arg11 * 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_fee_rate(v29, arg4) / 1000000;
                v30.price_limit = v32;
                let v33 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::increase_sqrt_price(v29, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_current_sqrt_price(v29, arg4), v32);
                v30.sqrt_price_limit = v33;
                if (0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::sui_is_coin_a(v29) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_current_sqrt_price(v29, arg4) >= v33 || !0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::sui_is_coin_a(v29) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_current_sqrt_price(v29, arg4) <= v33) {
                    v30
                } else {
                    let (v34, _) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::estimate_buy_sell_price(v29, arg4);
                    let v36 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::get_target_quantity(arg0, arg1, arg2, v34, arg11, true);
                    let v37 = v36;
                    let v38 = arg11 - v31;
                    0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg10, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_quote_at_price(arg0, v36, v38), arg14, arg15);
                    let v39 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_base_at_price(arg0, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::get_available_quote_balance(arg0, arg2), v38);
                    if (v36 > v39) {
                        v37 = v39;
                    };
                    if (v37 < 1 * 1000000000) {
                        v30.not_enough_balance = true;
                        v30
                    } else {
                        let (v40, v41) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::swap_buy(v29, arg2, arg4, arg5, v37, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_quote_at_price(arg0, v37, v38), v33, arg14, arg15);
                        let v42 = SwapMade{
                            amount_sui         : v40,
                            amount_usdc        : v41,
                            is_buy             : true,
                            pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_name(v29),
                            timestamp          : 0x2::clock::timestamp_ms(arg14),
                            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<SwapMade>(v42);
                        v30.made_swap = true;
                        v30
                    }
                }
            } else {
                let v43 = &v28;
                let v44 = SwapAttempt{
                    is_buy             : false,
                    pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_name(v43),
                    price_limit        : 0,
                    sqrt_price_limit   : 0,
                    pool_sqrt_price    : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_current_sqrt_price(v43, arg4),
                    not_enough_balance : false,
                    made_swap          : false,
                };
                let v45 = arg11 + 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_threshold_bps_times_1k(arg0) * arg11 / 10000 / 1000 + arg11 * 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_fee_rate(v43, arg4) / 1000000;
                v44.price_limit = v45;
                let v46 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::decrease_sqrt_price(v43, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_current_sqrt_price(v43, arg4), v45);
                v44.sqrt_price_limit = v46;
                if (0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::sui_is_coin_a(v43) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_current_sqrt_price(v43, arg4) <= v46 || !0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::sui_is_coin_a(v43) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_current_sqrt_price(v43, arg4) >= v46) {
                    v44
                } else {
                    let (_, v48) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::estimate_buy_sell_price(v43, arg4);
                    let v49 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::get_target_quantity(arg0, arg1, arg2, v48, arg11, false);
                    let v50 = v49;
                    0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg10, v49, arg14, arg15);
                    let v51 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::get_available_base_balance(arg0, arg2);
                    if (v49 > v51) {
                        v50 = v51;
                    };
                    if (v50 < 1 * 1000000000) {
                        v44.not_enough_balance = true;
                        v44
                    } else {
                        let (v52, v53) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::swap_sell(v43, arg2, arg4, arg5, v50, v46, arg14, arg15);
                        let v54 = SwapMade{
                            amount_sui         : v52,
                            amount_usdc        : v53,
                            is_buy             : false,
                            pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::get_name(v43),
                            timestamp          : 0x2::clock::timestamp_ms(arg14),
                            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<SwapMade>(v54);
                        v44.made_swap = true;
                        v44
                    }
                }
            }
        } else {
            assert!(arg12 == 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::turbos_pool_id(), 13906835939574939647);
            let v55 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::new_integration();
            if (arg13) {
                let v56 = &v55;
                let v57 = SwapAttempt{
                    is_buy             : true,
                    pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_name(v56),
                    price_limit        : 0,
                    sqrt_price_limit   : 0,
                    pool_sqrt_price    : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_current_sqrt_price(v56, arg8),
                    not_enough_balance : false,
                    made_swap          : false,
                };
                let v58 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_threshold_bps_times_1k(arg0) * arg11 / 10000 / 1000;
                let v59 = arg11 - v58 - arg11 * 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_fee_rate(v56, arg8) / 1000000;
                v57.price_limit = v59;
                let v60 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::increase_sqrt_price(v56, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_current_sqrt_price(v56, arg8), v59);
                v57.sqrt_price_limit = v60;
                if (0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::sui_is_coin_a(v56) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_current_sqrt_price(v56, arg8) >= v60 || !0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::sui_is_coin_a(v56) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_current_sqrt_price(v56, arg8) <= v60) {
                    v57
                } else {
                    let (v61, _) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::estimate_buy_sell_price(v56, arg8);
                    let v63 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::get_target_quantity(arg0, arg1, arg2, v61, arg11, true);
                    let v64 = v63;
                    let v65 = arg11 - v58;
                    0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg10, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_quote_at_price(arg0, v63, v65), arg14, arg15);
                    let v66 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_base_at_price(arg0, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::get_available_quote_balance(arg0, arg2), v65);
                    if (v63 > v66) {
                        v64 = v66;
                    };
                    if (v64 < 1 * 1000000000) {
                        v57.not_enough_balance = true;
                        v57
                    } else {
                        let (v67, v68) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::swap_buy(v56, arg2, arg8, arg9, v64, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_quote_at_price(arg0, v64, v65), v60, arg14, arg15);
                        let v69 = SwapMade{
                            amount_sui         : v67,
                            amount_usdc        : v68,
                            is_buy             : true,
                            pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_name(v56),
                            timestamp          : 0x2::clock::timestamp_ms(arg14),
                            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<SwapMade>(v69);
                        v57.made_swap = true;
                        v57
                    }
                }
            } else {
                let v70 = &v55;
                let v71 = SwapAttempt{
                    is_buy             : false,
                    pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_name(v70),
                    price_limit        : 0,
                    sqrt_price_limit   : 0,
                    pool_sqrt_price    : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_current_sqrt_price(v70, arg8),
                    not_enough_balance : false,
                    made_swap          : false,
                };
                let v72 = arg11 + 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_threshold_bps_times_1k(arg0) * arg11 / 10000 / 1000 + arg11 * 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_fee_rate(v70, arg8) / 1000000;
                v71.price_limit = v72;
                let v73 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::decrease_sqrt_price(v70, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_current_sqrt_price(v70, arg8), v72);
                v71.sqrt_price_limit = v73;
                if (0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::sui_is_coin_a(v70) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_current_sqrt_price(v70, arg8) <= v73 || !0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::sui_is_coin_a(v70) && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_current_sqrt_price(v70, arg8) >= v73) {
                    v71
                } else {
                    let (_, v75) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::estimate_buy_sell_price(v70, arg8);
                    let v76 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::get_target_quantity(arg0, arg1, arg2, v75, arg11, false);
                    let v77 = v76;
                    0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg10, v76, arg14, arg15);
                    let v78 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::get_available_base_balance(arg0, arg2);
                    if (v76 > v78) {
                        v77 = v78;
                    };
                    if (v77 < 1 * 1000000000) {
                        v71.not_enough_balance = true;
                        v71
                    } else {
                        let (v79, v80) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::swap_sell(v70, arg2, arg8, arg9, v77, v73, arg14, arg15);
                        let v81 = SwapMade{
                            amount_sui         : v79,
                            amount_usdc        : v80,
                            is_buy             : false,
                            pool               : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::get_name(v70),
                            timestamp          : 0x2::clock::timestamp_ms(arg14),
                            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<SwapMade>(v81);
                        v71.made_swap = true;
                        v71
                    }
                }
            }
        }
    }

    public(friend) fun try_swap_takers(arg0: &0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::Parameters, arg1: &mut 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: u64, arg12: &mut u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        if (!0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swaps_enabled(arg0)) {
            return
        };
        if (0x2::clock::timestamp_ms(arg13) < *arg12 + 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_cooldown_ms(arg0)) {
            return
        };
        let v0 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::new_integration();
        let (v1, v2) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_mmt::estimate_buy_sell_price(&v0, arg4);
        let v3 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::new_integration();
        let (v4, v5) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_cetus::estimate_buy_sell_price(&v3, arg6);
        let v6 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::new_integration();
        let (v7, v8) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_turbos::estimate_buy_sell_price(&v6, arg8);
        let v9 = SwapResults{
            mmt_sell    : v2,
            mmt_buy     : v1,
            cetus_sell  : v5,
            cetus_buy   : v4,
            turbos_buy  : v7,
            turbos_sell : v8,
            attempts    : 0x1::vector::empty<SwapAttempt>(),
            timestamp   : 0x2::clock::timestamp_ms(arg13),
        };
        let v10 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_threshold_bps_times_1k(arg0) * arg11 / 10000 / 1000;
        if (0x1::u64::min(0x1::u64::min(v1, v4), v7) + v10 > arg11 && 0x1::u64::max(0x1::u64::max(v2, v5), v8) < arg11 + v10) {
            0x2::event::emit<SwapResults>(v9);
            return
        };
        let v11 = PoolPricePair{
            price   : v1,
            pool_id : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::mmt_pool_id(),
        };
        let v12 = PoolPricePair{
            price   : v4,
            pool_id : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::cetus_pool_id(),
        };
        let v13 = PoolPricePair{
            price   : v7,
            pool_id : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::turbos_pool_id(),
        };
        let (v14, v15, v16) = sort_pool_prices_by_lowest(v11, v12, v13);
        let v17 = v16;
        let v18 = v15;
        let v19 = v14;
        if (0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::allowed_to_buy(arg0) && v19.price + v10 <= arg11) {
            let v20 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v19.pool_id, true, arg13, arg14);
            0x1::vector::push_back<SwapAttempt>(&mut v9.attempts, v20);
            if (v18.price + v10 <= arg11) {
                let v21 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v18.pool_id, true, arg13, arg14);
                0x1::vector::push_back<SwapAttempt>(&mut v9.attempts, v21);
                if (v17.price + v10 <= arg11) {
                    let v22 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v17.pool_id, true, arg13, arg14);
                    0x1::vector::push_back<SwapAttempt>(&mut v9.attempts, v22);
                };
            };
        };
        let v23 = PoolPricePair{
            price   : v2,
            pool_id : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::mmt_pool_id(),
        };
        let v24 = PoolPricePair{
            price   : v5,
            pool_id : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::cetus_pool_id(),
        };
        let v25 = PoolPricePair{
            price   : v8,
            pool_id : 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common::turbos_pool_id(),
        };
        let (v26, v27, v28) = sort_pool_prices_by_highest(v23, v24, v25);
        let v29 = v28;
        let v30 = v27;
        let v31 = v26;
        if (v31.price >= arg11 + v10) {
            let v32 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v31.pool_id, false, arg13, arg14);
            0x1::vector::push_back<SwapAttempt>(&mut v9.attempts, v32);
            if (v30.price >= arg11 + v10) {
                let v33 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v30.pool_id, false, arg13, arg14);
                0x1::vector::push_back<SwapAttempt>(&mut v9.attempts, v33);
                if (v29.price >= arg11 + v10) {
                    0x1::vector::push_back<SwapAttempt>(&mut v9.attempts, try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v29.pool_id, false, arg13, arg14));
                };
            };
        };
        let v34 = &v9.attempts;
        let v35 = 0;
        while (v35 < 0x1::vector::length<SwapAttempt>(v34)) {
            if (0x1::vector::borrow<SwapAttempt>(v34, v35).made_swap) {
                *arg12 = 0x2::clock::timestamp_ms(arg13);
            };
            v35 = v35 + 1;
        };
        0x2::event::emit<SwapResults>(v9);
    }

    // decompiled from Move bytecode v6
}

