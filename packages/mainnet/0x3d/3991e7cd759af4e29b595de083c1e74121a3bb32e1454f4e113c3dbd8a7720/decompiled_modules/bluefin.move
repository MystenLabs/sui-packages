module 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin {
    public fun swap<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: bool, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (arg3) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v1 = if (arg3) {
            0x2::balance::value<T0>(&arg1)
        } else {
            0x2::balance::value<T1>(&arg2)
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg5, arg4, arg0, arg1, arg2, arg3, true, v1, 0, v0)
    }

    public fun calculate<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let v0 = if (arg1) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, true, arg2, v0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v1)
    }

    // decompiled from Move bytecode v6
}

