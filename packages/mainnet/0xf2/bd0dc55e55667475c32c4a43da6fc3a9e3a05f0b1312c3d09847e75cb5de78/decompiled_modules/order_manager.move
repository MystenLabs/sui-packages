module 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::order_manager {
    struct BasicOrder has drop {
        order_id: u128,
        price: u64,
        full_quantity: u64,
        filled_quantity: u64,
        expiry_timestamp: u64,
    }

    struct OrderManager has drop {
        orders: vector<0x1::option::Option<BasicOrder>>,
    }

    public(friend) fun adjust_maker_orders(arg0: &mut OrderManager, arg1: &0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::order_book::OrderBook, arg9: &0x2::tx_context::TxContext) {
        if (!0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_trades_enabled(arg1)) {
            return
        };
        if (arg7 >= 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_max_volatility_for_multiple_times_1k(arg1)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg2, arg3, arg5, arg9);
            let v0 = &mut arg0.orders;
            let v1 = 0;
            while (v1 < 0x1::vector::length<0x1::option::Option<BasicOrder>>(v0)) {
                let v2 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(v0, v1);
                if (0x1::option::is_some<BasicOrder>(v2)) {
                    0x1::option::extract<BasicOrder>(v2);
                };
                v1 = v1 + 1;
            };
            return
        };
        let (v3, v4, _) = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::get_asset_balances(arg2, arg4);
        if (0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::convert_to_quote_at_price(arg1, v3, arg6) + v4 < 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_minimum_portfolio(arg1)) {
            return
        };
        let v6 = arg6 / 10000;
        let v7 = v6 * 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_shallow_place_bps_times_1k(arg1) / 1000;
        let v8 = v7;
        let v9 = v6 * 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_deep_place_bps_times_1k(arg1) / 1000;
        let v10 = v9;
        if (arg7 > 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_min_volatility_for_multiple_times_1k(arg1)) {
            let v11 = 10000 + 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_volatility_multiplier_factor_times_10(arg1) * (arg7 - 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_min_volatility_for_multiple_times_1k(arg1));
            v8 = v7 * v11 / 10000;
            v10 = v9 * v11 / 10000;
        };
        let v12 = 0;
        let v13 = v10 / 4;
        ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 0, arg6 - v8, v12, true, 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_minimum_shallow_quantity_base(arg1), 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_step_shallow_quantity_base(arg1), arg8, true, true, arg5, arg9);
        ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 1, arg6 + v8, v12, false, 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_minimum_shallow_quantity_base(arg1), 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_step_shallow_quantity_base(arg1), arg8, true, true, arg5, arg9);
        if (0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_deep_trades_enabled(arg1)) {
            ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 2, arg6 - v10, v13, true, 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_max_deep_buy_quantity_base(arg1), 0, arg8, true, false, arg5, arg9);
            ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 3, arg6 + v10, v13, false, 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_max_deep_sell_quantity_base(arg1), 0, arg8, true, false, arg5, arg9);
        };
    }

    fun basic_order_from_order(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order) : BasicOrder {
        BasicOrder{
            order_id         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(arg0),
            price            : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(arg0),
            full_quantity    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(arg0),
            filled_quantity  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(arg0),
            expiry_timestamp : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(arg0),
        }
    }

    fun basic_order_from_order_info(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) : BasicOrder {
        BasicOrder{
            order_id         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(arg0),
            price            : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::price(arg0),
            full_quantity    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(arg0),
            filled_quantity  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg0),
            expiry_timestamp : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::expire_timestamp(arg0),
        }
    }

    public(friend) fun create_order_manager(arg0: vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>, arg1: &0x2::clock::Clock) : OrderManager {
        let v0 = 0x1::vector::empty<0x1::option::Option<BasicOrder>>();
        let v1 = 0;
        while (v1 < 4) {
            0x1::vector::push_back<0x1::option::Option<BasicOrder>>(&mut v0, 0x1::option::none<BasicOrder>());
            v1 = v1 + 1;
        };
        while (!0x1::vector::is_empty<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&arg0)) {
            let v2 = 0x1::vector::pop_back<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&mut arg0);
            if (0x2::clock::timestamp_ms(arg1) > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(&v2)) {
                continue
            };
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(&v2) < 4) {
                0x1::option::fill<BasicOrder>(0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(&v2)), basic_order_from_order(&v2));
            };
        };
        OrderManager{orders: v0}
    }

    fun ensure_maker_order_is_correct(arg0: &mut OrderManager, arg1: &0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: &0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::order_book::OrderBook, arg12: bool, arg13: bool, arg14: &0x2::clock::Clock, arg15: &0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
        let v3 = arg6;
        if (arg12) {
            v3 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::order_book::get_dimed_price(arg11, arg1, arg6, arg8, v0);
        };
        let v4 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, arg5);
        if (0x1::option::is_some<BasicOrder>(v4)) {
            let v5 = 0x1::option::borrow<BasicOrder>(v4);
            if (v5.price >= v3 - arg7 && v5.price <= v3 + arg7) {
                let v6 = v5.expiry_timestamp;
                if (v6 > 0x2::clock::timestamp_ms(arg14) && v6 - 0x2::clock::timestamp_ms(arg14) > 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_order_ttl_ms(arg1) / 2) {
                    return
                };
            };
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, v5.order_id, arg14, arg15);
            0x1::option::extract<BasicOrder>(v4);
        };
        if (0x2::tx_context::gas_price(arg15) > 3000) {
            return
        };
        let v7 = arg9 + 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::abs_diff(arg6, v3) * 1000 / v3 / 10000 * arg10 / 1000;
        let v8 = v7;
        if (arg8) {
            if (arg13) {
                try_ensure_available_quote_balance(arg0, arg1, arg2, arg4, arg3, 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::convert_to_quote_at_price(arg1, v7, v3), arg14, arg15);
            };
            let v9 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::convert_to_base_at_price(arg1, 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::get_available_quote_balance(arg1, arg2), v3);
            if (v7 > v9) {
                v8 = v9;
            };
            let v10 = v3 / v0 * v0;
            let v11 = v10;
            let v12 = v8 / v1 * v1;
            let v13 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::get_best_ask(arg3, arg14);
            if (v10 >= v13) {
                v11 = v13 - v0;
            };
            if (v12 < v2) {
                return
            };
            if (v11 > 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maximum_buy_price_quote(arg1)) {
                return
            };
            let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v11, v12, true, false, 0x2::clock::timestamp_ms(arg14) + 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_order_ttl_ms(arg1), arg14, arg15);
            0x1::option::fill<BasicOrder>(0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, arg5), basic_order_from_order_info(&v14));
        } else {
            if (arg13) {
                try_ensure_available_base_balance(arg0, arg1, arg2, arg4, arg3, v7, arg14, arg15);
            };
            let v15 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::get_available_base_balance(arg1, arg2);
            if (v7 > v15) {
                v8 = v15;
            };
            let v16 = (v3 + v0 - 1) / v0 * v0;
            let v17 = v16;
            let v18 = v8 / v1 * v1;
            let v19 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::get_best_bid(arg3, arg14);
            if (v16 <= v19) {
                v17 = v19 + v0;
            };
            if (v18 < v2) {
                return
            };
            if (v17 < 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::minimum_sell_price_quote(arg1)) {
                return
            };
            let v20 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v17, v18, false, false, 0x2::clock::timestamp_ms(arg14) + 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::maker_order_ttl_ms(arg1), arg14, arg15);
            0x1::option::fill<BasicOrder>(0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, arg5), basic_order_from_order_info(&v20));
        };
    }

    fun reduce_or_cancel_order(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x1::option::Option<BasicOrder>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<BasicOrder>(arg3), 13906834633904881663);
        let v0 = 0x1::option::borrow_mut<BasicOrder>(arg3);
        if (0x2::clock::timestamp_ms(arg5) > v0.expiry_timestamp) {
            return
        };
        let v1 = v0.full_quantity - v0.filled_quantity;
        let (_, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        if (v1 > arg4 + v4 + v3) {
            let v5 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::ensure_multiple_round_down(v1 - arg4, v3);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::modify_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, v0.order_id, v5, arg5, arg6);
            v0.full_quantity = v5;
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, v0.order_id, arg5, arg6);
            0x1::option::extract<BasicOrder>(arg3);
        };
    }

    public(friend) fun try_ensure_available_base_balance(arg0: &mut OrderManager, arg1: &0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::get_available_base_balance(arg1, arg2);
        if (arg5 <= v0) {
            return
        };
        let v1 = arg5 - v0;
        arg5 = v1;
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 3))) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, 3);
            reduce_or_cancel_order(arg2, arg3, arg4, v2, v1, arg6, arg7);
            let v3 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::get_available_base_balance(arg1, arg2);
            if (v1 <= v3) {
                return
            };
            arg5 = v1 - v3;
        };
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 1))) {
            let v4 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, 1);
            reduce_or_cancel_order(arg2, arg3, arg4, v4, arg5, arg6, arg7);
        };
    }

    public(friend) fun try_ensure_available_quote_balance(arg0: &mut OrderManager, arg1: &0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::get_available_quote_balance(arg1, arg2);
        if (arg5 <= v0) {
            return
        };
        let v1 = arg5 - v0;
        arg5 = v1;
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 2))) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, 2);
            let v3 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::convert_to_base_at_price(arg1, v1, 0x1::option::borrow<BasicOrder>(v2).price);
            reduce_or_cancel_order(arg2, arg3, arg4, v2, v3, arg6, arg7);
            let v4 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::get_available_quote_balance(arg1, arg2);
            if (v1 <= v4) {
                return
            };
            arg5 = v1 - v4;
        };
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 0))) {
            let v5 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, 0);
            let v6 = 0xf2bd0dc55e55667475c32c4a43da6fc3a9e3a05f0b1312c3d09847e75cb5de78::common::convert_to_base_at_price(arg1, arg5, 0x1::option::borrow<BasicOrder>(v5).price);
            reduce_or_cancel_order(arg2, arg3, arg4, v5, v6, arg6, arg7);
        };
    }

    // decompiled from Move bytecode v6
}

