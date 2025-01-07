module 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::turbos {
    public fun swap_a_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T1>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T1>(arg10, arg8, arg12);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg1), v3);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T0, T1>(arg3, &v2);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, arg1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg0, v4, 0x2::balance::value<T0>(&v3), arg3, arg4, true, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T1>(arg10), arg7, arg8, arg9, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T1>(arg10, v2, arg11, arg12), 0x2::tx_context::sender(arg12));
    }

    public fun swap_a_b_b_c<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T4>, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T4>(arg12, arg10, arg14);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v3);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T0, T4>(arg4, &v2);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, arg2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_b_c<T0, T1, T2, T3, T4>(arg0, arg1, v4, 0x2::balance::value<T0>(&v3), arg4, arg5, arg6, true, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T4>(arg12), arg9, arg10, arg11, arg14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T4>(arg12, v2, arg13, arg14), 0x2::tx_context::sender(arg14));
    }

    public fun swap_a_b_c_b<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T2, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T4>, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T4>(arg12, arg10, arg14);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v3);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T0, T4>(arg4, &v2);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, arg2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_c_b<T0, T1, T2, T3, T4>(arg0, arg1, v4, 0x2::balance::value<T0>(&v3), arg4, arg5, arg6, true, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T4>(arg12), arg9, arg10, arg11, arg14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T4>(arg12, v2, arg13, arg14), 0x2::tx_context::sender(arg14));
    }

    public fun swap_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T1, T0>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T1, T0>(arg10, arg8, arg12);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(&mut arg1), v3);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T1, T0>(arg3, &v2);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v4, arg1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg0, v4, 0x2::balance::value<T1>(&v3), arg3, arg4, true, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T1, T0>(arg10), arg7, arg8, arg9, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T1, T0>(arg10, v2, arg11, arg12), 0x2::tx_context::sender(arg12));
    }

    public fun swap_b_a_b_c<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T4, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T4>, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T4>(arg12, arg10, arg14);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v3);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T0, T4>(arg4, &v2);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, arg2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_b_c<T0, T1, T2, T3, T4>(arg0, arg1, v4, 0x2::balance::value<T0>(&v3), arg4, arg5, arg6, true, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T4>(arg12), arg9, arg10, arg11, arg14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T4>(arg12, v2, arg13, arg14), 0x2::tx_context::sender(arg14));
    }

    public fun swap_b_a_c_b<T0, T1, T2, T3, T4>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T4, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::DCA<T0, T4>, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::init_trade<T0, T4>(arg12, arg10, arg14);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v3);
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::assert_max_price_via_output<T0, T4>(arg4, &v2);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, arg2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_c_b<T0, T1, T2, T3, T4>(arg0, arg1, v4, 0x2::balance::value<T0>(&v3), arg4, arg5, arg6, true, 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::owner<T0, T4>(arg12), arg9, arg10, arg11, arg14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca::resolve_trade<T0, T4>(arg12, v2, arg13, arg14), 0x2::tx_context::sender(arg14));
    }

    // decompiled from Move bytecode v6
}

