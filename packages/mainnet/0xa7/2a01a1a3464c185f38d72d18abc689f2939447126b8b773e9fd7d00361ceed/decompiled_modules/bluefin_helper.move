module 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::bluefin_helper {
    public entry fun collect_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::utils::transfer_balance<T2>(v0, 0x2::tx_context::sender(arg4), arg4);
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

