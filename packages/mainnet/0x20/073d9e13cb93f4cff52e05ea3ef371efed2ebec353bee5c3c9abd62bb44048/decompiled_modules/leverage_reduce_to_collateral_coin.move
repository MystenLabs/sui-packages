module 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>, arg1: &mut 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0xfe91675bc6d4cef3cf3b6045567189b5a7fc98bca6199190cf0ebed3a793343a::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::ensure_same_market<T0>(arg1);
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::id(arg1), arg2, 0, 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::market_obligation(arg1), arg5, 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>, arg1: &mut 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0xfe91675bc6d4cef3cf3b6045567189b5a7fc98bca6199190cf0ebed3a793343a::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::ensure_same_market<T0>(arg1);
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1) = 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::id(arg1), v1, 0, 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

