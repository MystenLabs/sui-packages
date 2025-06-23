module 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::turbos_clmm_protocol {
    public(friend) fun swap<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::dex_utils::check_amounts<T0, T1>(&arg1, &arg2);
        let v0 = 0x2::coin::zero<T0>(arg5);
        let v1 = 0x2::coin::zero<T1>(arg5);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::coin::destroy_zero<T1>(arg2);
            let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T0>>(arg1), 0x2::coin::value<T0>(&arg1), 1000, 4295048016, true, 0x2::tx_context::sender(arg5), 9999999999999, arg4, arg3, arg5);
            0x2::coin::join<T0>(&mut v0, v3);
            0x2::coin::join<T1>(&mut v1, v2);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
            let (v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T1>>(arg2), 0x2::coin::value<T1>(&arg2), 1000, 79226673515401279992447579055, true, 0x2::tx_context::sender(arg5), 9999999999999, arg4, arg3, arg5);
            0x2::coin::join<T0>(&mut v0, v4);
            0x2::coin::join<T1>(&mut v1, v5);
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

