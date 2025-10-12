module 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg1: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::id(arg1), arg2, 0);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::market_obligation(arg1), arg5, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg1: &mut 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1, v2) = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::id(arg1), v1, v2, 0);
        0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

