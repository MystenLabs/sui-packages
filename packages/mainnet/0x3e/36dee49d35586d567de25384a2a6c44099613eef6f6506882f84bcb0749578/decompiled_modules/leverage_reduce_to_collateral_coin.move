module 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::LeverageApp, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>, arg3: &0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::ensure_version_matches(arg0);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::ensure_same_market<T0>(arg3);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::market_obligation(arg3), arg7, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::LeverageApp, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>, arg3: &0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::ensure_version_matches(arg0);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::ensure_same_market<T0>(arg3);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

