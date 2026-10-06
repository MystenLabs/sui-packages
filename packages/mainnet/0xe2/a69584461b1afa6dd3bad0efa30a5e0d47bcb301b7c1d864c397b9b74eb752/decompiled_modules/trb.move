module 0xe2a69584461b1afa6dd3bad0efa30a5e0d47bcb301b7c1d864c397b9b74eb752::trb {
    public fun a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, 0x2::coin::value<T0>(&arg1), 0, arg2, true, 0x2::tx_context::sender(arg5), 18446744073709551615, arg3, arg4, arg5);
        0xe2a69584461b1afa6dd3bad0efa30a5e0d47bcb301b7c1d864c397b9b74eb752::u::rt<T0>(v2, 0x2::tx_context::sender(arg5));
        v1
    }

    public fun b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v0, 0x2::coin::value<T1>(&arg1), 0, arg2, true, 0x2::tx_context::sender(arg5), 18446744073709551615, arg3, arg4, arg5);
        0xe2a69584461b1afa6dd3bad0efa30a5e0d47bcb301b7c1d864c397b9b74eb752::u::rt<T1>(v2, 0x2::tx_context::sender(arg5));
        v1
    }

    // decompiled from Move bytecode v7
}

