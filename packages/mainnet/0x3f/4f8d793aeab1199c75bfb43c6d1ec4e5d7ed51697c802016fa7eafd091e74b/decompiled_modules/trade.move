module 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::trade {
    public fun buy_stock<T0>(arg0: &mut 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::Config, arg1: &mut 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::treasury::Treasury, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::check_version(arg0);
        assert!(0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::registry_contains<T0>(arg0), 1003);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        assert!(v0 != 0, 1000);
        let (v1, v2) = 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::price::ask_price<T0>(arg0, arg2, arg4);
        let v3 = (v0 - take_protocol_fee_base_18(arg0, v0) - take_fee_base_18<T0>(arg0, v0)) * 0x1::u64::pow(10, (v2 as u8)) / v1 / 10;
        assert!(v3 != 0, 1000);
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::check_max_limit(arg0, v3);
        let v4 = v1 * v3 * 10 / 0x1::u64::pow(10, (v2 as u8)) + 1;
        let v5 = v4 + take_protocol_fee_base_18(arg0, v4) + take_fee_base_18<T0>(arg0, v4);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) >= v5, 1001);
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::treasury::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg3, v5, arg5));
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::add_count_count(arg0, v3);
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::events::emit_buy_xstock_event<T0>(0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::get_registry_price_id<T0>(arg0), v3, v5, arg5);
        (v5, v3, arg3)
    }

    public fun sell_stock<T0>(arg0: &mut 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::Config, arg1: &mut 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::treasury::Treasury, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::check_version(arg0);
        assert!(0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::registry_contains<T0>(arg0), 1003);
        let v0 = 0x2::coin::value<T0>(&arg3);
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::treasury::deposit<T0>(arg1, arg3);
        assert!(v0 != 0, 1000);
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::check_max_limit(arg0, v0);
        let (v1, v2) = 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::price::bid_price<T0>(arg0, arg2, arg4);
        let v3 = v1 * v0 * 10 / 0x1::u64::pow(10, (v2 as u8));
        let v4 = v3 - take_protocol_fee_base_18(arg0, v3) - take_fee_base_18<T0>(arg0, v3);
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::sub_count_count(arg0, v0);
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::events::emit_sell_xstock_event<T0>(0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::get_registry_price_id<T0>(arg0), v0, v3, arg5);
        (v0, v4, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::treasury::borrow_from_treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1), v4), arg5))
    }

    public fun take_fee_base_18<T0>(arg0: &0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::Config, arg1: u64) : u64 {
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::price::take_percent_base_18(arg1, 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::get_fee_ratio<T0>(arg0))
    }

    public fun take_protocol_fee_base_18(arg0: &0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::Config, arg1: u64) : u64 {
        0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::price::take_percent_base_18(arg1, 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::config::get_protocol_fee_ratio(arg0))
    }

    // decompiled from Move bytecode v6
}

