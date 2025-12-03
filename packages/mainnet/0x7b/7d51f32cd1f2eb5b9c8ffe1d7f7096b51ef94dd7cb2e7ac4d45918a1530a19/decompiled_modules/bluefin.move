module 0x7b7d51f32cd1f2eb5b9c8ffe1d7f7096b51ef94dd7cb2e7ac4d45918a1530a19::bluefin {
    public fun atob<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg0, arg1, 0x2::coin::into_balance<T0>(0x7b7d51f32cd1f2eb5b9c8ffe1d7f7096b51ef94dd7cb2e7ac4d45918a1530a19::help::merge_all<T0>(arg2, arg5)), 0x2::balance::zero<T1>(), true, true, arg3, 0, 4295048017);
        let v2 = v1;
        0x7b7d51f32cd1f2eb5b9c8ffe1d7f7096b51ef94dd7cb2e7ac4d45918a1530a19::help::transfer<T0>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
        (0x2::coin::from_balance<T1>(v2, arg5), 0x2::balance::value<T1>(&v2))
    }

    public fun atob1<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let (v0, v1) = atob<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        (v2, v1)
    }

    public fun btoa<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x7b7d51f32cd1f2eb5b9c8ffe1d7f7096b51ef94dd7cb2e7ac4d45918a1530a19::help::merge_all<T1>(arg2, arg5)), false, true, arg3, 0, 79226673515401279992447579054);
        let v2 = v0;
        0x7b7d51f32cd1f2eb5b9c8ffe1d7f7096b51ef94dd7cb2e7ac4d45918a1530a19::help::transfer<T1>(0x2::coin::from_balance<T1>(v1, arg5), 0x2::tx_context::sender(arg5));
        (0x2::coin::from_balance<T0>(v2, arg5), 0x2::balance::value<T0>(&v2))
    }

    public fun btoa1<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64) {
        let (v0, v1) = btoa<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

