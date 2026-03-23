module 0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::turbos {
    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::SwapContext, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::take_balance<T0>(arg0);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::from_balance<T0>(v0, arg4));
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v1, 0x2::balance::value<T0>(&v0), 0, 4295048016, true, @0x0, 18446744073709551615, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(v3));
        0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::SwapContext, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::take_balance<T1>(arg0);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, 0x2::coin::from_balance<T1>(v0, arg4));
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v1, 0x2::balance::value<T1>(&v0), 0, 79226673515401279992447579055, true, @0x0, 18446744073709551615, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T1>(0x2::coin::into_balance<T1>(v3));
        0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
    }

    // decompiled from Move bytecode v6
}

