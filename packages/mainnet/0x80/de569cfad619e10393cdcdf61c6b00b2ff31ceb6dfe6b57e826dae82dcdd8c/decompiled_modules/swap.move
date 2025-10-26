module 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::swap {
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

    fun get_target_quantity(arg0: &0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::Parameters, arg1: u64, arg2: u64, arg3: bool) : u64 {
        if (arg3 && arg1 >= arg2) {
            return 0
        };
        if (!arg3 && arg1 <= arg2) {
            return 0
        };
        let v0 = 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::abs_diff(arg1, arg2) * 1000 / arg2 / 10000;
        if (v0 < 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::swap_threshold_bps_times_1k(arg0)) {
            return 0
        };
        0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::swap_minimum_start_quantity(arg0) + 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::swap_step_start_quantity(arg0) * (v0 - 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::swap_threshold_bps_times_1k(arg0)) / 1000
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

    fun try_bluefin_buy(arg0: &0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::Parameters, arg1: &mut 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
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
        get_target_quantity(arg0, v2, arg7, true);
        let v3 = 2 * 1000000000;
        let v4 = v3;
        0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg6, 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::convert_to_quote_at_price(arg0, v3, v2), arg8, arg9);
        let v5 = 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::convert_to_base_at_price(arg0, 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::get_available_quote_balance(arg0, arg2), v2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        if (v4 > 1 * 1000000000) {
            let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, v4, 79226673515401279992447579055 - 1);
            let v7 = get_swap_price(v4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6));
            let v8 = SwapQuantityPriceAttempt{
                quantity_sui : v4,
                price        : v7,
            };
            0x1::vector::push_back<SwapQuantityPriceAttempt>(&mut v0.quantity_price_attempts, v8);
            let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6);
            let (v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg8, arg5, arg4, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v9, arg9)), false, false, v4, v4, 79226673515401279992447579055 - 1);
            let v12 = v11;
            let v13 = v10;
            let v14 = SwapMade{
                amount_sui  : 0x2::balance::value<0x2::sui::SUI>(&v13),
                amount_usdc : v9 - 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v12),
                is_buy      : true,
                pool        : 0x1::string::utf8(b"bluefin"),
                timestamp   : 0x2::clock::timestamp_ms(arg8),
            };
            0x2::event::emit<SwapMade>(v14);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v13, arg9), arg9);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v12, arg9), arg9);
            v0.made_swap = true;
        };
        v0
    }

    fun try_bluefin_sell(arg0: &0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::Parameters, arg1: &mut 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
        let v0 = SwapAttempt{
            is_buy                  : false,
            pool                    : 0x1::string::utf8(b"bluefin"),
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, 1 * 1000000000, 4295048016);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v1);
        v0.initial_price = v2;
        get_target_quantity(arg0, v2, arg7, false);
        let v3 = 2 * 1000000000;
        let v4 = v3;
        0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg6, v3, arg8, arg9);
        let v5 = 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::get_available_base_balance(arg0, arg2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        if (v4 > 1 * 1000000000) {
            let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, v4, 4295048016);
            let v7 = get_swap_price(v4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6));
            let v8 = SwapQuantityPriceAttempt{
                quantity_sui : v4,
                price        : v7,
            };
            0x1::vector::push_back<SwapQuantityPriceAttempt>(&mut v0.quantity_price_attempts, v8);
            let (v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg8, arg5, arg4, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v4, arg9)), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), true, true, v4, v4, 4295048016);
            let v11 = v10;
            let v12 = v9;
            assert!(0x2::balance::value<0x2::sui::SUI>(&v12) == 0, 13906837571662512127);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
            let v13 = SwapMade{
                amount_sui  : v4,
                amount_usdc : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v11),
                is_buy      : false,
                pool        : 0x1::string::utf8(b"bluefin"),
                timestamp   : 0x2::clock::timestamp_ms(arg8),
            };
            0x2::event::emit<SwapMade>(v13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v11, arg9), arg9);
            v0.made_swap = true;
        };
        v0
    }

    fun try_cetus_buy(arg0: &0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::Parameters, arg1: &mut 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
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
        if (v2 + 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000 > arg7) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, true);
        let v4 = v3;
        0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg6, 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::convert_to_quote_at_price(arg0, v3, v2), arg8, arg9);
        let v5 = 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::convert_to_base_at_price(arg0, 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::get_available_quote_balance(arg0, arg2), v2);
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
            assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v14) == 0, 13906836893057679359);
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v14);
            let v16 = SwapMade{
                amount_sui  : 0x2::balance::value<0x2::sui::SUI>(&v13),
                amount_usdc : v15,
                is_buy      : true,
                pool        : 0x1::string::utf8(b"cetus"),
                timestamp   : 0x2::clock::timestamp_ms(arg8),
            };
            0x2::event::emit<SwapMade>(v16);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v13, arg9), arg9);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v15, arg9)), 0x2::balance::zero<0x2::sui::SUI>(), v12);
            v0.made_swap = true;
            break
        };
        v0
    }

    fun try_cetus_sell(arg0: &0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::Parameters, arg1: &mut 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
        let v0 = SwapAttempt{
            is_buy                  : false,
            pool                    : 0x1::string::utf8(b"cetus"),
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, false, true, 1 * 1000000000);
        let v2 = get_swap_price(1 * 1000000000 + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        v0.initial_price = v2;
        if (v2 < arg7 + 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, false);
        let v4 = v3;
        0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg6, v3, arg8, arg9);
        let v5 = 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::get_available_base_balance(arg0, arg2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        while (v4 > 1 * 1000000000) {
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, false, true, v4);
            let v7 = get_swap_price(v4 + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v6));
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
            assert!(0x2::balance::value<0x2::sui::SUI>(&v13) == 0, 13906836321827028991);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v13);
            let v16 = SwapMade{
                amount_sui  : v15,
                amount_usdc : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v14),
                is_buy      : false,
                pool        : 0x1::string::utf8(b"cetus"),
                timestamp   : 0x2::clock::timestamp_ms(arg8),
            };
            0x2::event::emit<SwapMade>(v16);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v14, arg9), arg9);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v15, arg9)), v12);
            v0.made_swap = true;
            break
        };
        v0
    }

    fun try_execute_swap(arg0: &0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::Parameters, arg1: &mut 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: u64, arg12: u64, arg13: bool, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : SwapAttempt {
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
            assert!(arg12 == 2 && !arg13, 13906838563799957503);
            try_bluefin_sell(arg0, arg1, arg2, arg3, arg8, arg9, arg10, arg11, arg14, arg15)
        }
    }

    fun try_mmt_buy(arg0: &0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::Parameters, arg1: &mut 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
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
        if (v2 + 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000 > arg7) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, true);
        let v4 = v3;
        0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg6, 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::convert_to_quote_at_price(arg0, v3, v2), arg8, arg9);
        let v5 = 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::convert_to_base_at_price(arg0, 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::get_available_quote_balance(arg0, arg2), v2);
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
            assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v13) == 0, 13906835664697032703);
            assert!(v15 == 0, 13906835668991999999);
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v13);
            let v17 = SwapMade{
                amount_sui  : 0x2::balance::value<0x2::sui::SUI>(&v14),
                amount_usdc : v16,
                is_buy      : true,
                pool        : 0x1::string::utf8(b"mmt"),
                timestamp   : 0x2::clock::timestamp_ms(arg8),
            };
            0x2::event::emit<SwapMade>(v17);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v14, arg9), arg9);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v12, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v16, arg9)), arg5, arg9);
            v0.made_swap = true;
            break
        };
        v0
    }

    fun try_mmt_sell(arg0: &0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::Parameters, arg1: &mut 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapAttempt {
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
        if (v2 < arg7 + 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, false);
        let v4 = v3;
        0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg6, v3, arg8, arg9);
        let v5 = 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::get_available_base_balance(arg0, arg2);
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
            assert!(0x2::balance::value<0x2::sui::SUI>(&v14) == 0, 13906835063401611263);
            assert!(v16 == 0, 13906835067696578559);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
            let v17 = SwapMade{
                amount_sui  : v15,
                amount_usdc : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v13),
                is_buy      : false,
                pool        : 0x1::string::utf8(b"mmt"),
                timestamp   : 0x2::clock::timestamp_ms(arg8),
            };
            0x2::event::emit<SwapMade>(v17);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v13, arg9), arg9);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v12, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v15, arg9)), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), arg5, arg9);
            v0.made_swap = true;
            break
        };
        v0
    }

    public fun try_swap_trades(arg0: &0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::Parameters, arg1: &mut 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (!0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::swaps_enabled(arg0)) {
            return
        };
        let (v0, v1, _) = 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::get_asset_balances(arg2, arg10);
        if (0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::common::convert_to_quote_at_price(arg0, v0, arg11) + v1 < 0x80de569cfad619e10393cdcdf61c6b00b2ff31ceb6dfe6b57e826dae82dcdd8c::parameters::swap_minimum_portfolio(arg0)) {
            return
        };
        let (v3, v4) = estimate_mmt_buy_sell_price(arg4);
        let (v5, v6) = estimate_cetus_buy_sell_price(arg6);
        let (v7, v8) = estimate_bluefin_buy_sell_price(arg8);
        let v9 = SwapResults{
            mmt_sell     : v4,
            mmt_buy      : v3,
            cetus_sell   : v6,
            cetus_buy    : v5,
            bluefin_buy  : v7,
            bluefin_sell : v8,
            attempts     : 0x1::vector::empty<SwapAttempt>(),
            timestamp    : 0x2::clock::timestamp_ms(arg12),
        };
        let v10 = PoolPricePair{
            price   : v3,
            pool_id : 0,
        };
        let v11 = PoolPricePair{
            price   : v5,
            pool_id : 1,
        };
        let v12 = PoolPricePair{
            price   : v7,
            pool_id : 2,
        };
        let (_, _, _) = sort_pool_prices_by_lowest(v10, v11, v12);
        let v16 = PoolPricePair{
            price   : v4,
            pool_id : 0,
        };
        let v17 = PoolPricePair{
            price   : v6,
            pool_id : 1,
        };
        let v18 = PoolPricePair{
            price   : v8,
            pool_id : 2,
        };
        let (v19, v20, v21) = sort_pool_prices_by_highest(v16, v17, v18);
        let v22 = v21;
        let v23 = v20;
        let v24 = v19;
        let v25 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v24.pool_id, false, arg12, arg13);
        0x1::vector::push_back<SwapAttempt>(&mut v9.attempts, v25);
        let v26 = try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v23.pool_id, false, arg12, arg13);
        0x1::vector::push_back<SwapAttempt>(&mut v9.attempts, v26);
        0x1::vector::push_back<SwapAttempt>(&mut v9.attempts, try_execute_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v22.pool_id, false, arg12, arg13));
        0x2::event::emit<SwapResults>(v9);
    }

    // decompiled from Move bytecode v6
}

