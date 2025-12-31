module 0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::momentum_only {
    public fun liquidate_c2d<T0, T1, T2>(arg0: &0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::Liquidator, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg3: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg4: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg10));
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::transfer_to_recipient<T2>(arg0, liquidate_with_momentum_c2d<T0, T1, T2>(0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::borrow_package_caller_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    public fun liquidate_c2d_testing<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = liquidate_with_momentum_c2d_testing<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun liquidate_d2c<T0, T1, T2>(arg0: &0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::Liquidator, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg4: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg10));
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::transfer_to_recipient<T2>(arg0, liquidate_with_momentum_d2c<T0, T1, T2>(0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::borrow_package_caller_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    public fun liquidate_d2c_testing<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = liquidate_with_momentum_d2c_testing<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    fun liquidate_with_momentum_c2d<T0, T1, T2>(arg0: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg3: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg4: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T1>(arg2, true, false, arg8, 4295048016, arg9, arg1, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let v4 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::liquidate::liquidate_as_coin<T0, T1, T2>(arg3, arg0, arg5, arg4, 0x2::coin::from_balance<T1>(v1, arg10), arg6, arg7, arg9, arg10);
        let (v5, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T1>(arg2, v3, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), arg1, arg10);
        v4
    }

    fun liquidate_with_momentum_c2d_testing<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T0>(arg2, true, false, arg3, 4295048016, arg4, arg1, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T0>(arg2, v3, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg0, v4, arg5)), 0x2::balance::zero<T0>(), arg1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg5), 0x2::tx_context::sender(arg5));
        arg0
    }

    fun liquidate_with_momentum_d2c<T0, T1, T2>(arg0: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg4: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg2, false, false, arg8, 79226673515401279992447579055, arg9, arg1, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v1);
        let v4 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::liquidate::liquidate_as_coin<T0, T1, T2>(arg3, arg0, arg5, arg4, 0x2::coin::from_balance<T1>(v0, arg10), arg6, arg7, arg9, arg10);
        let (_, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg2, v3, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v4, v6, arg10)), arg1, arg10);
        v4
    }

    fun liquidate_with_momentum_d2c_testing<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, false, false, arg3, 79226673515401279992447579055, arg4, arg1, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg0, v5, arg5)), arg1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
        arg0
    }

    // decompiled from Move bytecode v6
}

