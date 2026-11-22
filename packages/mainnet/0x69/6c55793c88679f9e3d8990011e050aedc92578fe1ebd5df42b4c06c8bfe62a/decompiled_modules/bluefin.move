module 0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::bluefin {
    struct Ticket<phantom T0, phantom T1> {
        plan: 0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::Plan,
        receipt: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>,
    }

    public fun finish_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: Ticket<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan    : v0,
            receipt : v1,
        } = arg3;
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&v2)) {
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v2);
            0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::finish<T0>(v3, arg2, 0, arg4);
            return
        };
        let v4 = 0x1::option::destroy_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v2);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::repay<T0>(&v3, &mut arg2, v5), 0x2::balance::zero<T1>(), v4);
        0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::finish<T0>(v3, arg2, v5, arg4);
    }

    public fun finish_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: Ticket<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            plan    : v0,
            receipt : v1,
        } = arg3;
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&v2)) {
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v2);
            0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::finish<T1>(v3, arg2, 0, arg4);
            return
        };
        let v4 = 0x1::option::destroy_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v2);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::repay<T1>(&v3, &mut arg2, v5), v4);
        0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::finish<T1>(v3, arg2, v5, arg4);
    }

    fun limit<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool) : u128 {
        let v0 = if (arg1) {
            (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0) as u256) * 975 / 1000
        } else {
            (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0) as u256) * 1025 / 1000
        };
        if (v0 <= 4295048017) {
            4295048017
        } else if (v0 >= 79226673515401279992447579054) {
            79226673515401279992447579054
        } else {
            (v0 as u128)
        }
    }

    public fun quote<T0, T1>(arg0: &mut 0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::Plan, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool) {
        0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::hop<T0, T1>(arg0, 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), arg2);
        let v0 = 0;
        while (v0 < 0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::count(arg0)) {
            let v1 = 0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::input(arg0, v0);
            let v2 = if (v1 == 0) {
                0
            } else {
                let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, arg2, true, v1, limit<T0, T1>(arg1, arg2));
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v3) || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v3) != 0) {
                    0
                } else {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v3)
                }
            };
            0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::output(arg0, v0, v2);
            v0 = v0 + 1;
        };
    }

    public fun start_a2b<T0, T1>(arg0: 0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::Plan, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Ticket<T0, T1>) {
        let v0 = 0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::choose<T0>(&mut arg0, 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2));
        if (v0 == 0) {
            let v1 = Ticket<T0, T1>{
                plan    : arg0,
                receipt : 0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(),
            };
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg1, arg2, true, true, v0, limit<T0, T1>(arg2, true));
        0x2::balance::destroy_zero<T0>(v2);
        let v5 = Ticket<T0, T1>{
            plan    : arg0,
            receipt : 0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v4),
        };
        (v3, v5)
    }

    public fun start_b2a<T0, T1>(arg0: 0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::Plan, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Ticket<T0, T1>) {
        let v0 = 0x696c55793c88679f9e3d8990011e050aedc92578fe1ebd5df42b4c06c8bfe62a::plan::choose<T1>(&mut arg0, 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2));
        if (v0 == 0) {
            let v1 = Ticket<T0, T1>{
                plan    : arg0,
                receipt : 0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(),
            };
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg1, arg2, false, true, v0, limit<T0, T1>(arg2, false));
        0x2::balance::destroy_zero<T1>(v3);
        let v5 = Ticket<T0, T1>{
            plan    : arg0,
            receipt : 0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v4),
        };
        (v2, v5)
    }

    public fun swap_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, v0, limit<T0, T1>(arg1, true));
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T0>(arg2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, true, v0, limit<T0, T1>(arg1, false));
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        0x2::balance::destroy_zero<T1>(arg2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        v1
    }

    // decompiled from Move bytecode v7
}

