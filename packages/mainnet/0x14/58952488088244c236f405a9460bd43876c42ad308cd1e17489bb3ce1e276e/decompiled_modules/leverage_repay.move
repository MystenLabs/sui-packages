module 0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_repay {
    struct LeverageHotPotato<phantom T0, phantom T1> {
        flash_loan: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::FlashLoan<T0, T1>,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: &mut 0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_market::LeverageMarket, arg3: &0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_obligation::LeverageMarketOwnerCap, arg4: LeverageHotPotato<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun split_with_event<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

