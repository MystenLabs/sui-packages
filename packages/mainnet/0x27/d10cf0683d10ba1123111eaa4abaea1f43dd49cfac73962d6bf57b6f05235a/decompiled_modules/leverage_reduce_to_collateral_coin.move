module 0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::Market<T0>, arg1: &mut 0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::ensure_same_market<T0>(arg1);
        0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::id(arg1), arg2, 0, 0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::market_obligation(arg1), arg5, 0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::Market<T0>, arg1: &mut 0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::ensure_same_market<T0>(arg1);
        0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1) = 0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::id(arg1), v1, 0, 0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x27d10cf0683d10ba1123111eaa4abaea1f43dd49cfac73962d6bf57b6f05235a::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

