module 0x8fa21a7f27e17fb59e67cd40dc5ca75660daaf62583c3178ba51b0457174a99d::route {
    public fun begin_a2b<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg0, true, true, arg2, 4295048017, arg3, arg1, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        (0x2::coin::from_balance<T1>(v1, arg4), v2)
    }

    public fun begin_b2a<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg0, false, true, arg2, 79226673515401279992447579055, arg3, arg1, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        (0x2::coin::from_balance<T0>(v0, arg4), v2)
    }

    fun pay_a2b<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), arg1, arg4);
    }

    fun pay_b2a<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), arg1, arg4);
    }

    public fun repay_a2b<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::split<T0>(&mut arg3, arg4, arg7);
        if (arg5 > 0) {
            0x2::coin::join<T0>(&mut arg3, 0x2::coin::split<T0>(&mut arg3, arg5, arg7));
        };
        pay_a2b<T0, T1>(arg0, arg1, arg2, v0, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg6);
    }

    public fun repay_b2a<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::split<T1>(&mut arg3, arg4, arg7);
        if (arg5 > 0) {
            0x2::coin::join<T1>(&mut arg3, 0x2::coin::split<T1>(&mut arg3, arg5, arg7));
        };
        pay_b2a<T0, T1>(arg0, arg1, arg2, v0, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, arg6);
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = begin_a2b<T0, T1>(arg0, arg1, 0x2::coin::value<T0>(&arg2), arg3, arg4);
        pay_a2b<T0, T1>(arg0, arg1, v1, arg2, arg4);
        v0
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = begin_b2a<T0, T1>(arg0, arg1, 0x2::coin::value<T1>(&arg2), arg3, arg4);
        pay_b2a<T0, T1>(arg0, arg1, v1, arg2, arg4);
        v0
    }

    // decompiled from Move bytecode v7
}

