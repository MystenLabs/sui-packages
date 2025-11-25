module 0x1ee86ed439ee2e64ec2b42289eebe6f999dbe4e6a8c27b784b04ee8f570f3cc3::bluefin {
    public fun a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg2, arg1, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), true, true, 0x2::coin::value<T0>(&arg0), 0, 4295048016);
        0x1ee86ed439ee2e64ec2b42289eebe6f999dbe4e6a8c27b784b04ee8f570f3cc3::self_utils::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg4), arg4);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg2, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), false, true, 0x2::coin::value<T1>(&arg0), 0, 79226673515401279992447579055);
        0x1ee86ed439ee2e64ec2b42289eebe6f999dbe4e6a8c27b784b04ee8f570f3cc3::self_utils::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg4), arg4);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    // decompiled from Move bytecode v6
}

