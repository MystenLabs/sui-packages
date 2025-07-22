module 0xb9e781e56d8018c8605369799c63750cacb224eb6306f032a7542c1338c10a1a::turbos {
    public fun swap_a_b_with_return_<T0, T1, T2, T3, T4>(arg0: &mut 0xb9e781e56d8018c8605369799c63750cacb224eb6306f032a7542c1338c10a1a::checkpoint::Payload<T3, T4>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: bool, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb9e781e56d8018c8605369799c63750cacb224eb6306f032a7542c1338c10a1a::checkpoint::take_next<T3, T4, T0>(arg0);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, v0);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v1, 0x2::coin::value<T0>(&v0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::coin::destroy_zero<T0>(v3);
        0xb9e781e56d8018c8605369799c63750cacb224eb6306f032a7542c1338c10a1a::checkpoint::place_next<T3, T4, T1>(arg0, v2);
    }

    public fun swap_b_a_with_return_<T0, T1, T2, T3, T4>(arg0: &mut 0xb9e781e56d8018c8605369799c63750cacb224eb6306f032a7542c1338c10a1a::checkpoint::Payload<T3, T4>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: bool, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb9e781e56d8018c8605369799c63750cacb224eb6306f032a7542c1338c10a1a::checkpoint::take_next<T3, T4, T1>(arg0);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, v0);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v1, 0x2::coin::value<T1>(&v0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::coin::destroy_zero<T1>(v3);
        0xb9e781e56d8018c8605369799c63750cacb224eb6306f032a7542c1338c10a1a::checkpoint::place_next<T3, T4, T0>(arg0, v2);
    }

    // decompiled from Move bytecode v6
}

