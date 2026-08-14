module 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::LeverageApp, arg1: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp, arg2: &mut 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>, arg3: &0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::ensure_version_matches(arg0);
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::ensure_same_market<T0>(arg3);
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::market_obligation(arg3), arg7, 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::LeverageApp, arg1: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp, arg2: &mut 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>, arg3: &0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::ensure_version_matches(arg0);
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::ensure_same_market<T0>(arg3);
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

