module 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::Market<T0>, arg1: &mut 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x7ff85dfbd93ac4c66df8560fb89a2af615d3227d35fe3e6c34fc7e1c0973412b::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::ensure_same_market<T0>(arg1);
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::id(arg1), arg2, 0, 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::market_obligation(arg1), arg5, 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::Market<T0>, arg1: &mut 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0x7ff85dfbd93ac4c66df8560fb89a2af615d3227d35fe3e6c34fc7e1c0973412b::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::ensure_same_market<T0>(arg1);
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1) = 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::id(arg1), v1, 0, 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

