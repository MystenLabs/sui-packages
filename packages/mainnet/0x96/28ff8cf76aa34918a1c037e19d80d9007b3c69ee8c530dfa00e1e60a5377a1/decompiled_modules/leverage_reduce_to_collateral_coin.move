module 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::LeverageApp, arg1: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::ProtocolApp, arg2: &mut 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>, arg3: &0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::ensure_version_matches(arg0);
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::ensure_same_market<T0>(arg3);
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::market_obligation(arg3), arg7, 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::LeverageApp, arg1: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::ProtocolApp, arg2: &mut 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>, arg3: &0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::ensure_version_matches(arg0);
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::ensure_same_market<T0>(arg3);
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v7
}

