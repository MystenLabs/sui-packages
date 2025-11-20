module 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::taker {
    struct CouldNotTradeEvent has copy, drop {
        reason: 0x1::string::String,
    }

    struct ToppedUpDeepEvent has copy, drop {
        quantity_deep: u64,
        quantity_usdc: u64,
    }

    public(friend) fun emit_could_not_trade_event(arg0: vector<u8>) {
        let v0 = CouldNotTradeEvent{reason: 0x1::string::utf8(arg0)};
        0x2::event::emit<CouldNotTradeEvent>(v0);
    }

    fun ensure_deep_balance(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0);
        if (v0 >= arg3) {
            return
        };
        let v1 = (arg3 - v0) * 2;
        let v2 = v1;
        if (v1 < 10 * 1000000) {
            v2 = 10 * 1000000;
        };
        let (_, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        let v6 = v2 / v4 * v4;
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v6, true, false, arg4, arg5);
        let v8 = ToppedUpDeepEvent{
            quantity_deep : v6,
            quantity_usdc : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v7),
        };
        0x2::event::emit<ToppedUpDeepEvent>(v8);
    }

    public(friend) fun try_make_taker_trade(arg0: &0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::Parameters, arg1: &mut 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::OrderManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x2::clock::Clock, arg7: u64, arg8: bool, arg9: &0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_book::OrderBook, arg10: &mut u64, arg11: &0x2::tx_context::TxContext) {
        let v0 = arg7 * 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::trigger_bps_times_1k(arg0) / 1000 / 10000;
        if (arg8 && 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_book::best_ask(arg9) + v0 < arg7) {
            let (v1, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
            let v4 = (arg7 - v0) / v1 * v1;
            let v5 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::skew_quantity_based_on_position(arg1, arg0, arg2, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::taker_minimum_order_size_base(arg0) + 1000000 * (arg7 - 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_book::best_ask(arg9) - v0) / 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_book::best_ask(arg9) * 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::taker_order_size_step_base(arg0) / 100, true);
            let v6 = v5;
            0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::try_ensure_available_quote_balance(arg1, arg0, arg2, arg4, arg3, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_quote_at_price(arg0, v5, v4), arg6, arg11);
            let v7 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_base_at_price(arg0, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::get_available_quote_balance(arg0, arg2), v4);
            let v8 = v7;
            let v9 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::convert_to_base_at_price(arg0, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::position_limit_quote(arg0), v4);
            let v10 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::get_available_base_balance(arg0, arg2);
            if (v10 >= v9) {
                v8 = 0;
            } else {
                let v11 = v9 - v10;
                if (v7 > v11) {
                    v8 = v11;
                };
            };
            if (v5 > v8) {
                v6 = v8;
            };
            let v12 = v6 / v2 * v2;
            if (v12 < 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::taker_minimum_order_size_base(arg0)) {
                emit_could_not_trade_event(b"at_limit");
                return
            };
            if (v4 > 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::maximum_buy_price_quote(arg0)) {
                emit_could_not_trade_event(b"price_limit");
                return
            };
            if (0x2::clock::timestamp_ms(arg6) < *arg10 + 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::cooldown_ms(arg0)) {
                emit_could_not_trade_event(b"within_cooldown");
                return
            };
            if (!0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::allowed_to_buy(arg0)) {
                emit_could_not_trade_event(b"not_allowed");
                return
            };
            let (v13, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v12, v4);
            ensure_deep_balance(arg2, arg4, arg5, v13 * 2, arg6, arg11);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v4, v12, true, true, 0x2::clock::timestamp_ms(arg6) + 1000, arg6, arg11);
            *arg10 = 0x2::clock::timestamp_ms(arg6);
        };
        if (!arg8 && arg7 + v0 < 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_book::best_bid(arg9)) {
            let (v15, v16, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
            let v18 = (arg7 + v0 + v15 - 1) / v15 * v15;
            let v19 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::skew_quantity_based_on_position(arg1, arg0, arg2, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::taker_minimum_order_size_base(arg0) + 1000000 * (0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_book::best_bid(arg9) - v0 - arg7) / 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_book::best_ask(arg9) * 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::taker_order_size_step_base(arg0) / 100, false);
            let v20 = v19;
            0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::try_ensure_available_base_balance(arg1, arg0, arg2, arg4, arg3, v19, arg6, arg11);
            let v21 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::get_available_base_balance(arg0, arg2);
            if (v19 > v21) {
                v20 = v21;
            };
            let v22 = v20 / v16 * v16;
            if (v22 < 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::taker_minimum_order_size_base(arg0)) {
                emit_could_not_trade_event(b"at_limit");
                return
            };
            if (v18 < 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::minimum_sell_price_quote(arg0)) {
                emit_could_not_trade_event(b"price_limit");
                return
            };
            if (0x2::clock::timestamp_ms(arg6) < *arg10 + 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::cooldown_ms(arg0)) {
                emit_could_not_trade_event(b"within_cooldown");
                return
            };
            let (v23, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order_deep_required<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v22, v18);
            ensure_deep_balance(arg2, arg4, arg5, v23, arg6, arg11);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v18, v22, false, true, 0x2::clock::timestamp_ms(arg6) + 1000, arg6, arg11);
            *arg10 = 0x2::clock::timestamp_ms(arg6);
        };
    }

    // decompiled from Move bytecode v6
}

