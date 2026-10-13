module 0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::tb {
    public fun sab<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, 0x2::coin::value<T0>(&arg1), arg2, 4295048016, true, 0x2::tx_context::sender(arg5), 18446744073709551615, arg3, arg4, arg5);
        0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::util::tod<T0>(v2, 0x2::tx_context::sender(arg5));
        v1
    }

    public fun sba<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v0, 0x2::coin::value<T1>(&arg1), arg2, 79226673515401279992447579055, true, 0x2::tx_context::sender(arg5), 18446744073709551615, arg3, arg4, arg5);
        0x5f1518830b0ad7f76270d87cf1f338c48e4acf49027ba815f623fee1f3ac3c08::util::tod<T1>(v2, 0x2::tx_context::sender(arg5));
        v1
    }

    // decompiled from Move bytecode v7
}

