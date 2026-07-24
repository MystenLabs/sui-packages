module 0x4a40dcf3a20e57030b830adcb9e9ca05b832d4996cb55817d1a2ec9dbd0b3b57::m {
    public fun tc<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u128, arg4: u64, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::from_balance<T0>(arg1, arg7));
        let v1 = 0x2::tx_context::sender(arg7);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, 0x2::balance::value<T0>(&arg1), arg2, arg3, true, v1, arg4, arg6, arg5, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        0x2::coin::into_balance<T1>(v2)
    }

    public fun td<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: u128, arg4: u64, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::from_balance<T1>(arg1, arg7));
        let v1 = 0x2::tx_context::sender(arg7);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v0, 0x2::balance::value<T1>(&arg1), arg2, arg3, true, v1, arg4, arg6, arg5, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v1);
        0x2::coin::into_balance<T0>(v2)
    }

    // decompiled from Move bytecode v7
}

