module 0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::bluefin {
    public fun swap<T0, T1, T2, T3>(arg0: &mut 0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::checkpoint::Payload<T2, T3>, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        if (arg4) {
            0x2::balance::join<T0>(&mut v0, 0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::checkpoint::take_next<T2, T3, T0>(arg0));
        } else {
            0x2::balance::join<T1>(&mut v1, 0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::checkpoint::take_next<T2, T3, T1>(arg0));
        };
        let v2 = if (arg4) {
            0x2::balance::value<T0>(&v0)
        } else {
            0x2::balance::value<T1>(&v1)
        };
        let (v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg1, arg2, arg3, v0, v1, arg4, arg5, v2, arg6, arg7);
        if (arg4) {
            0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::checkpoint::place_next<T2, T3, T1>(arg0, v4);
            0x2::balance::destroy_zero<T0>(v3);
        } else {
            0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::checkpoint::place_next<T2, T3, T0>(arg0, v3);
            0x2::balance::destroy_zero<T1>(v4);
        };
    }

    // decompiled from Move bytecode v6
}

