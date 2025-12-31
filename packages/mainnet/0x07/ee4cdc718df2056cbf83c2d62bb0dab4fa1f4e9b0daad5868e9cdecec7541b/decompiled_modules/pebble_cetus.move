module 0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::pebble_cetus {
    public fun liquidate_c2d<T0, T1, T2>(arg0: &0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::Liquidator, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg11));
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::transfer_to_recipient<T2>(arg0, liquidate_with_cetus_c2d<T0, T1, T2>(arg1, 0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::borrow_package_caller_cap(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public fun liquidate_d2c<T0, T1, T2>(arg0: &0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::Liquidator, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg11));
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::transfer_to_recipient<T2>(arg0, liquidate_with_cetus_d2c<T0, T1, T2>(arg1, 0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::borrow_package_caller_cap(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    fun liquidate_with_cetus_c2d<T0, T1, T2>(arg0: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::borrow_flash_loan<T0, T1>(arg0, arg1, arg3, arg6, arg7, arg11);
        let v2 = v0;
        let v3 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::liquidate::liquidate_as_coin<T0, T1, T2>(arg0, arg1, arg2, arg3, v2, arg4, arg5, arg10, arg11);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg8, arg9, true, false, (((0x2::coin::value<T1>(&v2) as u128) * ((5 + 10000) as u128) / 10000) as u64), 4295048016, arg10);
        let v7 = v6;
        0x2::balance::destroy_zero<T2>(v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg8, arg9, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v7), arg11)), 0x2::balance::zero<T1>(), v7);
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::repay_flash_loan<T0, T1>(arg0, arg3, 0x2::coin::from_balance<T1>(v5, arg11), v1, 0x1::option::none<0x1::string::String>(), arg11);
        v3
    }

    fun liquidate_with_cetus_d2c<T0, T1, T2>(arg0: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::borrow_flash_loan<T0, T1>(arg0, arg1, arg3, arg6, arg7, arg11);
        let v2 = v0;
        let v3 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::liquidate::liquidate_as_coin<T0, T1, T2>(arg0, arg1, arg2, arg3, v2, arg4, arg5, arg10, arg11);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg8, arg9, false, false, (((0x2::coin::value<T1>(&v2) as u128) * ((5 + 10000) as u128) / 10000) as u64), 79226673515401279992447579055, arg10);
        let v7 = v6;
        0x2::balance::destroy_zero<T2>(v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg8, arg9, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v7), arg11)), v7);
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::repay_flash_loan<T0, T1>(arg0, arg3, 0x2::coin::from_balance<T1>(v4, arg11), v1, 0x1::option::none<0x1::string::String>(), arg11);
        v3
    }

    // decompiled from Move bytecode v6
}

