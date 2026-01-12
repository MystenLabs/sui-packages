module 0xd47c3a1764dd4021b473bed63774f5576066d0dbe7c82a7094e18e6388e98bea::closer {
    public fun close_no_rewards<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::close_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun close_with_one_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg4), 0x2::balance::zero<T1>(), true, true, 0x2::coin::value<T0>(&arg4), 0, 4295048016 + 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg6), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg6), arg5);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3, arg6);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::close_position<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
    }

    public fun close_with_two_rewards<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg4), 0x2::balance::zero<T1>(), true, true, 0x2::coin::value<T0>(&arg4), 0, 4295048016 + 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg6), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg6), arg5);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3, arg6);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<T0, T1, T3>(arg0, arg1, arg2, &mut arg3, arg6);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::close_position<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

