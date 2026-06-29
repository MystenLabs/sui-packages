module 0xc7a08abf23e901d253f149c67673bdaaef8da1abb8cbbaf2609934feb0c5dab0::turbos {
    public fun a2b<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v0, 0x2::coin::value<T0>(&arg0), 0, 0xc7a08abf23e901d253f149c67673bdaaef8da1abb8cbbaf2609934feb0c5dab0::self::min_sqrt_price(), true, 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg3) + 1000, arg3, arg2, arg4);
        0xc7a08abf23e901d253f149c67673bdaaef8da1abb8cbbaf2609934feb0c5dab0::self::transfer_or_destroy_coin<T0>(v2, arg4);
        v1
    }

    public fun b2a<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg0);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v0, 0x2::coin::value<T1>(&arg0), 0, 0xc7a08abf23e901d253f149c67673bdaaef8da1abb8cbbaf2609934feb0c5dab0::self::max_sqrt_price(), true, 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg3) + 1000, arg3, arg2, arg4);
        0xc7a08abf23e901d253f149c67673bdaaef8da1abb8cbbaf2609934feb0c5dab0::self::transfer_or_destroy_coin<T1>(v2, arg4);
        v1
    }

    // decompiled from Move bytecode v7
}

