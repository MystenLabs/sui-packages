module 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg1: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_obligation::id(arg1), arg2, 0);
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_obligation::market_obligation(arg1), arg5, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg1: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1, v2) = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_obligation::id(arg1), v1, v2, 0);
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

