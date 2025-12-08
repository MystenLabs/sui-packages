module 0x762bd465d90bccaf4cdc91bae253b67b8862ad3f177727d7b0df611fdc2ef0bf::t {
    public fun sxy<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T0>>(arg1), 0x2::coin::value<T0>(&arg1), 0, arg2, true, 0x2::tx_context::sender(arg5), 18446744073709551615, arg3, arg4, arg5);
        0x762bd465d90bccaf4cdc91bae253b67b8862ad3f177727d7b0df611fdc2ef0bf::u::tod<T0>(v1, 0x2::tx_context::sender(arg5));
        v0
    }

    public fun syx<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T1>>(arg1), 0x2::coin::value<T1>(&arg1), 0, arg2, true, 0x2::tx_context::sender(arg5), 18446744073709551615, arg3, arg4, arg5);
        0x762bd465d90bccaf4cdc91bae253b67b8862ad3f177727d7b0df611fdc2ef0bf::u::tod<T1>(v1, 0x2::tx_context::sender(arg5));
        v0
    }

    // decompiled from Move bytecode v6
}

