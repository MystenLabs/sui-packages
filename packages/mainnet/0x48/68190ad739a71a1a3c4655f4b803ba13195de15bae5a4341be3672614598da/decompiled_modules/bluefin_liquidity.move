module 0x4868190ad739a71a1a3c4655f4b803ba13195de15bae5a4341be3672614598da::bluefin_liquidity {
    public fun add_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6);
        let v4 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg7), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg7), v4);
    }

    public fun open_and_add_liquidity_with_fixed_amount<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        assert!(0x2::balance::value<T0>(&v0) >= arg8, 1);
        assert!(0x2::balance::value<T1>(&v1) >= arg9, 2);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg11);
        let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v2, 0x2::balance::split<T0>(&mut v0, arg8), 0x2::balance::split<T1>(&mut v1, arg9), arg7, arg10);
        0x2::balance::join<T0>(&mut v0, v5);
        0x2::balance::join<T1>(&mut v1, v6);
        let v7 = 0x2::tx_context::sender(arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg11), v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg11), v7);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v2, v7);
    }

    // decompiled from Move bytecode v6
}

