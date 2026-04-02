module 0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_app::LeverageApp, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: &0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_app::ensure_version_matches(arg0);
        0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::ensure_same_market<T0>(arg3);
        0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::market_obligation(arg3), arg7, 0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_app::LeverageApp, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: &0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_app::ensure_version_matches(arg0);
        0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::ensure_same_market<T0>(arg3);
        0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0x3e0612a477fa2e48fb6270f74051af341004cf52ff81ba89c8a44bf301aa0103::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

