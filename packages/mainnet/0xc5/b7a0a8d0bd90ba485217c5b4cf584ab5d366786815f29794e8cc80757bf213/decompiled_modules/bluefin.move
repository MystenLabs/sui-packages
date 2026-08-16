module 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::bluefin {
    fun eval<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: u64, arg3: bool) {
        let v0 = if (arg3) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let v1 = 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::hop_inputs<T0>(arg0, arg2);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v1)) {
            let v4 = *0x1::vector::borrow<u64>(&v1, v3);
            let v5 = if (v4 == 0) {
                0
            } else {
                let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, T2>(arg1, arg3, true, v4, v0);
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v6) > 0) {
                    0
                } else {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6)
                }
            };
            0x1::vector::push_back<u64>(&mut v2, v5);
            v3 = v3 + 1;
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::record_hop<T0>(arg0, arg2, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg1), v2);
    }

    public fun eval_a2b<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: u64) {
        eval<T0, T1, T2>(arg0, arg1, arg2, true);
    }

    public fun eval_b2a<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg2: u64) {
        eval<T0, T1, T2>(arg0, arg1, arg2, false);
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        let (v0, v1) = swap_a2b_partial<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    public fun swap_a2b_partial<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        if (!0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::is_selected<T0>(arg0, arg3)) {
            return (0x2::balance::zero<T2>(), arg4)
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::advance<T0>(arg0, arg3, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg2));
        let v0 = 0x2::balance::value<T1>(&arg4);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg5, arg1, arg2, true, true, v0, 4295048016 + 1);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v1);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v4);
        assert!(v5 <= v0, 1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg2, 0x2::balance::split<T1>(&mut arg4, v5), 0x2::balance::zero<T2>(), v4);
        (v2, arg4)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: u64, arg4: 0x2::balance::Balance<T2>, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1) = swap_b2a_partial<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::balance::destroy_zero<T2>(v1);
        v0
    }

    public fun swap_b2a_partial<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: u64, arg4: 0x2::balance::Balance<T2>, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        if (!0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::is_selected<T0>(arg0, arg3)) {
            return (0x2::balance::zero<T1>(), arg4)
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::advance<T0>(arg0, arg3, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg2));
        let v0 = 0x2::balance::value<T2>(&arg4);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg5, arg1, arg2, false, true, v0, 79226673515401279992447579055 - 1);
        let v4 = v3;
        0x2::balance::destroy_zero<T2>(v2);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v4);
        assert!(v5 <= v0, 1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg4, v5), v4);
        (v1, arg4)
    }

    // decompiled from Move bytecode v7
}

