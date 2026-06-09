module 0x7b471c5a12d244f3325a9286cc6747425a6ec1f22e4e5b4cc9db86830f95d9d8::leverage_delegate {
    public fun claim_liquidity_minging_rewards<T0, T1, T2>(arg0: &0x7b471c5a12d244f3325a9286cc6747425a6ec1f22e4e5b4cc9db86830f95d9d8::leverage_app::LeverageApp, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0x7b471c5a12d244f3325a9286cc6747425a6ec1f22e4e5b4cc9db86830f95d9d8::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun deposit<T0, T1, T2>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &0x7b471c5a12d244f3325a9286cc6747425a6ec1f22e4e5b4cc9db86830f95d9d8::leverage_app::LeverageApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0x7b471c5a12d244f3325a9286cc6747425a6ec1f22e4e5b4cc9db86830f95d9d8::leverage_obligation::LeverageMarketOwnerCap, arg4: 0x2::coin::Coin<T1>, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun repay<T0, T1, T2>(arg0: &0x7b471c5a12d244f3325a9286cc6747425a6ec1f22e4e5b4cc9db86830f95d9d8::leverage_app::LeverageApp, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0x7b471c5a12d244f3325a9286cc6747425a6ec1f22e4e5b4cc9db86830f95d9d8::leverage_obligation::LeverageMarketOwnerCap, arg4: 0x2::coin::Coin<T2>, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

