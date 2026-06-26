module 0x443bc2aaa0147c8a8967eeaf6cb90b3a4b6c2e09a21623e10f3f9d514d4543a4::turbos_adapter {
    fun return_change<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public fun swap_exact_in_a_to_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, arg1);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v1, 0x2::coin::value<T0>(&arg1), arg2, 4295048016 + 1, true, v0, 0x2::clock::timestamp_ms(arg3) + 3600000, arg3, arg4, arg5);
        let v4 = v2;
        return_change<T0>(v3, v0);
        assert!(0x2::coin::value<T1>(&v4) >= arg2, 1);
        v4
    }

    public fun swap_exact_in_b_to_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, arg1);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v1, 0x2::coin::value<T1>(&arg1), arg2, 79226673515401279992447579055 - 1, true, v0, 0x2::clock::timestamp_ms(arg3) + 3600000, arg3, arg4, arg5);
        let v4 = v2;
        return_change<T1>(v3, v0);
        assert!(0x2::coin::value<T0>(&v4) >= arg2, 1);
        v4
    }

    // decompiled from Move bytecode v7
}

