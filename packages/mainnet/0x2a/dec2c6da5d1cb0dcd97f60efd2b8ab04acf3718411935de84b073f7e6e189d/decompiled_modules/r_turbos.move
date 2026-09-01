module 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::r_turbos {
    public fun a2b<T0, T1, T2>(arg0: &mut 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::Session, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::partner::Partner, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::assert_decided(arg0);
        if (!0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::armed(arg0)) {
            return 0x2::coin::zero<T0>(arg6)
        };
        let v0 = 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::take<T0>(arg0, arg4);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_partner<T0, T1, T2>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg6), 0x2::balance::value<T0>(&v0), 0, 4295048016, true, 4102444800000, arg5, arg3, arg6);
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::put<T1>(arg0, arg4 + 1, 0x2::coin::into_balance<T1>(v2));
        v1
    }

    public fun b2a<T0, T1, T2>(arg0: &mut 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::Session, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::partner::Partner, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::assert_decided(arg0);
        if (!0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::armed(arg0)) {
            return 0x2::coin::zero<T1>(arg6)
        };
        let v0 = 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::take<T1>(arg0, arg4);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_partner<T0, T1, T2>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg6), 0x2::balance::value<T1>(&v0), 0, 79226673515401279992447579055, true, 4102444800000, arg5, arg3, arg6);
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::put<T0>(arg0, arg4 + 1, 0x2::coin::into_balance<T0>(v1));
        v2
    }

    // decompiled from Move bytecode v7
}

