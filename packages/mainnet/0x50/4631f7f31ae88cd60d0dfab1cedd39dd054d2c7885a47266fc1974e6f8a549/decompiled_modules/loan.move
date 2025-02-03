module 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::loan {
    public fun swap_a2b_rpy<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::version::Version, arg2: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg3: 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::reserve::FlashLoan<T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x2::tx_context::TxContext) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::flash_loan::repay_flash_loan<T1>(arg1, arg2, 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::cts::a2b<T0, T1>(arg0, arg5, arg6, arg4, arg7), arg3, arg7);
    }

    public fun swap_b2a_rpy<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::version::Version, arg2: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg3: 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::reserve::FlashLoan<T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x2::tx_context::TxContext) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::flash_loan::repay_flash_loan<T1>(arg1, arg2, 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::cts::b2a<T1, T0>(arg0, arg5, arg6, arg4, arg7), arg3, arg7);
    }

    // decompiled from Move bytecode v6
}

