module 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::LeverageApp, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg3: &0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0x8f470555f3bececd724527af2680830b545802a79f485a52efc8a310275869cf::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::ensure_version_matches(arg0);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::ensure_same_market<T0>(arg3);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::id(arg3), arg4, 0, 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::market_obligation(arg3), arg7, 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::LeverageApp, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg3: &0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0x8f470555f3bececd724527af2680830b545802a79f485a52efc8a310275869cf::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::ensure_version_matches(arg0);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::ensure_same_market<T0>(arg3);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

