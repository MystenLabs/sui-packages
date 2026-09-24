module 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::bluefin {
    fun swap<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (arg4) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_sqrt_price() + 1
        } else {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_sqrt_price() - 1
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg8, arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg7, v0)
    }

    fun convert_swap_result(arg0: bool, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg0) {
            (arg1 - arg2, arg3)
        } else {
            (arg3, arg1 - arg2)
        }
    }

    public fun quote<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64) {
        assert!(arg3 > 0, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::zero_amount());
        let v0 = if (arg1) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_sqrt_price() + 1
        } else {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_sqrt_price() - 1
        };
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, arg2, arg3, v0);
        let (v2, v3) = convert_swap_result(arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v1));
        0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::emit_swap_quote(0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::source_bluefin(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0), arg1, arg2, arg3, v2, v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_fee_amount(&v1) + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_protocol_fee(&v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v1));
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(0x2::coin::zero<T1>(arg5)), true, true, 0x2::coin::value<T0>(&arg2), arg3, arg4);
        (0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::from_balance<T1>(v1, arg5))
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::zero<T0>(arg5)), 0x2::coin::into_balance<T1>(arg2), false, true, 0x2::coin::value<T1>(&arg2), arg3, arg4);
        (0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::from_balance<T1>(v1, arg5))
    }

    // decompiled from Move bytecode v7
}

