module 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::order_manager {
    struct Order has drop, store {
        is_active: bool,
        order_id: u128,
        price: u64,
        expiry_timestamp: u64,
    }

    struct OrderManager has drop, store {
        orders: vector<Order>,
    }

    public(friend) fun adjust_maker_orders(arg0: &mut OrderManager, arg1: &0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: &vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>, arg7: u64, arg8: u64, arg9: &0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::order_book::OrderBook, arg10: &0x2::tx_context::TxContext) {
        if (!0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_trades_enabled(arg1)) {
            return
        };
        if (arg8 >= 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_max_volatility_for_multiple_times_1k(arg1)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg2, arg3, arg5, arg10);
            return
        };
        let (v0, v1) = 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::get_asset_balances(arg2, arg4);
        if (0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::convert_to_quote_at_price(arg1, v0, arg7) + v1 < 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_minimum_portfolio(arg1)) {
            return
        };
        0x1::vector::borrow_mut<Order>(&mut arg0.orders, 0).is_active = false;
        0x1::vector::borrow_mut<Order>(&mut arg0.orders, 1).is_active = false;
        0x1::vector::borrow_mut<Order>(&mut arg0.orders, 2).is_active = false;
        0x1::vector::borrow_mut<Order>(&mut arg0.orders, 3).is_active = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(arg6)) {
            let v3 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(arg6, v2);
            v2 = v2 + 1;
            if (0x2::clock::timestamp_ms(arg5) > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v3)) {
                return
            };
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(v3) < 4) {
                0x1::vector::borrow_mut<Order>(&mut arg0.orders, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(v3)).is_active = true;
                continue
            };
        };
        let v4 = arg7 / 10000;
        let v5 = v4 * 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_shallow_place_bps_times_1k(arg1) / 1000;
        let v6 = v5;
        let v7 = v4 * 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_deep_place_bps_times_1k(arg1) / 1000;
        let v8 = v7;
        if (arg8 > 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_min_volatility_for_multiple_times_1k(arg1)) {
            let v9 = 1000 + arg8 - 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_min_volatility_for_multiple_times_1k(arg1);
            v6 = v5 * v9 / 1000;
            v8 = v7 * v9 / 1000;
        };
        let v10 = 0;
        let v11 = v8 / 4;
        ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 0, arg7 - v6, v10, true, 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_max_shallow_quantity_base(arg1), arg9, true, arg5, arg10);
        ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 1, arg7 + v6, v10, false, 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_max_shallow_quantity_base(arg1), arg9, true, arg5, arg10);
        if (0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_deep_trades_enabled(arg1)) {
            ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 2, arg7 - v8, v11, true, 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_max_deep_buy_quantity_base(arg1), arg9, false, arg5, arg10);
            ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 3, arg7 + v8, v11, false, 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_max_deep_sell_quantity_base(arg1), arg9, false, arg5, arg10);
        };
    }

    fun ensure_maker_order_is_correct(arg0: &mut OrderManager, arg1: &0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: &0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::order_book::OrderBook, arg11: bool, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
        if (arg11) {
            arg6 = 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::order_book::get_dimed_price(arg10, arg1, arg6, arg8, v0);
        };
        let v3 = 0x1::vector::borrow_mut<Order>(&mut arg0.orders, arg5);
        if (v3.is_active) {
            if (v3.price >= arg6 - arg7 && v3.price <= arg6 + arg7) {
                let v4 = v3.expiry_timestamp;
                if (v4 > 0x2::clock::timestamp_ms(arg12) && v4 - 0x2::clock::timestamp_ms(arg12) > 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_order_ttl_ms(arg1) / 2) {
                    return
                };
            };
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, v3.order_id, arg12, arg13);
            v3.is_active = false;
        };
        if (0x2::tx_context::gas_price(arg13) > 3000) {
            return
        };
        if (arg8) {
            let v5 = arg9;
            try_ensure_available_quote_balance(arg0, arg1, arg2, arg4, arg3, 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::convert_to_quote_at_price(arg1, arg9, arg6), arg12, arg13);
            let v6 = 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::convert_to_base_at_price(arg1, 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::get_available_quote_balance(arg1, arg2), arg6);
            if (arg9 > v6) {
                v5 = v6;
            };
            let v7 = arg6 / v0 * v0;
            let v8 = v7;
            let v9 = v5 / v1 * v1;
            if (v7 >= 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::order_book::best_ask(arg10)) {
                v8 = 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::order_book::best_ask(arg10) - v0;
            };
            if (v9 < v2) {
                return
            };
            if (v8 > 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maximum_buy_price_quote(arg1)) {
                return
            };
            let v10 = 0x2::clock::timestamp_ms(arg12) + 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_order_ttl_ms(arg1);
            let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v8, v9, true, false, v10, arg12, arg13);
            let v12 = Order{
                is_active        : true,
                order_id         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v11),
                price            : v8,
                expiry_timestamp : v10,
            };
            *0x1::vector::borrow_mut<Order>(&mut arg0.orders, arg5) = v12;
        } else {
            let v13 = arg9;
            try_ensure_available_base_balance(arg0, arg1, arg2, arg4, arg3, arg9, arg12, arg13);
            let v14 = 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::get_available_base_balance(arg1, arg2);
            if (arg9 > v14) {
                v13 = v14;
            };
            let v15 = (arg6 + v0 - 1) / v0 * v0;
            let v16 = v15;
            let v17 = v13 / v1 * v1;
            if (v15 <= 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::order_book::best_bid(arg10)) {
                v16 = 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::order_book::best_bid(arg10) + v0;
            };
            if (v17 < v2) {
                return
            };
            if (v16 < 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::minimum_sell_price_quote(arg1)) {
                return
            };
            let v18 = 0x2::clock::timestamp_ms(arg12) + 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::maker_order_ttl_ms(arg1);
            let v19 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v16, v17, false, false, v18, arg12, arg13);
            let v20 = Order{
                is_active        : true,
                order_id         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v19),
                price            : v16,
                expiry_timestamp : v18,
            };
            *0x1::vector::borrow_mut<Order>(&mut arg0.orders, arg5) = v20;
        };
    }

    public(friend) fun new_order_manager() : OrderManager {
        let v0 = 0x1::vector::empty<Order>();
        let v1 = 0;
        while (v1 < 4) {
            let v2 = Order{
                is_active        : false,
                order_id         : 0,
                price            : 0,
                expiry_timestamp : 0,
            };
            0x1::vector::push_back<Order>(&mut v0, v2);
            v1 = v1 + 1;
        };
        OrderManager{orders: v0}
    }

    fun reduce_or_cancel_order(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut Order, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg3.is_active, 13906834487875993599);
        if (0x2::clock::timestamp_ms(arg5) > arg3.expiry_timestamp) {
            return
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg3.order_id);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v0) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v0);
        let (_, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        if (v1 > arg4 + v4 + v3) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::modify_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, arg3.order_id, 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::ensure_multiple_round_down(v1 - arg4, v3), arg5, arg6);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, arg3.order_id, arg5, arg6);
            arg3.is_active = false;
        };
    }

    public(friend) fun try_ensure_available_base_balance(arg0: &mut OrderManager, arg1: &0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::get_available_base_balance(arg1, arg2);
        if (arg5 <= v0) {
            return
        };
        let v1 = arg5 - v0;
        arg5 = v1;
        if (0x1::vector::borrow<Order>(&arg0.orders, 3).is_active) {
            let v2 = 0x1::vector::borrow_mut<Order>(&mut arg0.orders, 3);
            reduce_or_cancel_order(arg2, arg3, arg4, v2, v1, arg6, arg7);
            let v3 = 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::get_available_base_balance(arg1, arg2);
            if (v1 <= v3) {
                return
            };
            arg5 = v1 - v3;
        };
        if (0x1::vector::borrow<Order>(&arg0.orders, 1).is_active) {
            let v4 = 0x1::vector::borrow_mut<Order>(&mut arg0.orders, 1);
            reduce_or_cancel_order(arg2, arg3, arg4, v4, arg5, arg6, arg7);
        };
    }

    public(friend) fun try_ensure_available_quote_balance(arg0: &mut OrderManager, arg1: &0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::get_available_quote_balance(arg1, arg2);
        if (arg5 <= v0) {
            return
        };
        let v1 = arg5 - v0;
        arg5 = v1;
        if (0x1::vector::borrow<Order>(&arg0.orders, 2).is_active) {
            let v2 = 0x1::vector::borrow_mut<Order>(&mut arg0.orders, 2);
            reduce_or_cancel_order(arg2, arg3, arg4, v2, 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::convert_to_base_at_price(arg1, v1, 0x1::vector::borrow_mut<Order>(&mut arg0.orders, 2).price), arg6, arg7);
            let v3 = 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::get_available_quote_balance(arg1, arg2);
            if (v1 <= v3) {
                return
            };
            arg5 = v1 - v3;
        };
        if (0x1::vector::borrow<Order>(&arg0.orders, 0).is_active) {
            let v4 = 0x1::vector::borrow_mut<Order>(&mut arg0.orders, 0);
            reduce_or_cancel_order(arg2, arg3, arg4, v4, 0xf4048f2d63fe581056f200fcd343c1ab0fc059a5e94255eeee76c509e490b1ae::common::convert_to_base_at_price(arg1, arg5, 0x1::vector::borrow_mut<Order>(&mut arg0.orders, 0).price), arg6, arg7);
        };
    }

    // decompiled from Move bytecode v6
}

