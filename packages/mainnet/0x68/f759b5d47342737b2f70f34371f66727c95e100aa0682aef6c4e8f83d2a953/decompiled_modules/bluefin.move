module 0x68f759b5d47342737b2f70f34371f66727c95e100aa0682aef6c4e8f83d2a953::bluefin {
    struct BluefinSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg0, arg1, true, true, v0, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(v0 >= v5, 1);
        let v6 = 0x2::coin::from_balance<T1>(v2, arg6);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v5, arg6)), 0x2::balance::zero<T1>(), v4);
        let v7 = BluefinSwapEvent{
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T1>(&v6),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::with_defining_ids<T0>(),
            coin_b       : 0x1::type_name::with_defining_ids<T1>(),
        };
        0x2::event::emit<BluefinSwapEvent>(v7);
        assert!(0x2::coin::value<T1>(&v6) >= arg3, 2);
        (v6, arg2)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg0, arg1, false, true, v0, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(v0 >= v5, 1);
        let v6 = 0x2::coin::from_balance<T0>(v1, arg6);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg6)), v4);
        let v7 = BluefinSwapEvent{
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T0>(&v6),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::with_defining_ids<T0>(),
            coin_b       : 0x1::type_name::with_defining_ids<T1>(),
        };
        0x2::event::emit<BluefinSwapEvent>(v7);
        assert!(0x2::coin::value<T0>(&v6) >= arg3, 2);
        (v6, arg2)
    }

    // decompiled from Move bytecode v6
}

