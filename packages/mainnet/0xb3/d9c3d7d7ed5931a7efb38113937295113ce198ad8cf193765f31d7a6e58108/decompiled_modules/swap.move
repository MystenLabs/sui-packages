module 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::swap {
    struct SwapResult has copy, drop {
        initial_price: u64,
        quantity_price: u64,
        wanted_to_swap: bool,
        not_enough_balance: bool,
        too_much_slippage: bool,
    }

    struct SwapResults has copy, drop {
        mmt_sell: SwapResult,
        mmt_buy: SwapResult,
        cetus_sell: SwapResult,
        cetus_buy: SwapResult,
    }

    struct SwapTestResult has copy, drop {
        mmt_sell: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::SwapState,
        mmt_buy: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::SwapState,
        cetus_sell: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult,
        cetus_buy: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::CalculatedSwapResult,
    }

    public fun test_swap(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, true, true, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg4);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, false, true, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg5);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg2, false, true, arg4);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg2, true, true, arg5);
        let (v4, v5, _) = 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::common::get_best_prices(arg3, arg6);
        let v7 = SwapTestResult{
            mmt_sell   : v0,
            mmt_buy    : v1,
            cetus_sell : v2,
            cetus_buy  : v3,
        };
        0x2::event::emit<SwapTestResult>(v7);
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v3), v4, v5, 0x2::clock::timestamp_ms(arg6))
    }

    fun try_cetus_buy(arg0: &0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::parameters::Parameters, arg1: &mut 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapResult {
        let v0 = SwapResult{
            initial_price      : 0,
            quantity_price     : 0,
            wanted_to_swap     : false,
            not_enough_balance : false,
            too_much_slippage  : false,
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, true, false, 1 * 1000000000);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1);
        v0.initial_price = v2;
        let v3 = 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000;
        if (v2 + v3 > arg7) {
            return v0
        };
        let v4 = 10 * 1000000000;
        let v5 = v4;
        0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg6, 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::common::convert_to_quote_at_price(arg0, v4, v2), arg8, arg9);
        let v6 = 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::common::convert_to_base_at_price(arg0, 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::common::get_available_quote_balance(arg0, arg2), v2);
        if (v4 > v6) {
            v5 = v6;
        };
        if (v5 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, true, false, v5);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v7) * 1000000000 / v5;
        v0.quantity_price = v8;
        if (v8 + v3 > arg7) {
            v0.too_much_slippage = true;
            return v0
        };
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, true, false, v5, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg8);
        let v12 = v11;
        let v13 = v9;
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v13) == 0, 13906836098488729599);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v10, arg9), arg9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v12), arg9)), 0x2::balance::zero<0x2::sui::SUI>(), v12);
        v0
    }

    fun try_cetus_sell(arg0: &0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::parameters::Parameters, arg1: &mut 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapResult {
        let v0 = SwapResult{
            initial_price      : 0,
            quantity_price     : 0,
            wanted_to_swap     : false,
            not_enough_balance : false,
            too_much_slippage  : false,
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, false, true, 1 * 1000000000);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1);
        v0.initial_price = v2;
        let v3 = 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000;
        if (v2 < arg7 + v3) {
            return v0
        };
        let v4 = 10 * 1000000000;
        let v5 = v4;
        0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg6, v4, arg8, arg9);
        let v6 = 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::common::get_available_base_balance(arg0, arg2);
        if (v4 > v6) {
            v5 = v6;
        };
        if (v5 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg4, false, true, v5);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v7) * 1000000000 / v5;
        v0.quantity_price = v8;
        if (v8 < arg7 + v3) {
            v0.too_much_slippage = true;
            return v0
        };
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, false, true, v5, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg8);
        let v12 = v11;
        let v13 = v10;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v13) == 0, 13906835668991999999);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v9, arg9), arg9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg5, arg4, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v12), arg9)), v12);
        v0
    }

    fun try_mmt_buy(arg0: &0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::parameters::Parameters, arg1: &mut 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapResult {
        let v0 = SwapResult{
            initial_price      : 0,
            quantity_price     : 0,
            wanted_to_swap     : false,
            not_enough_balance : false,
            too_much_slippage  : false,
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), 1 * 1000000000);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1);
        v0.initial_price = v2;
        let v3 = 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000;
        if (v2 + v3 > arg7) {
            return v0
        };
        let v4 = 10 * 1000000000;
        let v5 = v4;
        0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg3, arg6, 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::common::convert_to_quote_at_price(arg0, v4, v2), arg8, arg9);
        let v6 = 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::common::convert_to_base_at_price(arg0, 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::common::get_available_quote_balance(arg0, arg2), v2);
        if (v4 > v6) {
            v5 = v6;
        };
        if (v5 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        let v7 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), v5);
        let v8 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v7) * 1000000000 / v5;
        v0.quantity_price = v8;
        if (v8 + v3 > arg7) {
            v0.too_much_slippage = true;
            return v0
        };
        let (v9, v10, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, false, false, v5, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg8, arg5, arg9);
        let v12 = v11;
        let v13 = v10;
        let (v14, v15) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v12);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v13) == 0, 13906835230905335807);
        assert!(v14 == 0, 13906835235200303103);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v9, arg9), arg9);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v12, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v15, arg9)), arg5, arg9);
        v0
    }

    fun try_mmt_sell(arg0: &0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::parameters::Parameters, arg1: &mut 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapResult {
        let v0 = SwapResult{
            initial_price      : 0,
            quantity_price     : 0,
            wanted_to_swap     : false,
            not_enough_balance : false,
            too_much_slippage  : false,
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), 1 * 1000000000);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1);
        v0.initial_price = v2;
        let v3 = 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::parameters::swap_threshold_bps_times_1k(arg0) * v2 / 10000 / 1000;
        if (v2 < arg7 + v3) {
            return v0
        };
        v0.wanted_to_swap = true;
        let v4 = 10 * 1000000000;
        let v5 = v4;
        0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg3, arg6, v4, arg8, arg9);
        let v6 = 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::common::get_available_base_balance(arg0, arg2);
        if (v4 > v6) {
            v5 = v6;
        };
        if (v5 < 1 * 1000000000) {
            v0.not_enough_balance = true;
            return v0
        };
        let v7 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), v5);
        let v8 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v7) * 1000000000 / v5;
        v0.quantity_price = v8;
        if (v8 < arg7 + v3) {
            v0.too_much_slippage = true;
            return v0
        };
        let (v9, v10, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, true, true, v5, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg8, arg5, arg9);
        let v12 = v11;
        let v13 = v9;
        let (v14, v15) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v12);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v13) == 0, 13906834736984096767);
        assert!(v15 == 0, 13906834741279064063);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v10, arg9), arg9);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v12, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v14, arg9)), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), arg5, arg9);
        v0
    }

    public fun try_swap_trades(arg0: &0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::parameters::Parameters, arg1: &mut 0xb3d9c3d7d7ed5931a7efb38113937295113ce198ad8cf193765f31d7a6e58108::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = try_mmt_sell(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg9, arg10, arg11);
        let v1 = try_mmt_buy(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg9, arg10, arg11);
        let v2 = try_cetus_sell(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11);
        let v3 = SwapResults{
            mmt_sell   : v0,
            mmt_buy    : v1,
            cetus_sell : v2,
            cetus_buy  : try_cetus_buy(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11),
        };
        0x2::event::emit<SwapResults>(v3);
    }

    // decompiled from Move bytecode v6
}

