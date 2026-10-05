module 0x17058447cf4c0ffed98165e5c723d6e308c3d2b9385266bf31c4e603fe861ab6::m {
    fun ck(arg0: u128, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg0 >= arg1, 101);
        } else {
            assert!(arg0 <= arg1, 101);
        };
    }

    public fun gb<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        ck(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun gc<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        ck(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun gd<T0, T1>(arg0: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        ck(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun gg<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        ck(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun gk<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        ck(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun gm<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        ck(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun go<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u128, arg3: bool) {
        ck((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1) as u128), arg2, arg3);
    }

    public fun gs<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        ck(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun gt<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u128, arg2: bool) {
        ck(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), arg1, arg2);
    }

    public fun gz<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 100);
        0x2::coin::from_balance<T0>(arg0, arg2)
    }

    // decompiled from Move bytecode v7
}

