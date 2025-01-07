module 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::swap {
    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg7);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let v1 = 0x2::coin::zero<T1>(arg7);
        0x2::pay::join_vec<T1>(&mut v1, arg2);
        let (v2, v3, v4) = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::pool::add_liquidity<T0, T1>(arg0, v0, v1, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::pool::LPCoin<T0, T1>>>(v2, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg7));
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::global::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::global::exist_pool<T0, T1>(arg0) || !0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::global::exist_pool<T1, T1>(arg0), 2);
        0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::global::add_pool_flag<T0, T1>(arg0, 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::pool::create_pool<T0, T1>(arg1));
    }

    public entry fun swap_x_to_y<T0, T1>(arg0: &mut 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg4);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let (v1, v2) = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::pool::swap_x_to_y<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v0, arg2, arg4), arg3, arg4);
        assert!(v2 >= arg3, 1);
        let v3 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v3);
    }

    public entry fun swap_y_to_x<T0, T1>(arg0: &mut 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg4);
        0x2::pay::join_vec<T1>(&mut v0, arg1);
        let (v1, v2) = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::pool::swap_y_to_x<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v0, arg2, arg4), arg3, arg4);
        assert!(v2 >= arg3, 1);
        let v3 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v3);
    }

    // decompiled from Move bytecode v6
}

