module 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg1: &mut 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0xe10e433790b25a02428e046c06837d9268cc8067813808722c33de23998eafc3::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::id(arg1), arg2, 0);
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::market_obligation(arg1), arg5, 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg1: &mut 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0xe10e433790b25a02428e046c06837d9268cc8067813808722c33de23998eafc3::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1, v2) = 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::id(arg1), v1, v2, 0);
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

