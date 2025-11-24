module 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg1: &mut 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::id(arg1), arg2, 0);
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::market_obligation(arg1), arg5, 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg1: &mut 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1, v2) = 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::id(arg1), v1, v2, 0);
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

