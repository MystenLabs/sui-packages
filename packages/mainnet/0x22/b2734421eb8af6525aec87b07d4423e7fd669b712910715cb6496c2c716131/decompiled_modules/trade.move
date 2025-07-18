module 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::trade {
    public fun buy_stock<T0>(arg0: &mut 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::Config, arg1: &mut 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::treasury::Treasury, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::check_version(arg0);
        assert!(0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::registry_contains<T0>(arg0), 1003);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        assert!(v0 != 0, 1000);
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::check_max_limit<T0>(arg0, v0);
        let (v1, v2) = 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::price::ask_price<T0>(arg0, arg2, arg4);
        let v3 = (v0 - take_protocol_fee_base_18(arg0, v0) - take_fee_base_18<T0>(arg0, v0)) * 100000000 / 1000000 * 0x1::u64::pow(10, (v2 as u8)) / v1;
        assert!(v3 != 0, 1000);
        let v4 = v1 * v3 * 1000000 / 100000000 / 0x1::u64::pow(10, (v2 as u8)) + 1;
        let v5 = v4 + take_protocol_fee_base_18(arg0, v4) + take_fee_base_18<T0>(arg0, v4);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) >= v5, 1001);
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::treasury::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg3, v5, arg5));
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::add_count_count(arg0, v3);
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::events::emit_buy_xstock_event<T0>(0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::get_registry_price_id<T0>(arg0), v3, v5, arg5);
        (v5, v3, arg3)
    }

    public fun sell_stock<T0>(arg0: &mut 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::Config, arg1: &mut 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::treasury::Treasury, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::check_version(arg0);
        assert!(0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::registry_contains<T0>(arg0), 1003);
        let v0 = 0x2::coin::value<T0>(&arg3);
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::treasury::deposit<T0>(arg1, arg3);
        assert!(v0 != 0, 1000);
        let (v1, v2) = 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::price::bid_price<T0>(arg0, arg2, arg4);
        let v3 = v1 * v0 / 100000000 / 1000000 / 0x1::u64::pow(10, (v2 as u8));
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::check_max_limit<T0>(arg0, v3);
        let v4 = v3 - take_protocol_fee_base_18(arg0, v3) - take_fee_base_18<T0>(arg0, v3);
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::sub_count_count(arg0, v0);
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::events::emit_sell_xstock_event<T0>(0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::get_registry_price_id<T0>(arg0), v0, v3, arg5);
        (v0, v4, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::treasury::borrow_from_treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1), v4), arg5))
    }

    public fun take_fee_base_18<T0>(arg0: &0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::Config, arg1: u64) : u64 {
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::price::take_percent_base_18(arg1, 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::get_fee_ratio<T0>(arg0))
    }

    public fun take_protocol_fee_base_18(arg0: &0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::Config, arg1: u64) : u64 {
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::price::take_percent_base_18(arg1, 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::config::get_protocol_fee_ratio(arg0))
    }

    // decompiled from Move bytecode v6
}

