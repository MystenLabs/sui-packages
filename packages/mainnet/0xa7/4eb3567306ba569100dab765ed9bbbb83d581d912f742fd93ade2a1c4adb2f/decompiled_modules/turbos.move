module 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::turbos {
    public fun swap_a_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T1>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T1>(arg9, arg7, arg11);
        let v2 = v1;
        let v3 = v0;
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg1, 0x2::coin::from_balance<T0>(v3, arg11));
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T1>(arg3, &v2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg0, arg1, 0x2::balance::value<T0>(&v3), arg3, arg4, arg5, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T1>(arg9), arg6, arg7, arg8, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T1>(arg9, v2, arg10, arg11), 0x2::tx_context::sender(arg11));
    }

    public fun swap_a_b_b_c<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T4>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T4>(arg10, arg8, arg12);
        let v2 = v1;
        let v3 = v0;
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg2, 0x2::coin::from_balance<T0>(v3, arg12));
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T4>(arg4, &v2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_b_c<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::value<T0>(&v3), arg4, arg5, arg6, true, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T4>(arg10), arg7, arg8, arg9, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T4>(arg10, v2, arg11, arg12), 0x2::tx_context::sender(arg12));
    }

    public fun swap_a_b_c_b<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T4>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T4>(arg10, arg8, arg12);
        let v2 = v1;
        let v3 = v0;
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg2, 0x2::coin::from_balance<T0>(v3, arg12));
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T4>(arg4, &v2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_c_b<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::value<T0>(&v3), arg4, arg5, arg6, true, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T4>(arg10), arg7, arg8, arg9, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T4>(arg10, v2, arg11, arg12), 0x2::tx_context::sender(arg12));
    }

    public fun swap_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T1, T0>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T1, T0>(arg8, arg6, arg10);
        let v2 = v1;
        let v3 = v0;
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut arg1, 0x2::coin::from_balance<T1>(v3, arg10));
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T1, T0>(arg3, &v2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg0, arg1, 0x2::balance::value<T1>(&v3), arg3, arg4, true, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T1, T0>(arg8), arg5, arg6, arg7, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T1, T0>(arg8, v2, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public fun swap_b_a_b_c<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T4>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T4>(arg10, arg8, arg12);
        let v2 = v1;
        let v3 = v0;
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg2, 0x2::coin::from_balance<T0>(v3, arg12));
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T4>(arg4, &v2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_b_c<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::value<T0>(&v3), arg4, arg5, arg6, true, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T4>(arg10), arg7, arg8, arg9, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T4>(arg10, v2, arg11, arg12), 0x2::tx_context::sender(arg12));
    }

    public fun swap_b_a_c_b<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T4>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T4>(arg10, arg8, arg12);
        let v2 = v1;
        let v3 = v0;
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg2, 0x2::coin::from_balance<T0>(v3, arg12));
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T4>(arg4, &v2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_c_b<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::value<T0>(&v3), arg4, arg5, arg6, true, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T4>(arg10), arg7, arg8, arg9, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T4>(arg10, v2, arg11, arg12), 0x2::tx_context::sender(arg12));
    }

    // decompiled from Move bytecode v6
}

