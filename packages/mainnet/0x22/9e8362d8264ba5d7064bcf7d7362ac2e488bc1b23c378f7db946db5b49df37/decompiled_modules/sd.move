module 0x229e8362d8264ba5d7064bcf7d7362ac2e488bc1b23c378f7db946db5b49df37::sd {
    public fun a2b<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::coin::value<T0>(&arg1), 4295048016, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg0, v2, 0x2::coin::into_balance<T0>(arg1), 0x2::balance::zero<T1>(), arg3, arg4);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun b2a<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::coin::value<T1>(&arg1), 79226673515401279992447579055, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg0, v2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg1), arg3, arg4);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public fun gc<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg0) >= arg1, 101);
        } else {
            assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg0) <= arg1, 101);
        };
    }

    // decompiled from Move bytecode v7
}

