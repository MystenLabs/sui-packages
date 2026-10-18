module 0x3b9d00fb8e247324efc021aa5cf2dbce9778aad2e9a6a520e0e98cfc0605efb3::bluefin {
    struct Flash<phantom T0, phantom T1> {
        receipt: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>,
    }

    public fun repay_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: Flash<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let Flash { receipt: v0 } = arg2;
        if (0x1::option::is_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&v0)) {
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v0);
            return arg3
        };
        0x30988dbb5ce4d54c1cec8e026f99868fbc9adc76195a71cb1ed3ff00901fab7f::bluefin::repay_a2b<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v0), arg3)
    }

    public fun repay_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: Flash<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        let Flash { receipt: v0 } = arg2;
        if (0x1::option::is_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&v0)) {
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v0);
            return arg3
        };
        0x30988dbb5ce4d54c1cec8e026f99868fbc9adc76195a71cb1ed3ff00901fab7f::bluefin::repay_b2a<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v0), arg3)
    }

    public fun swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        0x30988dbb5ce4d54c1cec8e026f99868fbc9adc76195a71cb1ed3ff00901fab7f::bluefin::swap_a2b<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        0x30988dbb5ce4d54c1cec8e026f99868fbc9adc76195a71cb1ed3ff00901fab7f::bluefin::swap_b2a<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun flash_a2b<T0, T1>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (0x2::balance::Balance<T1>, Flash<T0, T1>) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Flash<T0, T1>{receipt: 0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>()};
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3) = 0x30988dbb5ce4d54c1cec8e026f99868fbc9adc76195a71cb1ed3ff00901fab7f::bluefin::flash_out_a2b<T0, T1>(arg2, arg3, arg4, v0);
        let v4 = Flash<T0, T1>{receipt: 0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v3)};
        (v2, v4)
    }

    public fun flash_b2a<T0, T1>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (0x2::balance::Balance<T0>, Flash<T0, T1>) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Flash<T0, T1>{receipt: 0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>()};
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3) = 0x30988dbb5ce4d54c1cec8e026f99868fbc9adc76195a71cb1ed3ff00901fab7f::bluefin::flash_out_b2a<T0, T1>(arg2, arg3, arg4, v0);
        let v4 = Flash<T0, T1>{receipt: 0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v3)};
        (v2, v4)
    }

    public fun limit(arg0: u128, arg1: bool, arg2: u64) : u128 {
        let v0 = if (arg2 == 0) {
            arg0
        } else {
            arg0 / 20000 * (arg2 as u128)
        };
        if (arg1) {
            let v2 = if (v0 >= arg0) {
                4295048017
            } else {
                arg0 - v0
            };
            let v3 = if (v2 < 4295048017) {
                4295048017
            } else {
                v2
            };
            if (v3 < arg0) {
                v3
            } else {
                0
            }
        } else {
            let v4 = if (arg0 < 79226673515401279992447579054) {
                arg0
            } else {
                79226673515401279992447579054
            };
            let v5 = if (arg2 == 0 || v0 >= 79226673515401279992447579054 - v4) {
                79226673515401279992447579054
            } else {
                arg0 + v0
            };
            if (v5 > arg0) {
                v5
            } else {
                0
            }
        }
    }

    public fun out<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u128) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, true, arg2, arg3);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0) || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) > 0) {
            return 0
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0)
    }

    fun quote<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool, arg3: u64) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::begin(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1));
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = vector[];
        let v3 = if (v1 == 0) {
            0
        } else {
            limit(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), arg2, arg3)
        };
        let v4 = 0;
        while (v4 < v1) {
            let v5 = if (v3 == 0) {
                0
            } else {
                out<T0, T1>(arg1, arg2, *0x1::vector::borrow<u64>(&v0, v4), v3)
            };
            0x1::vector::push_back<u64>(&mut v2, v5);
            v4 = v4 + 1;
        };
        0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::end(arg0, v2);
    }

    public fun quote_a2b<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u64) {
        quote<T0, T1>(arg0, arg1, true, arg2);
    }

    public fun quote_b2a<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u64) {
        quote<T0, T1>(arg0, arg1, false, arg2);
    }

    // decompiled from Move bytecode v7
}

