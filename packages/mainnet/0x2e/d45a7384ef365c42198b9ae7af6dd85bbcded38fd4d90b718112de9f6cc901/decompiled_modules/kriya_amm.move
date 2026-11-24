module 0x2ed45a7384ef365c42198b9ae7af6dd85bbcded38fd4d90b718112de9f6cc901::kriya_amm {
    public fun swap<T0, T1>(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1>(arg0, arg1, arg3, arg4);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg3, arg4);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::take_balance<T0>(arg0, arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, 0x2::coin::from_balance<T0>(v0, arg3), v1, 0, arg3);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::emit_swap_event<T0, T1>(arg0, b"KRIYA_AMM", 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg1), v1, 0x2::coin::value<T1>(&v2), 0);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::take_balance<T1>(arg0, arg2);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, 0x2::coin::from_balance<T1>(v0, arg3), v1, 0, arg3);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::emit_swap_event<T1, T0>(arg0, b"KRIYA_AMM", 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg1), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    // decompiled from Move bytecode v7
}

