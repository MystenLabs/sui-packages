module 0x4f46f18c28a73bbbb496719e90cfe4aaaac8b4fc5fba3218c2a7530e05a3955::turbos {
    public fun swap_a2b<T0, T1, T2>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg2, v0, 0x2::coin::value<T0>(&arg1), 0, 4295048016, true, 0x2::tx_context::sender(arg5), 3000000000000, arg3, arg4, arg5);
        let v3 = v2;
        if (0x2::coin::value<T0>(&v3) == 0) {
            0x2::coin::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg5));
        };
        v1
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg2, v0, 0x2::coin::value<T1>(&arg1), 0, 79226673515401279992447579055, true, 0x2::tx_context::sender(arg5), 3000000000000, arg3, arg4, arg5);
        let v3 = v2;
        if (0x2::coin::value<T1>(&v3) == 0) {
            0x2::coin::destroy_zero<T1>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg5));
        };
        v1
    }

    // decompiled from Move bytecode v7
}

