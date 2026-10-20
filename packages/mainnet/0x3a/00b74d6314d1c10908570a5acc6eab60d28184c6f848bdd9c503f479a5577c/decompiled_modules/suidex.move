module 0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::suidex {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x8a47bf3b893172b53942e6f6fdd811df99aa32ba93af77d7484cde6430bddea1::vault::Vault, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8a47bf3b893172b53942e6f6fdd811df99aa32ba93af77d7484cde6430bddea1::vault::take<0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::router::Witness, T0, T1>(arg0, 0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::router::witness(), 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v2 = v0;
        let (v3, v4, v5) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg2, true, true, arg3, 0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::router::bound(arg5, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg2), true), arg7, arg1, arg8);
        let v6 = v5;
        let (v7, _) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v6);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg2, v6, 0x2::balance::split<T0>(&mut v2, v7), 0x2::balance::zero<T1>(), arg1, arg8);
        0x2::balance::join<T0>(&mut v2, v3);
        0x8a47bf3b893172b53942e6f6fdd811df99aa32ba93af77d7484cde6430bddea1::vault::settle<0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::router::Witness, T0, T1>(arg0, 0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::router::witness(), v1, v2, v4);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x8a47bf3b893172b53942e6f6fdd811df99aa32ba93af77d7484cde6430bddea1::vault::Vault, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8a47bf3b893172b53942e6f6fdd811df99aa32ba93af77d7484cde6430bddea1::vault::take<0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::router::Witness, T1, T0>(arg0, 0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::router::witness(), 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v2 = v0;
        let (v3, v4, v5) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg2, false, true, arg3, 0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::router::bound(arg5, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg2), false), arg7, arg1, arg8);
        let v6 = v5;
        let (_, v8) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v6);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg2, v6, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, v8), arg1, arg8);
        0x2::balance::join<T1>(&mut v2, v4);
        0x8a47bf3b893172b53942e6f6fdd811df99aa32ba93af77d7484cde6430bddea1::vault::settle<0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::router::Witness, T1, T0>(arg0, 0x6adf7219f7509a1b51c861cf966d5df71de02d631cbcc3b3af281801bcbb3083::router::witness(), v1, v2, v3);
    }

    // decompiled from Move bytecode v7
}

