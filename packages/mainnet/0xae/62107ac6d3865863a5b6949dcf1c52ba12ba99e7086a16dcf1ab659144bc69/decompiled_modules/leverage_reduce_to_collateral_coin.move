module 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::LeverageApp, arg1: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::market::Market<T0>, arg3: &0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0xa5c42487226f39847b90db5110520084d76c282cee473f6674fe0787d54f7829::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::ensure_version_matches(arg0);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::ensure_same_market<T0>(arg3);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::market_obligation(arg3), arg7, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::LeverageApp, arg1: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::market::Market<T0>, arg3: &0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0xa5c42487226f39847b90db5110520084d76c282cee473f6674fe0787d54f7829::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::ensure_version_matches(arg0);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::ensure_same_market<T0>(arg3);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

