module 0xbad9cca55c30175be9e9b57538cd5b10d9c0ffe4f8e2fdab50e5b9687519d4fe::clmm {
    public fun swap<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: u64, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, true, true, v1, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::min_sqrt_price(), arg4, arg2, arg6);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v4, v0, 0x2::balance::zero<T1>(), arg2, arg6);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, v2);
        if (arg5) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<T0>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<T0>(arg0), arg6);
        };
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T1>(arg0, v3);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: u64, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, false, true, v1, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::max_sqrt_price(), arg4, arg2, arg6);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), v0, arg2, arg6);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T1>(arg0, v3);
        if (arg5) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<T1>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<T1>(arg0), arg6);
        };
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, v2);
    }

    // decompiled from Move bytecode v7
}

