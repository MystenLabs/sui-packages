module 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::swap {
    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg7);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let v1 = 0x2::coin::zero<T1>(arg7);
        0x2::pay::join_vec<T1>(&mut v1, arg2);
        let (v2, v3, v4) = 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::add_liquidity<T0, T1>(arg0, v0, v1, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::LPCoin<T0, T1>>>(v2, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg7));
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::global::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::global::exist_pool<T0, T1>(arg0) || !0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::global::exist_pool<T1, T0>(arg0), 2);
        0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::global::add_pool_flag<T0, T1>(arg0, 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::create_pool<T0, T1>(arg1, arg2));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::LPCoin<T0, T1>>>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::LPCoin<T0, T1>>(arg5);
        0x2::pay::join_vec<0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::LPCoin<T0, T1>>(&mut v0, arg1);
        let (v1, v2, v3, v4) = 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::remove_liquidity<T0, T1>(arg0, 0x2::coin::split<0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::LPCoin<T0, T1>>(&mut v0, arg2, arg5), arg3, arg4, arg5);
        assert!(v3 >= arg3 && v4 >= arg4, 1);
        let v5 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::LPCoin<T0, T1>>>(v0, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v5);
    }

    public entry fun swap_x_to_y<T0, T1>(arg0: &mut 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg4);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let (v1, v2) = 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::swap_x_to_y<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v0, arg2, arg4), arg3, arg4);
        assert!(v2 >= arg3, 1);
        let v3 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v3);
    }

    public entry fun swap_y_to_x<T0, T1>(arg0: &mut 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::Pool<T1, T0>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg4);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let (v1, v2) = 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::pool::swap_y_to_x<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v0, arg2, arg4), arg3, arg4);
        assert!(v2 >= arg3, 1);
        let v3 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v3);
    }

    // decompiled from Move bytecode v6
}

