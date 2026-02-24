module 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::LeverageApp, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: &0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::ensure_version_matches(arg0);
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::ensure_same_market<T0>(arg3);
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::market_obligation(arg3), arg7, 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::LeverageApp, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: &0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::ensure_version_matches(arg0);
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::ensure_same_market<T0>(arg3);
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

