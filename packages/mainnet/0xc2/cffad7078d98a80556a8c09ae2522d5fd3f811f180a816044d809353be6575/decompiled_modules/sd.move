module 0xc2cffad7078d98a80556a8c09ae2522d5fd3f811f180a816044d809353be6575::sd {
    public fun sxy<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::coin::value<T0>(&arg1), arg2, arg4, arg3, arg5);
        let v3 = v2;
        let (v4, _) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v3);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg5)), 0x2::balance::zero<T1>(), arg3, arg5);
        0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v0, arg5));
        0xc2cffad7078d98a80556a8c09ae2522d5fd3f811f180a816044d809353be6575::u::tod<T0>(arg1, 0x2::tx_context::sender(arg5));
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun syx<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u128, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::coin::value<T1>(&arg1), arg2, arg4, arg3, arg5);
        let v3 = v2;
        let (_, v5) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v3);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v5, arg5)), arg3, arg5);
        0x2::coin::join<T1>(&mut arg1, 0x2::coin::from_balance<T1>(v1, arg5));
        0xc2cffad7078d98a80556a8c09ae2522d5fd3f811f180a816044d809353be6575::u::tod<T1>(arg1, 0x2::tx_context::sender(arg5));
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    // decompiled from Move bytecode v7
}

