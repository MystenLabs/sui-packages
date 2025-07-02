module 0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::trade {
    public fun buy_stock(arg0: &0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::config::Config, arg1: &mut 0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::treasury::Treasury, arg2: vector<u8>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::config::check_version(arg0);
        0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::config::check_max_limit(arg0, arg4);
        let (v0, v1) = 0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::price::ask_price(arg0, arg2, arg3, arg6);
        let v2 = v0 * arg4 * 1000000 / 0x1::u64::pow(10, (v1 as u8));
        let v3 = v2 + take_fee_base_18(arg0, v2);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg5) >= v3, 0);
        0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::treasury::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg5, v3, arg7));
        0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::events::emit_buy_xstock_event(arg2, arg4, v3, arg7);
        arg5
    }

    public fun sell_stock<T0>(arg0: &0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::config::Config, arg1: &mut 0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::treasury::Treasury, arg2: vector<u8>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, 0x2::coin::Coin<T0>) {
        0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::config::check_version(arg0);
        0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::config::check_max_limit(arg0, arg4);
        assert!(0x2::coin::value<T0>(&arg5) == arg4, 0);
        let (v0, v1) = 0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::price::bid_price(arg0, arg2, arg3, arg6);
        let v2 = v0 * arg4 * 1000000 / 0x1::u64::pow(10, (v1 as u8));
        let v3 = v2 - take_fee_base_18(arg0, v2);
        0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::events::emit_sell_xstock_event(arg2, arg4, v3, arg7);
        (0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::treasury::borrow_from_treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1), v3), arg7), arg5)
    }

    public fun take_fee_base_18(arg0: &0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::config::Config, arg1: u64) : u64 {
        0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::price::take_percent_base_18(arg1, 0x18174d21004a7a0eeefdd3a8de7a2c23ee1b2b5a7f287706d898a625c54cb2e::config::get_fee_ratio(arg0))
    }

    // decompiled from Move bytecode v6
}

