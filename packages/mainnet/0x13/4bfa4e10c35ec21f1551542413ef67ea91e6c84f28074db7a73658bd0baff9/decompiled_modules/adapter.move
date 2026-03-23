module 0x134bfa4e10c35ec21f1551542413ef67ea91e6c84f28074db7a73658bd0baff9::adapter {
    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::SwapContext, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::take_balance<T0>(arg0);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::from_balance<T0>(v0, arg4));
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v1, 0x2::balance::value<T0>(&v0), 0, 4295048016, true, @0x0, 18446744073709551615, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(v3));
        0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::SwapContext, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::take_balance<T1>(arg0);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, 0x2::coin::from_balance<T1>(v0, arg4));
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v1, 0x2::balance::value<T1>(&v0), 0, 79226673515401279992447579055, true, @0x0, 18446744073709551615, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T1>(0x2::coin::into_balance<T1>(v3));
        0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
    }

    // decompiled from Move bytecode v6
}

