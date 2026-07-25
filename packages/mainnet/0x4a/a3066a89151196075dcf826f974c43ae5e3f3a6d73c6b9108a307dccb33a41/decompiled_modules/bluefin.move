module 0xfa5560ff4c1b8eef703478ef50f175dace21ec5a6bf073fb7635eb5b77d6baf3::bluefin {
    struct BluefinSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xfa5560ff4c1b8eef703478ef50f175dace21ec5a6bf073fb7635eb5b77d6baf3::fingerprint::assert_fp(arg4, 0xfa5560ff4c1b8eef703478ef50f175dace21ec5a6bf073fb7635eb5b77d6baf3::fingerprint::bluefin_pool_fp<T0, T1>(arg2));
        let v0 = 0x2::coin::value<T0>(&arg3);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), true, true, v0, 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1);
        let v3 = v2;
        let v4 = BluefinSwapEvent{
            pool         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            amount_in    : v0,
            amount_out   : 0x2::balance::value<T1>(&v3),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<BluefinSwapEvent>(v4);
        0xfa5560ff4c1b8eef703478ef50f175dace21ec5a6bf073fb7635eb5b77d6baf3::utils::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v1, arg5), arg5);
        0x2::coin::from_balance<T1>(v3, arg5)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xfa5560ff4c1b8eef703478ef50f175dace21ec5a6bf073fb7635eb5b77d6baf3::fingerprint::assert_fp(arg4, 0xfa5560ff4c1b8eef703478ef50f175dace21ec5a6bf073fb7635eb5b77d6baf3::fingerprint::bluefin_pool_fp<T0, T1>(arg2));
        let v0 = 0x2::coin::value<T1>(&arg3);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), false, true, v0, 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1);
        let v3 = v1;
        let v4 = BluefinSwapEvent{
            pool         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            amount_in    : v0,
            amount_out   : 0x2::balance::value<T0>(&v3),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<BluefinSwapEvent>(v4);
        0xfa5560ff4c1b8eef703478ef50f175dace21ec5a6bf073fb7635eb5b77d6baf3::utils::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v2, arg5), arg5);
        0x2::coin::from_balance<T0>(v3, arg5)
    }

    // decompiled from Move bytecode v7
}

