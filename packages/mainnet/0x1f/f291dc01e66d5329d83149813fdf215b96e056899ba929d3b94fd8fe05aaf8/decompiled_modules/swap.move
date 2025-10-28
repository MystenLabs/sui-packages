module 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::swap {
    struct SwapQuantityPriceAttempt has copy, drop {
        quantity_sui: u64,
        price: u64,
    }

    struct SwapAttempt has copy, drop {
        is_buy: bool,
        pool: 0x1::string::String,
        initial_price: u64,
        not_enough_balance: bool,
        quantity_price_attempts: vector<SwapQuantityPriceAttempt>,
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
        bluefin_buy: u64,
        bluefin_sell: u64,
        attempts: vector<SwapAttempt>,
        timestamp: u64,
    }

    struct PoolPricePair has copy, drop {
        price: u64,
        pool_id: u64,
    }

    fun estimate_bluefin_buy_sell_price(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : (u64, u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        let v1 = ((1000000000 * (v0 as u256) * (v0 as u256) / 340282366920938463463374607431768211456) as u64);
        let v2 = v1 * 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0) / 1000000;
        (v1 + v2, v1 - v2)
    }

    fun estimate_cetus_buy_sell_price(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>) : (u64, u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0);
        let v1 = ((340282366920938463463374607431768211456000000000 / (v0 as u256) * (v0 as u256)) as u64);
        let v2 = v1 * 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0) / 1000000;
        (v1 + v2, v1 - v2)
    }

    fun estimate_mmt_buy_sell_price(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : (u64, u64) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        let v1 = ((1000000000 * (v0 as u256) * (v0 as u256) / 340282366920938463463374607431768211456) as u64);
        let v2 = v1 * 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0) / 1000000;
        (v1 + v2, v1 - v2)
    }

    fun get_swap_price(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * (1000000000 as u128) / (arg0 as u128)) as u64)
    }

    fun get_target_quantity(arg0: &0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::Parameters, arg1: u64, arg2: u64, arg3: bool) : u64 {
        if (arg3 && arg1 >= arg2) {
            return 0
        };
        if (!arg3 && arg1 <= arg2) {
            return 0
        };
        let v0 = 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::abs_diff(arg1, arg2) * 1000 / arg2 / 10000;
        if (v0 < 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_threshold_bps_times_1k(arg0)) {
            return 0
        };
        0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_minimum_start_quantity(arg0) + 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_step_start_quantity(arg0) * (v0 - 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_threshold_bps_times_1k(arg0)) / 1000
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

    fun try_bluefin_buy(arg0: &0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::Parameters, arg1: &mut 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
        let v0 = SwapAttempt{
            is_buy                  : true,
            pool                    : 0x1::string::utf8(b"bluefin"),
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, 1 * 1000000000, 79226673515401279992447579055 - 1);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v1);
        v0.initial_price = v2;
        if (v2 + 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000 > arg7) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, true);
        let v4 = v3;
        0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg6, 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::convert_to_quote_at_price(arg0, v3, v2), arg8, arg9);
        let v5 = 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::convert_to_base_at_price(arg0, 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::get_available_quote_balance(arg0, arg2), v2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        while (v4 > 1 * 1000000000) {
            let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, v4, 79226673515401279992447579055 - 1);
            let v7 = get_swap_price(v4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6));
            let v8 = SwapQuantityPriceAttempt{
                quantity_sui : v4,
                price        : v7,
            };
            0x1::vector::push_back<SwapQuantityPriceAttempt>(&mut v0.quantity_price_attempts, v8);
            if (v4 > get_target_quantity(arg0, v7, arg7, true) * 2) {
                v4 = v4 / 2;
            } else {
                let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6);
                let (v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg8, arg5, arg4, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v9, arg9)), false, false, v4, 18446744073709551615, 79226673515401279992447579055 - 1);
                let v12 = v11;
                let v13 = v10;
                let v14 = SwapMade{
                    amount_sui         : 0x2::balance::value<0x2::sui::SUI>(&v13),
                    amount_usdc        : v9 - 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v12),
                    is_buy             : true,
                    pool               : 0x1::string::utf8(b"bluefin"),
                    timestamp          : 0x2::clock::timestamp_ms(arg8),
                    balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                };
                0x2::event::emit<SwapMade>(v14);
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v13, arg9), arg9);
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v12, arg9), arg9);
                v0.made_swap = true;
                break
            };
        };
        v0
    }

    fun try_bluefin_sell(arg0: &0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::Parameters, arg1: &mut 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
        let v0 = SwapAttempt{
            is_buy                  : false,
            pool                    : 0x1::string::utf8(b"bluefin"),
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, 1 * 1000000000, 4295048016 + 1);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v1);
        v0.initial_price = v2;
        if (v2 < arg7 + 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, false);
        let v4 = v3;
        0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg6, v3, arg8, arg9);
        let v5 = 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::get_available_base_balance(arg0, arg2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        while (v4 > 1 * 1000000000) {
            let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, v4, 4295048016 + 1);
            let v7 = get_swap_price(v4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6));
            let v8 = SwapQuantityPriceAttempt{
                quantity_sui : v4,
                price        : v7,
            };
            0x1::vector::push_back<SwapQuantityPriceAttempt>(&mut v0.quantity_price_attempts, v8);
            if (v4 > get_target_quantity(arg0, v7, arg7, false) * 2) {
                v4 = v4 / 2;
                continue
            };
            let (v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg8, arg5, arg4, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v4, arg9)), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), true, true, v4, 0, 4295048016 + 1);
            let v11 = v10;
            let v12 = v9;
            assert!(0x2::balance::value<0x2::sui::SUI>(&v12) == 0, 13906837580252446719);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
            let v13 = SwapMade{
                amount_sui         : v4,
                amount_usdc        : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v11),
                is_buy             : false,
                pool               : 0x1::string::utf8(b"bluefin"),
                timestamp          : 0x2::clock::timestamp_ms(arg8),
                balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
            };
            0x2::event::emit<SwapMade>(v13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v11, arg9), arg9);
            v0.made_swap = true;
            break
        };
        v0
    }

    fun try_cetus_buy(arg0: &0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::Parameters, arg1: &mut 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
        let v0 = SwapAttempt{
            is_buy                  : true,
            pool                    : 0x1::string::utf8(b"cetus"),
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, true, false, 1 * 1000000000);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v1) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v1);
        v0.initial_price = v2;
        if (v2 + 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000 > arg7) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, true);
        let v4 = v3;
        0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg6, 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::convert_to_quote_at_price(arg0, v3, v2), arg8, arg9);
        let v5 = 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::convert_to_base_at_price(arg0, 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::get_available_quote_balance(arg0, arg2), v2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        while (v4 > 1 * 1000000000) {
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, true, false, v4);
            let v7 = get_swap_price(v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v6) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6));
            let v8 = SwapQuantityPriceAttempt{
                quantity_sui : v4,
                price        : v7,
            };
            0x1::vector::push_back<SwapQuantityPriceAttempt>(&mut v0.quantity_price_attempts, v8);
            if (v4 > get_target_quantity(arg0, v7, arg7, true) * 2) {
                v4 = v4 / 2;
                continue
            };
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, true, false, v4, 4295048016, arg8);
            let v12 = v11;
            let v13 = v10;
            let v14 = v9;
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v12);
            assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v14) == 0, 13906836901647613951);
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v14);
            let v16 = SwapMade{
                amount_sui         : 0x2::balance::value<0x2::sui::SUI>(&v13),
                amount_usdc        : v15,
                is_buy             : true,
                pool               : 0x1::string::utf8(b"cetus"),
                timestamp          : 0x2::clock::timestamp_ms(arg8),
                balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
            };
            0x2::event::emit<SwapMade>(v16);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v13, arg9), arg9);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v15, arg9)), 0x2::balance::zero<0x2::sui::SUI>(), v12);
            v0.made_swap = true;
            break
        };
        v0
    }

    fun try_cetus_sell(arg0: &0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::Parameters, arg1: &mut 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
        let v0 = SwapAttempt{
            is_buy                  : false,
            pool                    : 0x1::string::utf8(b"cetus"),
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, false, true, 1 * 1000000000);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1);
        v0.initial_price = v2;
        if (v2 < arg7 + 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, false);
        let v4 = v3;
        0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg6, v3, arg8, arg9);
        let v5 = 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::get_available_base_balance(arg0, arg2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        while (v4 > 1 * 1000000000) {
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, false, true, v4);
            let v7 = get_swap_price(v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v6));
            let v8 = SwapQuantityPriceAttempt{
                quantity_sui : v4,
                price        : v7,
            };
            0x1::vector::push_back<SwapQuantityPriceAttempt>(&mut v0.quantity_price_attempts, v8);
            if (v4 > get_target_quantity(arg0, v7, arg7, false) * 2) {
                v4 = v4 / 2;
                continue
            };
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, false, true, v4, 79226673515401279992447579055, arg8);
            let v12 = v11;
            let v13 = v10;
            let v14 = v9;
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v12);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v13) == 0, 13906836326121996287);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v13);
            let v16 = SwapMade{
                amount_sui         : v15,
                amount_usdc        : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v14),
                is_buy             : false,
                pool               : 0x1::string::utf8(b"cetus"),
                timestamp          : 0x2::clock::timestamp_ms(arg8),
                balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
            };
            0x2::event::emit<SwapMade>(v16);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v14, arg9), arg9);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v15, arg9)), v12);
            v0.made_swap = true;
            break
        };
        v0
    }

    fun try_execute_swap(arg0: &0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::Parameters, arg1: &mut 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: u64, arg12: u64, arg13: bool, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : SwapAttempt {
        if (arg12 == 0 && arg13) {
            try_mmt_buy(arg0, arg1, arg2, arg3, arg4, arg5, arg10, arg11, arg14, arg15)
        } else if (arg12 == 0 && !arg13) {
            try_mmt_sell(arg0, arg1, arg2, arg3, arg4, arg5, arg10, arg11, arg14, arg15)
        } else if (arg12 == 1 && arg13) {
            try_cetus_buy(arg0, arg1, arg2, arg3, arg6, arg7, arg10, arg11, arg14, arg15)
        } else if (arg12 == 1 && !arg13) {
            try_cetus_sell(arg0, arg1, arg2, arg3, arg6, arg7, arg10, arg11, arg14, arg15)
        } else if (arg12 == 2 && arg13) {
            try_bluefin_buy(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg14, arg15)
        } else {
            assert!(arg12 == 2 && !arg13, 13906838576684859391);
            try_bluefin_sell(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg14, arg15)
        }
    }

    fun try_mmt_buy(arg0: &0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::Parameters, arg1: &mut 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
        let v0 = SwapAttempt{
            is_buy                  : true,
            pool                    : 0x1::string::utf8(b"mmt"),
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, 79226673515401279992447579055, 1 * 1000000000);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1);
        v0.initial_price = v2;
        if (v2 + 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000 > arg7) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, true);
        let v4 = v3;
        0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg6, 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::convert_to_quote_at_price(arg0, v3, v2), arg8, arg9);
        let v5 = 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::convert_to_base_at_price(arg0, 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::get_available_quote_balance(arg0, arg2), v2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        while (v4 > 1 * 1000000000) {
            let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, 79226673515401279992447579055, v4);
            let v7 = get_swap_price(v4, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v6));
            let v8 = SwapQuantityPriceAttempt{
                quantity_sui : v4,
                price        : v7,
            };
            0x1::vector::push_back<SwapQuantityPriceAttempt>(&mut v0.quantity_price_attempts, v8);
            if (v4 > get_target_quantity(arg0, v7, arg7, true) * 2) {
                v4 = v4 / 2;
                continue
            };
            let (v9, v10, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, v4, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg8, arg5, arg9);
            let v12 = v11;
            let v13 = v10;
            let v14 = v9;
            let (v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v12);
            assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v13) == 0, 13906835673286967295);
            assert!(v15 == 0, 13906835677581934591);
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v13);
            let v17 = SwapMade{
                amount_sui         : 0x2::balance::value<0x2::sui::SUI>(&v14),
                amount_usdc        : v16,
                is_buy             : true,
                pool               : 0x1::string::utf8(b"mmt"),
                timestamp          : 0x2::clock::timestamp_ms(arg8),
                balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
            };
            0x2::event::emit<SwapMade>(v17);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v14, arg9), arg9);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v12, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v16, arg9)), arg5, arg9);
            v0.made_swap = true;
            break
        };
        v0
    }

    fun try_mmt_sell(arg0: &0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::Parameters, arg1: &mut 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
        let v0 = SwapAttempt{
            is_buy                  : false,
            pool                    : 0x1::string::utf8(b"mmt"),
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, 4295048016, 1 * 1000000000);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1);
        v0.initial_price = v2;
        if (v2 < arg7 + 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, false);
        let v4 = v3;
        0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg6, v3, arg8, arg9);
        let v5 = 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::common::get_available_base_balance(arg0, arg2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        while (v4 > 1 * 1000000000) {
            let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, 4295048016, v4);
            let v7 = get_swap_price(v4, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v6));
            let v8 = SwapQuantityPriceAttempt{
                quantity_sui : v4,
                price        : v7,
            };
            0x1::vector::push_back<SwapQuantityPriceAttempt>(&mut v0.quantity_price_attempts, v8);
            if (v4 > get_target_quantity(arg0, v7, arg7, false) * 2) {
                v4 = v4 / 2;
                continue
            };
            let (v9, v10, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, v4, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg8, arg5, arg9);
            let v12 = v11;
            let v13 = v10;
            let v14 = v9;
            let (v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v12);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v14) == 0, 13906835067696578559);
            assert!(v16 == 0, 13906835071991545855);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
            let v17 = SwapMade{
                amount_sui         : v15,
                amount_usdc        : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v13),
                is_buy             : false,
                pool               : 0x1::string::utf8(b"mmt"),
                timestamp          : 0x2::clock::timestamp_ms(arg8),
                balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
            };
            0x2::event::emit<SwapMade>(v17);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v13, arg9), arg9);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v12, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v15, arg9)), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), arg5, arg9);
            v0.made_swap = true;
            break
        };
        v0
    }

    public fun try_swap_trades(arg0: &0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::Parameters, arg1: &mut 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: u64, arg12: &mut u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        if (!0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swaps_enabled(arg0)) {
            return
        };
        if (0x2::clock::timestamp_ms(arg13) < *arg12 + 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_cooldown_ms(arg0)) {
            return
        };
        let (v0, v1) = estimate_mmt_buy_sell_price(arg4);
        let (v2, v3) = estimate_cetus_buy_sell_price(arg6);
        let (v4, v5) = estimate_bluefin_buy_sell_price(arg8);
        let v6 = SwapResults{
            mmt_sell     : v1,
            mmt_buy      : v0,
            cetus_sell   : v3,
            cetus_buy    : v2,
            bluefin_buy  : v4,
            bluefin_sell : v5,
            attempts     : 0x1::vector::empty<SwapAttempt>(),
            timestamp    : 0x2::clock::timestamp_ms(arg13),
        };
        let v7 = 0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::swap_threshold_bps_times_1k(arg0) * arg11 / 10000 / 1000;
        if (0x1::u64::min(0x1::u64::min(v0, v2), v4) + v7 > arg11 && 0x1::u64::max(0x1::u64::max(v1, v3), v5) < arg11 + v7) {
            0x2::event::emit<SwapResults>(v6);
            return
        };
        let v8 = PoolPricePair{
            price   : v0,
            pool_id : 0,
        };
        let v9 = PoolPricePair{
            price   : v2,
            pool_id : 1,
        };
        let v10 = PoolPricePair{
            price   : v4,
            pool_id : 2,
        };
        let (v11, v12, v13) = sort_pool_prices_by_lowest(v8, v9, v10);
        let v14 = v13;
        let v15 = v12;
        let v16 = v11;
        if (0x1ff291dc01e66d5329d83149813fdf215b96e056899ba929d3b94fd8fe05aaf8::parameters::allowed_to_buy(arg0) && v16.price + v7 <= arg11) {
            let v17 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v16.pool_id, true, arg13, arg14);
            0x1::vector::push_back<SwapAttempt>(&mut v6.attempts, v17);
            if (v15.price + v7 <= arg11) {
                let v18 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v15.pool_id, true, arg13, arg14);
                0x1::vector::push_back<SwapAttempt>(&mut v6.attempts, v18);
                if (v14.price + v7 <= arg11) {
                    let v19 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v14.pool_id, true, arg13, arg14);
                    0x1::vector::push_back<SwapAttempt>(&mut v6.attempts, v19);
                };
            };
        };
        let v20 = PoolPricePair{
            price   : v1,
            pool_id : 0,
        };
        let v21 = PoolPricePair{
            price   : v3,
            pool_id : 1,
        };
        let v22 = PoolPricePair{
            price   : v5,
            pool_id : 2,
        };
        let (v23, v24, v25) = sort_pool_prices_by_highest(v20, v21, v22);
        let v26 = v25;
        let v27 = v24;
        let v28 = v23;
        if (v28.price >= arg11 + v7) {
            let v29 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v28.pool_id, false, arg13, arg14);
            0x1::vector::push_back<SwapAttempt>(&mut v6.attempts, v29);
            if (v27.price >= arg11 + v7) {
                let v30 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v27.pool_id, false, arg13, arg14);
                0x1::vector::push_back<SwapAttempt>(&mut v6.attempts, v30);
                if (v26.price >= arg11 + v7) {
                    0x1::vector::push_back<SwapAttempt>(&mut v6.attempts, try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v26.pool_id, false, arg13, arg14));
                };
            };
        };
        let v31 = &v6.attempts;
        let v32 = 0;
        while (v32 < 0x1::vector::length<SwapAttempt>(v31)) {
            if (0x1::vector::borrow<SwapAttempt>(v31, v32).made_swap) {
                *arg12 = 0x2::clock::timestamp_ms(arg13);
            };
            v32 = v32 + 1;
        };
        0x2::event::emit<SwapResults>(v6);
    }

    // decompiled from Move bytecode v6
}

