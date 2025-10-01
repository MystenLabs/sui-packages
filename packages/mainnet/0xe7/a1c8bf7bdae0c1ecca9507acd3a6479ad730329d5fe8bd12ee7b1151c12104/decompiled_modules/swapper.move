module 0xe7a1c8bf7bdae0c1ecca9507acd3a6479ad730329d5fe8bd12ee7b1151c12104::swapper {
    public entry fun swap_a_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, arg1);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v1, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11);
        0x2::coin::join<T0>(&mut arg2, v3);
        0x2::coin::join<T1>(&mut arg3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, v0);
    }

    public entry fun swap_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u128, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, arg1);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v1, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11);
        0x2::coin::join<T0>(&mut arg2, v2);
        0x2::coin::join<T1>(&mut arg3, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, v0);
    }

    // decompiled from Move bytecode v6
}

