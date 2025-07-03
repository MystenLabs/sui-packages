module 0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::trade {
    public fun buy_stock<T0>(arg0: &0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::Config, arg1: &mut 0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::treasury::Treasury, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::registry_contains<T0>(arg0), 3);
        assert!(arg3 != 0, 0);
        let v0 = 0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::get_registry_price_id<T0>(arg0);
        0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::check_version(arg0);
        0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::check_max_limit(arg0, arg3);
        let (v1, v2) = 0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::price::ask_price(arg0, v0, arg2, arg5);
        let v3 = v1 * arg3 * 10 / 0x1::u64::pow(10, (v2 as u8));
        let v4 = v3 + take_fee_base_18(arg0, v3);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) >= v4, 1);
        0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::treasury::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg4, v4, arg6));
        0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::events::emit_buy_xstock_event(v0, arg3, v4, arg6);
        arg4
    }

    public fun sell_stock<T0>(arg0: &0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::Config, arg1: &mut 0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::treasury::Treasury, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, 0x2::coin::Coin<T0>) {
        assert!(0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::registry_contains<T0>(arg0), 3);
        assert!(arg3 != 0, 0);
        let v0 = 0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::get_registry_price_id<T0>(arg0);
        0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::check_version(arg0);
        0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::check_max_limit(arg0, arg3);
        assert!(0x2::coin::value<T0>(&arg4) == arg3, 1);
        let (v1, v2) = 0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::price::bid_price(arg0, v0, arg2, arg5);
        let v3 = v1 * arg3 * 10 / 0x1::u64::pow(10, (v2 as u8));
        let v4 = v3 - take_fee_base_18(arg0, v3);
        0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::events::emit_sell_xstock_event(v0, arg3, v4, arg6);
        (0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::treasury::borrow_from_treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1), v4), arg6), arg4)
    }

    public fun take_fee_base_18(arg0: &0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::Config, arg1: u64) : u64 {
        0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::price::take_percent_base_18(arg1, 0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::config::get_fee_ratio(arg0))
    }

    // decompiled from Move bytecode v6
}

