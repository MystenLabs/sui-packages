module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::bluefin {
    struct BluefinAdapter has drop {
        dummy_field: bool,
    }

    public fun a_to_b<T0, T1, T2, T3>(arg0: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg2: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock) : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T3> {
        let v0 = BluefinAdapter{dummy_field: false};
        let (v1, v2, v3) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::lend<BluefinAdapter, T0, T1, T2>(arg0, arg1, arg2, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg4), v0);
        let v4 = v2;
        let (v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T2, T3>(arg5, arg3, arg4, v4, 0x2::balance::zero<T3>(), true, true, 0x2::balance::value<T2>(&v4), 0, 4295048016 + 1);
        let v7 = BluefinAdapter{dummy_field: false};
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::repay<BluefinAdapter, T0, T1, T2, T3>(arg0, v1, v3, v5, v6, v7)
    }

    public fun b_to_a<T0, T1, T2, T3>(arg0: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::AgentPass, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg2: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T3>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock) : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::Swap<T0, T1, T2> {
        let v0 = BluefinAdapter{dummy_field: false};
        let (v1, v2, v3) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::lend<BluefinAdapter, T0, T1, T3>(arg0, arg1, arg2, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg4), v0);
        let v4 = v2;
        let (v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T2, T3>(arg5, arg3, arg4, 0x2::balance::zero<T2>(), v4, false, true, 0x2::balance::value<T3>(&v4), 0, 79226673515401279992447579055 - 1);
        let v7 = BluefinAdapter{dummy_field: false};
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass::repay<BluefinAdapter, T0, T1, T3, T2>(arg0, v1, v3, v6, v5, v7)
    }

    // decompiled from Move bytecode v7
}

