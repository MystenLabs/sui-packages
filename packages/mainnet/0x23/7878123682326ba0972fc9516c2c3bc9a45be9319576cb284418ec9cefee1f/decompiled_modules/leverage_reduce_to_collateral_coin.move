module 0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_obligation::id(arg1), arg2, 0);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_obligation::market_obligation(arg1), arg5, 0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1) = 0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_obligation::id(arg1), v1, 0);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x237878123682326ba0972fc9516c2c3bc9a45be9319576cb284418ec9cefee1f::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

