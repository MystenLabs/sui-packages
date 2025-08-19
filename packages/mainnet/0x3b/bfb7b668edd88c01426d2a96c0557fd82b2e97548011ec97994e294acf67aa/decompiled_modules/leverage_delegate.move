module 0x3bbfb7b668edd88c01426d2a96c0557fd82b2e97548011ec97994e294acf67aa::leverage_delegate {
    public fun borrow<T0, T1>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &0x3bbfb7b668edd88c01426d2a96c0557fd82b2e97548011ec97994e294acf67aa::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg4: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::borrow::borrow<T0, T1>(0x3bbfb7b668edd88c01426d2a96c0557fd82b2e97548011ec97994e294acf67aa::leverage_obligation::market_obligation(arg1), arg0, arg4, arg2, arg3, arg5, arg6)
    }

    public fun deposit<T0, T1>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &0x3bbfb7b668edd88c01426d2a96c0557fd82b2e97548011ec97994e294acf67aa::leverage_obligation::LeverageMarketOwnerCap, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::deposit::deposit<T0, T1>(0x3bbfb7b668edd88c01426d2a96c0557fd82b2e97548011ec97994e294acf67aa::leverage_obligation::market_obligation(arg1), arg0, arg2, arg3, arg4);
    }

    public fun repay<T0, T1>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &0x3bbfb7b668edd88c01426d2a96c0557fd82b2e97548011ec97994e294acf67aa::leverage_obligation::LeverageMarketOwnerCap, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::repay::repay_coin_refund<T0, T1>(0x3bbfb7b668edd88c01426d2a96c0557fd82b2e97548011ec97994e294acf67aa::leverage_obligation::market_obligation(arg1), arg0, arg2, arg3, arg4)
    }

    public fun withdraw<T0, T1>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &0x3bbfb7b668edd88c01426d2a96c0557fd82b2e97548011ec97994e294acf67aa::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg4: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x3bbfb7b668edd88c01426d2a96c0557fd82b2e97548011ec97994e294acf67aa::leverage_obligation::market_obligation(arg1), arg4, arg2, arg3, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

