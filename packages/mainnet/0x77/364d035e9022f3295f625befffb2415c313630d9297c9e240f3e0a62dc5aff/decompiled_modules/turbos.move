module 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::turbos {
    public fun swap_a_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: u128, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::DCA<T0, T1>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::init_trade<T0, T1>(arg7, arg5, arg9);
        let v2 = v1;
        let v3 = v0;
        assert!(arg1 >= 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::trade_min_output<T0, T1>(&v2), 1);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, v3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg0, v4, 0x2::coin::value<T0>(&v3), arg1, arg2, arg3, 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::owner<T0, T1>(arg7), arg4, arg5, arg6, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::resolve_trade<T0, T1>(arg7, v2, arg8, arg9), 0x2::tx_context::sender(arg9));
    }

    public fun swap_a_b_b_c<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: u64, arg3: u128, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::DCA<T0, T4>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::init_trade<T0, T4>(arg8, arg6, arg10);
        let v2 = v1;
        let v3 = v0;
        assert!(arg2 >= 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::trade_min_output<T0, T4>(&v2), 1);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, v3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_b_c<T0, T1, T2, T3, T4>(arg0, arg1, v4, 0x2::coin::value<T0>(&v3), arg2, arg3, arg4, true, 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::owner<T0, T4>(arg8), arg5, arg6, arg7, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::resolve_trade<T0, T4>(arg8, v2, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public fun swap_a_b_c_b<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: u64, arg3: u128, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::DCA<T0, T4>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::init_trade<T0, T4>(arg8, arg6, arg10);
        let v2 = v1;
        let v3 = v0;
        assert!(arg2 >= 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::trade_min_output<T0, T4>(&v2), 1);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, v3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_c_b<T0, T1, T2, T3, T4>(arg0, arg1, v4, 0x2::coin::value<T0>(&v3), arg2, arg3, arg4, true, 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::owner<T0, T4>(arg8), arg5, arg6, arg7, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::resolve_trade<T0, T4>(arg8, v2, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public fun swap_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: u128, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::DCA<T1, T0>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::init_trade<T1, T0>(arg6, arg4, arg8);
        let v2 = v1;
        let v3 = v0;
        assert!(arg1 >= 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::trade_min_output<T1, T0>(&v2), 1);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v4, v3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg0, v4, 0x2::coin::value<T1>(&v3), arg1, arg2, true, 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::owner<T1, T0>(arg6), arg3, arg4, arg5, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::resolve_trade<T1, T0>(arg6, v2, arg7, arg8), 0x2::tx_context::sender(arg8));
    }

    public fun swap_b_a_b_c<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: u64, arg3: u128, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::DCA<T0, T4>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::init_trade<T0, T4>(arg8, arg6, arg10);
        let v2 = v1;
        let v3 = v0;
        assert!(arg2 >= 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::trade_min_output<T0, T4>(&v2), 1);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, v3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_b_c<T0, T1, T2, T3, T4>(arg0, arg1, v4, 0x2::coin::value<T0>(&v3), arg2, arg3, arg4, true, 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::owner<T0, T4>(arg8), arg5, arg6, arg7, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::resolve_trade<T0, T4>(arg8, v2, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public fun swap_b_a_c_b<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: u64, arg3: u128, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::DCA<T0, T4>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::init_trade<T0, T4>(arg8, arg6, arg10);
        let v2 = v1;
        let v3 = v0;
        assert!(arg2 >= 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::trade_min_output<T0, T4>(&v2), 1);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, v3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_c_b<T0, T1, T2, T3, T4>(arg0, arg1, v4, 0x2::coin::value<T0>(&v3), arg2, arg3, arg4, true, 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::owner<T0, T4>(arg8), arg5, arg6, arg7, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::dca::resolve_trade<T0, T4>(arg8, v2, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    // decompiled from Move bytecode v6
}

