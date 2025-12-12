module 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::bluefin {
    public fun swap<T0, T1, T2, T3>(arg0: &mut 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::Payload<T2, T3>, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        if (arg4) {
            0x2::balance::join<T0>(&mut v0, 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::take_next<T2, T3, T0>(arg0));
        } else {
            0x2::balance::join<T1>(&mut v1, 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::take_next<T2, T3, T1>(arg0));
        };
        let v2 = if (arg4) {
            0x2::balance::value<T0>(&v0)
        } else {
            0x2::balance::value<T1>(&v1)
        };
        let (v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg1, arg2, arg3, v0, v1, arg4, arg5, v2, arg6, arg7);
        let v5 = v4;
        let v6 = v3;
        if (arg4) {
            0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::place_next<T2, T3, T1>(arg0, v5);
            if (0x2::balance::value<T0>(&v6) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg8), 0x2::tx_context::sender(arg8));
            } else {
                0x2::balance::destroy_zero<T0>(v6);
            };
        } else {
            0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::place_next<T2, T3, T0>(arg0, v6);
            if (0x2::balance::value<T1>(&v5) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg8), 0x2::tx_context::sender(arg8));
            } else {
                0x2::balance::destroy_zero<T1>(v5);
            };
        };
    }

    // decompiled from Move bytecode v6
}

