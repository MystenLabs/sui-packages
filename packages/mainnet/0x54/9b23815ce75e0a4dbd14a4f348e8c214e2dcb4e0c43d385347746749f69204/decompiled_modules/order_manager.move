module 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::order_manager {
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

    public(friend) fun adjust_maker_orders(arg0: &mut OrderManager, arg1: &0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::order_book::OrderBook, arg9: &0x2::tx_context::TxContext) {
        if (!0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_trades_enabled(arg1)) {
            return
        };
        if (arg7 >= 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_max_volatility_for_multiple_times_1k(arg1)) {
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
        let (v3, v4) = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::get_asset_balances(arg2, arg4);
        if (0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::convert_to_quote_at_price(arg1, v3, arg6) + v4 < 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_minimum_portfolio(arg1)) {
            return
        };
        let v5 = arg6 / 10000;
        let v6 = v5 * 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_shallow_place_bps_times_1k(arg1) / 1000;
        let v7 = v6;
        let v8 = v5 * 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_deep_place_bps_times_1k(arg1) / 1000;
        let v9 = v8;
        if (arg7 > 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_min_volatility_for_multiple_times_1k(arg1)) {
            let v10 = 1000 + arg7 - 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_min_volatility_for_multiple_times_1k(arg1);
            v7 = v6 * v10 / 1000;
            v9 = v8 * v10 / 1000;
        };
        let v11 = 0;
        let v12 = v9 / 4;
        ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 0, arg6 - v7, v11, true, 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_max_shallow_quantity_base(arg1), arg8, true, true, arg5, arg9);
        ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 1, arg6 + v7, v11, false, 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_max_shallow_quantity_base(arg1), arg8, true, true, arg5, arg9);
        if (0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_deep_trades_enabled(arg1)) {
            ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 2, arg6 - v9, v12, true, 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_max_deep_buy_quantity_base(arg1), arg8, false, false, arg5, arg9);
            ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, 3, arg6 + v9, v12, false, 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_max_deep_sell_quantity_base(arg1), arg8, false, false, arg5, arg9);
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

    fun ensure_maker_order_is_correct(arg0: &mut OrderManager, arg1: &0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: &0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::order_book::OrderBook, arg11: bool, arg12: bool, arg13: &0x2::clock::Clock, arg14: &0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
        if (arg11) {
            arg6 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::order_book::get_dimed_price(arg10, arg1, arg6, arg8, v0);
        };
        let v3 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, arg5);
        if (0x1::option::is_some<BasicOrder>(v3)) {
            let v4 = 0x1::option::borrow<BasicOrder>(v3);
            if (v4.price >= arg6 - arg7 && v4.price <= arg6 + arg7) {
                let v5 = v4.expiry_timestamp;
                if (v5 > 0x2::clock::timestamp_ms(arg13) && v5 - 0x2::clock::timestamp_ms(arg13) > 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_order_ttl_ms(arg1) / 2) {
                    return
                };
            };
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, v4.order_id, arg13, arg14);
            0x1::option::extract<BasicOrder>(v3);
        };
        if (0x2::tx_context::gas_price(arg14) > 3000) {
            return
        };
        if (arg8) {
            let v6 = arg9;
            if (arg12) {
                try_ensure_available_quote_balance(arg0, arg1, arg2, arg4, arg3, 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::convert_to_quote_at_price(arg1, arg9, arg6), arg13, arg14);
            };
            let v7 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::convert_to_base_at_price(arg1, 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::get_available_quote_balance(arg1, arg2), arg6);
            if (arg9 > v7) {
                v6 = v7;
            };
            let v8 = arg6 / v0 * v0;
            let v9 = v8;
            let v10 = v6 / v1 * v1;
            if (v8 >= 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::order_book::best_ask(arg10)) {
                v9 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::order_book::best_ask(arg10) - v0;
            };
            if (v10 < v2) {
                return
            };
            if (v9 > 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maximum_buy_price_quote(arg1)) {
                return
            };
            let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v9, v10, true, false, 0x2::clock::timestamp_ms(arg13) + 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_order_ttl_ms(arg1), arg13, arg14);
            0x1::option::fill<BasicOrder>(0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, arg5), basic_order_from_order_info(&v11));
        } else {
            let v12 = arg9;
            if (arg12) {
                try_ensure_available_base_balance(arg0, arg1, arg2, arg4, arg3, arg9, arg13, arg14);
            };
            let v13 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::get_available_base_balance(arg1, arg2);
            if (arg9 > v13) {
                v12 = v13;
            };
            let v14 = (arg6 + v0 - 1) / v0 * v0;
            let v15 = v14;
            let v16 = v12 / v1 * v1;
            if (v14 <= 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::order_book::best_bid(arg10)) {
                v15 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::order_book::best_bid(arg10) + v0;
            };
            if (v16 < v2) {
                return
            };
            if (v15 < 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::minimum_sell_price_quote(arg1)) {
                return
            };
            let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v15, v16, false, false, 0x2::clock::timestamp_ms(arg13) + 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::maker_order_ttl_ms(arg1), arg13, arg14);
            0x1::option::fill<BasicOrder>(0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, arg5), basic_order_from_order_info(&v17));
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
            let v5 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::ensure_multiple_round_down(v1 - arg4, v3);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::modify_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, v0.order_id, v5, arg5, arg6);
            v0.full_quantity = v5;
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, v0.order_id, arg5, arg6);
            0x1::option::extract<BasicOrder>(arg3);
        };
    }

    public(friend) fun try_ensure_available_base_balance(arg0: &mut OrderManager, arg1: &0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::get_available_base_balance(arg1, arg2);
        if (arg5 <= v0) {
            return
        };
        let v1 = arg5 - v0;
        arg5 = v1;
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 3))) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, 3);
            reduce_or_cancel_order(arg2, arg3, arg4, v2, v1, arg6, arg7);
            let v3 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::get_available_base_balance(arg1, arg2);
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

    public(friend) fun try_ensure_available_quote_balance(arg0: &mut OrderManager, arg1: &0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::get_available_quote_balance(arg1, arg2);
        if (arg5 <= v0) {
            return
        };
        let v1 = arg5 - v0;
        arg5 = v1;
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 2))) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, 2);
            let v3 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::convert_to_base_at_price(arg1, v1, 0x1::option::borrow<BasicOrder>(v2).price);
            reduce_or_cancel_order(arg2, arg3, arg4, v2, v3, arg6, arg7);
            let v4 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::get_available_quote_balance(arg1, arg2);
            if (v1 <= v4) {
                return
            };
            arg5 = v1 - v4;
        };
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 0))) {
            let v5 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, 0);
            let v6 = 0x549b23815ce75e0a4dbd14a4f348e8c214e2dcb4e0c43d385347746749f69204::common::convert_to_base_at_price(arg1, arg5, 0x1::option::borrow<BasicOrder>(v5).price);
            reduce_or_cancel_order(arg2, arg3, arg4, v5, v6, arg6, arg7);
        };
    }

    // decompiled from Move bytecode v6
}

