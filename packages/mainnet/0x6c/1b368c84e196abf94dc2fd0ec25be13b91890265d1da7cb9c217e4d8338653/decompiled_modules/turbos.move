module 0x6c1b368c84e196abf94dc2fd0ec25be13b91890265d1da7cb9c217e4d8338653::turbos {
    fun coins_amount<T0>(arg0: &vector<0x2::coin::Coin<T0>>) : u64 {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(arg0) > 0, 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<T0>>(arg0)) {
            v0 = v0 + 0x2::coin::value<T0>(0x1::vector::borrow<0x2::coin::Coin<T0>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun swap_a_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u128, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, arg1, coins_amount<T0>(&arg1), arg2, arg3, arg4, @0x0, arg5, arg6, arg7, arg8);
        (v1, v0)
    }

    public fun swap_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u128, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, arg1, coins_amount<T1>(&arg1), arg2, arg3, arg4, @0x0, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v6
}

