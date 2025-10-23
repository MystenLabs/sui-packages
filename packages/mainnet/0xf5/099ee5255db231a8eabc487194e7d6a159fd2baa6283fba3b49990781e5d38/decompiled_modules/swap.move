module 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::swap {
    struct SwapQuantityPriceAttempt has copy, drop {
        quantity_sui: u64,
        price: u64,
    }

    struct SwapResult has copy, drop {
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
        mmt_sell: SwapResult,
        mmt_buy: SwapResult,
        cetus_sell: SwapResult,
        cetus_buy: SwapResult,
        timestamp: u64,
    }

    struct SwapTestResult has copy, drop {
        mmt_sell: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::SwapState,
        mmt_buy: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::SwapState,
        cetus_sell: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult,
        cetus_buy: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult,
    }

    fun get_swap_price(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * (1000000000 as u128) / (arg0 as u128)) as u64)
    }

    fun get_target_quantity(arg0: &0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::Parameters, arg1: u64, arg2: u64, arg3: bool) : u64 {
        if (arg3 && arg1 >= arg2) {
            return 0
        };
        if (!arg3 && arg1 <= arg2) {
            return 0
        };
        let v0 = 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::abs_diff(arg1, arg2) * 1000 / arg2 / 10000;
        if (v0 < 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::swap_threshold_bps_times_1k(arg0)) {
            return 0
        };
        0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::swap_minimum_start_quantity(arg0) + 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::swap_step_start_quantity(arg0) * (v0 - 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::swap_threshold_bps_times_1k(arg0)) / 1000
    }

    public fun test_swap(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, true, true, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg4);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, false, true, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg5);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg2, false, true, arg4);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg2, true, true, arg5);
        let (v4, v5, _) = 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::get_best_prices(arg3, arg6);
        let v7 = SwapTestResult{
            mmt_sell   : v0,
            mmt_buy    : v1,
            cetus_sell : v2,
            cetus_buy  : v3,
        };
        0x2::event::emit<SwapTestResult>(v7);
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v3), v4, v5, 0x2::clock::timestamp_ms(arg6))
    }

    fun try_cetus_buy(arg0: &0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::Parameters, arg1: &mut 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapResult {
        let v0 = SwapResult{
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, true, false, 1 * 1000000000);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v1) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v1);
        v0.initial_price = v2;
        if (v2 + 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000 > arg7) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, true);
        let v4 = v3;
        0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg6, 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::convert_to_quote_at_price(arg0, v3, v2), arg8, arg9);
        let v5 = 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::convert_to_base_at_price(arg0, 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::get_available_quote_balance(arg0, arg2), v2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        while (v4 > 1 * 1000000000) {
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, true, false, v4);
            let v7 = get_swap_price(v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v6) - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6));
            let v8 = SwapQuantityPriceAttempt{
                quantity_sui : v4,
                price        : v7,
            };
            0x1::vector::push_back<SwapQuantityPriceAttempt>(&mut v0.quantity_price_attempts, v8);
            if (v4 > get_target_quantity(arg0, v7, arg7, true) * 2) {
                v4 = v4 / 2;
                continue
            };
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, true, false, v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg8);
            let v12 = v11;
            let v13 = v10;
            let v14 = v9;
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v12);
            assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v14) == 0, 13906836682604281855);
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

    fun try_cetus_sell(arg0: &0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::Parameters, arg1: &mut 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapResult {
        let v0 = SwapResult{
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, false, true, 1 * 1000000000);
        let v2 = get_swap_price(1 * 1000000000 - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        v0.initial_price = v2;
        if (v2 < arg7 + 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, false);
        let v4 = v3;
        0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg6, v3, arg8, arg9);
        let v5 = 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::get_available_base_balance(arg0, arg2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        while (v4 > 1 * 1000000000) {
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, false, true, v4);
            let v7 = get_swap_price(v4 - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v6));
            let v8 = SwapQuantityPriceAttempt{
                quantity_sui : v4,
                price        : v7,
            };
            0x1::vector::push_back<SwapQuantityPriceAttempt>(&mut v0.quantity_price_attempts, v8);
            if (v4 > get_target_quantity(arg0, v7, arg7, false) * 2) {
                v4 = v4 / 2;
                continue
            };
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, false, true, v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg8);
            let v12 = v11;
            let v13 = v10;
            let v14 = v9;
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v12);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v13) == 0, 13906836119963566079);
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

    fun try_mmt_buy(arg0: &0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::Parameters, arg1: &mut 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapResult {
        let v0 = SwapResult{
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), 1 * 1000000000);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1);
        v0.initial_price = v2;
        if (v2 + 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000 > arg7) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, true);
        let v4 = v3;
        0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg6, 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::convert_to_quote_at_price(arg0, v3, v2), arg8, arg9);
        let v5 = 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::convert_to_base_at_price(arg0, 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::get_available_quote_balance(arg0, arg2), v2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        while (v4 > 1 * 1000000000) {
            let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), v4);
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
            assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v13) == 0, 13906835540142981119);
            assert!(v15 == 0, 13906835544437948415);
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

    fun try_mmt_sell(arg0: &0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::Parameters, arg1: &mut 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapResult {
        let v0 = SwapResult{
            initial_price           : 0,
            not_enough_balance      : false,
            quantity_price_attempts : 0x1::vector::empty<SwapQuantityPriceAttempt>(),
            made_swap               : false,
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), 1 * 1000000000);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1);
        v0.initial_price = v2;
        if (v2 < arg7 + 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000) {
            return v0
        };
        let v3 = get_target_quantity(arg0, v2, arg7, false);
        let v4 = v3;
        0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg6, v3, arg8, arg9);
        let v5 = 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::get_available_base_balance(arg0, arg2);
        if (v3 > v5) {
            v4 = v5;
        };
        if (v4 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        while (v4 > 1 * 1000000000) {
            let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), v4);
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
            assert!(0x2::balance::value<0x2::sui::SUI>(&v14) == 0, 13906834947437494271);
            assert!(v16 == 0, 13906834951732461567);
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

    public fun try_swap_trades(arg0: &0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::Parameters, arg1: &mut 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        if (!0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::swaps_enabled(arg0)) {
            return
        };
        let (v0, v1, _) = 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::get_asset_balances(arg2, arg8);
        if (0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::common::convert_to_quote_at_price(arg0, v0, arg9) + v1 < 0xf5099ee5255db231a8eabc487194e7d6a159fd2baa6283fba3b49990781e5d38::parameters::swap_minimum_portfolio(arg0)) {
            return
        };
        let v3 = try_mmt_sell(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg9, arg10, arg11);
        let v4 = try_mmt_buy(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg9, arg10, arg11);
        let v5 = try_cetus_sell(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11);
        let v6 = SwapResults{
            mmt_sell   : v3,
            mmt_buy    : v4,
            cetus_sell : v5,
            cetus_buy  : try_cetus_buy(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11),
            timestamp  : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<SwapResults>(v6);
    }

    // decompiled from Move bytecode v6
}

