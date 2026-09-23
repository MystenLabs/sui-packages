module 0x827f05c943d9d08027e7113beb1c3de5d05898dc1462441bbbd522607702ba28::bluefin {
    public(friend) fun a2b<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 > 0, 1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg2, arg1, arg0, arg3, 0x2::balance::zero<T1>(), true, true, v0, 1, limit(true))
    }

    public(friend) fun b2a<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg3);
        assert!(v0 > 0, 1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg2, arg1, arg0, 0x2::balance::zero<T0>(), arg3, false, true, v0, 1, limit(false))
    }

    fun limit(arg0: bool) : u128 {
        if (arg0) {
            4295048017
        } else {
            79226673515401279992447579054
        }
    }

    public(friend) fun quote<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg2, true, arg1, limit(arg2));
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0) || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) != 0) {
            return 0
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0)
    }

    // decompiled from Move bytecode v7
}

