module 0x27f1af3cd6ad85388a8414e16c9c31c1a17b484048844c4b7428d18d972844d0::cetus {
    public fun liquidate_c2d<T0, T1, T2>(arg0: &0x27f1af3cd6ad85388a8414e16c9c31c1a17b484048844c4b7428d18d972844d0::liquidator::Liquidator, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg4: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x27f1af3cd6ad85388a8414e16c9c31c1a17b484048844c4b7428d18d972844d0::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg10));
        0x27f1af3cd6ad85388a8414e16c9c31c1a17b484048844c4b7428d18d972844d0::liquidator::transfer_to_recipient<T2>(arg0, liquidate_with_cetus_c2d<T0, T1, T2>(0x27f1af3cd6ad85388a8414e16c9c31c1a17b484048844c4b7428d18d972844d0::liquidator::borrow_package_caller_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    public fun liquidate_d2c<T0, T1, T2>(arg0: &0x27f1af3cd6ad85388a8414e16c9c31c1a17b484048844c4b7428d18d972844d0::liquidator::Liquidator, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg4: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x27f1af3cd6ad85388a8414e16c9c31c1a17b484048844c4b7428d18d972844d0::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg10));
        0x27f1af3cd6ad85388a8414e16c9c31c1a17b484048844c4b7428d18d972844d0::liquidator::transfer_to_recipient<T2>(arg0, liquidate_with_cetus_d2c<T0, T1, T2>(0x27f1af3cd6ad85388a8414e16c9c31c1a17b484048844c4b7428d18d972844d0::liquidator::borrow_package_caller_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    fun liquidate_with_cetus_c2d<T0, T1, T2>(arg0: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg4: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg1, arg2, true, false, arg8, 4295048016, arg9);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let v4 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::liquidate::liquidate_as_coin<T0, T1, T2>(arg3, arg0, arg5, arg4, 0x2::coin::from_balance<T1>(v1, arg10), arg6, arg7, arg9, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg1, arg2, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v3), arg10)), 0x2::balance::zero<T1>(), v3);
        v4
    }

    fun liquidate_with_cetus_d2c<T0, T1, T2>(arg0: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg4: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg1, arg2, false, false, arg8, 79226673515401279992447579055, arg9);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v1);
        let v4 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::liquidate::liquidate_as_coin<T0, T1, T2>(arg3, arg0, arg5, arg4, 0x2::coin::from_balance<T1>(v0, arg10), arg6, arg7, arg9, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3), arg10)), v3);
        v4
    }

    // decompiled from Move bytecode v6
}

