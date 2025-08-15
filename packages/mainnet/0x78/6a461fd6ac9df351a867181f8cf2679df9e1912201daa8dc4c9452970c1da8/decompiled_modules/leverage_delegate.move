module 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_delegate {
    public fun borrow<T0, T1>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg4: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::borrow::borrow<T0, T1>(0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::market_obligation(arg1), arg0, arg4, arg2, arg3, arg5, arg6)
    }

    public fun deposit<T0, T1>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::LeverageMarketOwnerCap, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::deposit::deposit<T0, T1>(0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::market_obligation(arg1), arg0, arg2, arg3, arg4);
    }

    public fun repay<T0, T1>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::LeverageMarketOwnerCap, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::repay::repay_coin_refund<T0, T1>(0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::market_obligation(arg1), arg0, arg2, arg3, arg4)
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg4: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_obligation::market_obligation(arg1), arg4, arg2, arg3, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

