module 0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_swap_borrow {
    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: &mut 0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_market::LeverageMarket, arg3: &0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_obligation::LeverageMarketOwnerCap, arg4: 0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_repay::LeverageHotPotato<T0, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 0
    }

    public fun request_leverage<T0, T1, T2>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_app::LeverageApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &mut 0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_market::LeverageMarket, arg4: &mut 0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_repay::LeverageHotPotato<T0, T2>, 0x2::coin::Coin<T2>) {
        abort 0
    }

    // decompiled from Move bytecode v7
}

