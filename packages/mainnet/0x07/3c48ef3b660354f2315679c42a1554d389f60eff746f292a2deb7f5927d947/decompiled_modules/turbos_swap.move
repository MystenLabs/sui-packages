module 0x73c48ef3b660354f2315679c42a1554d389f60eff746f292a2deb7f5927d947::turbos_swap {
    public fun swap_by_a_in<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T1>) {
        if (arg2 == 0) {
            arg2 = 0x2::coin::value<T0>(&arg1);
        };
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, arg2, 0, 4295048016, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg3) + 1000, arg3, arg4, arg5);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
        (0x2::coin::value<T1>(&v3), v3)
    }

    public fun swap_by_b_in<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T1>) {
        if (arg2 == 0) {
            arg2 = 0x2::coin::value<T1>(&arg1);
        };
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v0, arg2, 0, 4295048016, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg3) + 1000, arg3, arg4, arg5);
        let v3 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg5));
        (0x2::coin::value<T1>(&v3), v3)
    }

    // decompiled from Move bytecode v6
}

