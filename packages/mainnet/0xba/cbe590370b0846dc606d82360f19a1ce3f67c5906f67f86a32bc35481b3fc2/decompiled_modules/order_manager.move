module 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_manager {
    struct BasicOrder has drop {
        order_id: u128,
        price: u64,
        full_quantity: u64,
        filled_quantity: u64,
        expiry_timestamp: u64,
    }

    struct OrderManager has drop {
        orders: vector<0x1::option::Option<BasicOrder>>,
        best_bid_on_all_orders_except_ours: u64,
        best_ask_on_all_orders_except_ours: u64,
        fully_long_base_amount: u64,
    }

    public(friend) fun adjust_maker_orders(arg0: &mut OrderManager, arg1: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::OpenPoolPositions, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg12: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg16: &0x2::clock::Clock, arg17: u64, arg18: u64, arg19: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_book::OrderBook, arg20: &mut 0x2::tx_context::TxContext) {
        if (!0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_trades_enabled(arg1)) {
            return
        };
        if (arg18 >= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_max_volatility_for_multiple_times_1k(arg1)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg2, arg3, arg16, arg20);
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
        let v3 = arg17 / 10000;
        let v4 = v3 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_shallow_place_bps_times_1k(arg1) / 1000;
        let v5 = v4;
        let v6 = v3 * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_deep_place_bps_times_1k(arg1) / 1000;
        let v7 = v6;
        if (arg18 > 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_min_volatility_for_multiple_times_1k(arg1)) {
            let v8 = 10000 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_volatility_multiplier_factor_times_10(arg1) * (arg18 - 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_min_volatility_for_multiple_times_1k(arg1));
            v5 = v4 * v8 / 10000;
            v7 = v6 * v8 / 10000;
        };
        let v9 = 0;
        let v10 = v7 / 4;
        ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0, arg17 - v5, v9, true, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_minimum_shallow_quantity_base(arg1), 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_step_shallow_quantity_base(arg1), arg19, true, true, arg16, arg20);
        ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 1, arg17 + v5, v9, false, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_minimum_shallow_quantity_base(arg1), 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_step_shallow_quantity_base(arg1), arg19, true, true, arg16, arg20);
        if (0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_deep_trades_enabled(arg1)) {
            ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 2, arg17 - v7, v10, true, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_max_deep_buy_quantity_base(arg1), 0, arg19, true, false, arg16, arg20);
            ensure_maker_order_is_correct(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 3, arg17 + v7, v10, false, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_max_deep_sell_quantity_base(arg1), 0, arg19, true, false, arg16, arg20);
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

    public(friend) fun create_order_manager(arg0: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>, arg3: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_book::OrderBook, arg4: u64, arg5: &0x2::clock::Clock) : OrderManager {
        let v0 = 0x1::vector::empty<0x1::option::Option<BasicOrder>>();
        let v1 = 0;
        while (v1 < 4) {
            0x1::vector::push_back<0x1::option::Option<BasicOrder>>(&mut v0, 0x1::option::none<BasicOrder>());
            v1 = v1 + 1;
        };
        while (!0x1::vector::is_empty<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&arg2)) {
            let v2 = 0x1::vector::pop_back<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&mut arg2);
            if (0x2::clock::timestamp_ms(arg5) > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(&v2)) {
                continue
            };
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(&v2) < 4) {
                0x1::option::fill<BasicOrder>(0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(&v2)), basic_order_from_order(&v2));
            };
        };
        let v3 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg0, arg1);
        let v4 = 0;
        while (v4 < 4) {
            if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&v0, v4))) {
                let v5 = 0x1::option::borrow<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&v0, v4));
                let v6 = v3 + v5.full_quantity;
                v3 = v6 - v5.filled_quantity;
            };
            v4 = v4 + 1;
        };
        OrderManager{
            orders                             : v0,
            best_bid_on_all_orders_except_ours : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_book::best_bid_on_all_orders_except_ours(arg3),
            best_ask_on_all_orders_except_ours : 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_book::best_ask_on_all_orders_except_ours(arg3),
            fully_long_base_amount             : v3 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_base_at_price(arg0, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg0, arg1), arg4),
        }
    }

    fun ensure_maker_order_is_correct(arg0: &mut OrderManager, arg1: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg5: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::OpenPoolPositions, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg12: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg16: u64, arg17: u64, arg18: u64, arg19: bool, arg20: u64, arg21: u64, arg22: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_book::OrderBook, arg23: bool, arg24: bool, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
        let v3 = arg17;
        if (arg23) {
            v3 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::order_book::get_dimed_price(arg22, arg1, arg17, arg19, v0);
        };
        let v4 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, arg16);
        if (0x1::option::is_some<BasicOrder>(v4)) {
            let v5 = 0x1::option::borrow<BasicOrder>(v4);
            if (v5.price >= v3 - arg18 && v5.price <= v3 + arg18) {
                let v6 = v5.expiry_timestamp;
                if (v6 > 0x2::clock::timestamp_ms(arg25) && v6 - 0x2::clock::timestamp_ms(arg25) > 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_order_ttl_ms(arg1) / 2) {
                    return
                };
            };
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, v5.order_id, arg25, arg26);
            0x1::option::extract<BasicOrder>(v4);
        };
        if (0x2::tx_context::gas_price(arg26) > 3000) {
            return
        };
        let v7 = skew_quantity_based_on_position(arg0, arg1, arg2, arg20 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::abs_diff(arg17, v3) * 1000 / v3 / 10000 * arg21 / 1000, arg19);
        let v8 = v7;
        if (arg19) {
            if (arg24) {
                try_ensure_available_quote_balance(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_quote_at_price(arg1, v7, v3), arg25, arg26);
            };
            let v9 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_base_at_price(arg1, 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg1, arg2), v3);
            if (v7 > v9) {
                v8 = v9;
            };
            let v10 = v3 / v0 * v0;
            let v11 = v10;
            let v12 = v8 / v1 * v1;
            if (v12 < v2) {
                return
            };
            let v13 = get_best_ask_on_all_orders(arg0);
            if (v10 >= v13) {
                v11 = v13 - v0;
            };
            if (v11 > 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maximum_buy_price_quote(arg1)) {
                return
            };
            let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg16, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v11, v12, true, false, 0x2::clock::timestamp_ms(arg25) + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_order_ttl_ms(arg1), arg25, arg26);
            0x1::option::fill<BasicOrder>(0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, arg16), basic_order_from_order_info(&v14));
        } else {
            if (arg24) {
                try_ensure_available_base_balance(arg0, arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, v7, arg25, arg26);
            };
            let v15 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg1, arg2);
            if (v7 > v15) {
                v8 = v15;
            };
            let v16 = (v3 + v0 - 1) / v0 * v0;
            let v17 = v16;
            let v18 = v8 / v1 * v1;
            if (v18 < v2) {
                return
            };
            let v19 = get_best_bid_on_all_orders(arg0);
            if (v16 <= v19) {
                v17 = v19 + v0;
            };
            if (v17 < 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::minimum_sell_price_quote(arg1)) {
                return
            };
            let v20 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4, arg16, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_maker(), v17, v18, false, false, 0x2::clock::timestamp_ms(arg25) + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::maker_order_ttl_ms(arg1), arg25, arg26);
            0x1::option::fill<BasicOrder>(0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, arg16), basic_order_from_order_info(&v20));
        };
    }

    public(friend) fun get_base_balance_including_open_asks(arg0: &OrderManager, arg1: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        let v0 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg1, arg2);
        let v1 = v0;
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 1))) {
            let v2 = 0x1::option::borrow<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 1));
            v1 = v0 + v2.full_quantity - v2.filled_quantity;
        };
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 3))) {
            let v3 = 0x1::option::borrow<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 3));
            let v4 = v1 + v3.full_quantity;
            v1 = v4 - v3.filled_quantity;
        };
        v1
    }

    public(friend) fun get_best_ask_on_all_orders(arg0: &OrderManager) : u64 {
        let v0 = arg0.best_ask_on_all_orders_except_ours;
        let v1 = v0;
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 1))) {
            let v2 = 0x1::option::borrow<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 1)).price;
            if (v2 < v0) {
                v1 = v2;
            };
        };
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 3))) {
            let v3 = 0x1::option::borrow<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 3)).price;
            if (v3 < v1) {
                v1 = v3;
            };
        };
        v1
    }

    public(friend) fun get_best_bid_on_all_orders(arg0: &OrderManager) : u64 {
        let v0 = arg0.best_bid_on_all_orders_except_ours;
        let v1 = v0;
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 0))) {
            let v2 = 0x1::option::borrow<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 0)).price;
            if (v2 > v0) {
                v1 = v2;
            };
        };
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 2))) {
            let v3 = 0x1::option::borrow<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 2)).price;
            if (v3 > v1) {
                v1 = v3;
            };
        };
        v1
    }

    fun reduce_or_cancel_order(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x1::option::Option<BasicOrder>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<BasicOrder>(arg3), 13906835484308406271);
        let v0 = 0x1::option::borrow_mut<BasicOrder>(arg3);
        if (0x2::clock::timestamp_ms(arg5) > v0.expiry_timestamp) {
            return
        };
        let v1 = v0.full_quantity - v0.filled_quantity;
        let (_, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        if (v1 > arg4 + v4 + v3) {
            let v5 = v0.filled_quantity + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::ensure_multiple_round_down(v1 - arg4, v3);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::modify_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, v0.order_id, v5, arg5, arg6);
            v0.full_quantity = v5;
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, arg1, v0.order_id, arg5, arg6);
            0x1::option::extract<BasicOrder>(arg3);
        };
    }

    public(friend) fun skew_quantity_based_on_position(arg0: &OrderManager, arg1: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: bool) : u64 {
        let v0 = get_base_balance_including_open_asks(arg0, arg1, arg2);
        let v1 = v0;
        if (v0 > arg0.fully_long_base_amount) {
            v1 = arg0.fully_long_base_amount;
        };
        let v2 = if (arg4) {
            1000 + 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::skew_quantity_amount_times_1k(arg1) - 2 * 1000 * v1 / arg0.fully_long_base_amount * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::skew_quantity_amount_times_1k(arg1) / 1000
        } else {
            1000 + 2 * 1000 * v1 / arg0.fully_long_base_amount * 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::skew_quantity_amount_times_1k(arg1) / 1000 - 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::skew_quantity_amount_times_1k(arg1)
        };
        arg3 * v2 / 1000
    }

    public(friend) fun try_ensure_available_base_balance(arg0: &mut OrderManager, arg1: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::OpenPoolPositions, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg12: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg1, arg2);
        let v1 = v0;
        if (arg16 <= v0) {
            return
        };
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 3))) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, 3);
            reduce_or_cancel_order(arg2, arg3, arg4, v2, arg16 - v0, arg17, arg18);
            let v3 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg1, arg2);
            v1 = v3;
            if (arg16 <= v3) {
                return
            };
        };
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 1))) {
            let v4 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, 1);
            reduce_or_cancel_order(arg2, arg3, arg4, v4, arg16 - v1, arg17, arg18);
            if (arg16 <= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_base_balance(arg1, arg2)) {
                return
            };
        };
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_maker::try_remove_liquidity_to_make_balance_available(arg1, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0, arg16, arg17, arg18);
    }

    public(friend) fun try_ensure_available_quote_balance(arg0: &mut OrderManager, arg1: &0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::parameters::Parameters, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_common::OpenPoolPositions, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg12: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg1, arg2);
        let v1 = v0;
        if (arg16 <= v0) {
            return
        };
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 2))) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, 2);
            let v3 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_base_at_price(arg1, arg16 - v0, 0x1::option::borrow<BasicOrder>(v2).price);
            reduce_or_cancel_order(arg2, arg3, arg4, v2, v3, arg17, arg18);
            let v4 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg1, arg2);
            v1 = v4;
            if (arg16 <= v4) {
                return
            };
        };
        if (0x1::option::is_some<BasicOrder>(0x1::vector::borrow<0x1::option::Option<BasicOrder>>(&arg0.orders, 0))) {
            let v5 = 0x1::vector::borrow_mut<0x1::option::Option<BasicOrder>>(&mut arg0.orders, 0);
            let v6 = 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::convert_to_base_at_price(arg1, arg16 - v1, 0x1::option::borrow<BasicOrder>(v5).price);
            reduce_or_cancel_order(arg2, arg3, arg4, v5, v6, arg17, arg18);
            if (arg16 <= 0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::common::get_available_quote_balance(arg1, arg2)) {
                return
            };
        };
        0xbacbe590370b0846dc606d82360f19a1ce3f67c5906f67f86a32bc35481b3fc2::swaps_maker::try_remove_liquidity_to_make_balance_available(arg1, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, 0, arg17, arg18);
    }

    // decompiled from Move bytecode v6
}

