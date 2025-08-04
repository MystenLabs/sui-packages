module 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::mmt {
    public fun swap<T0, T1, T2, T3>(arg0: &mut 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::checkpoint::Payload<T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        if (arg2) {
            0x2::balance::join<T0>(&mut v0, 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::checkpoint::take_next<T2, T3, T0>(arg0));
        } else {
            0x2::balance::join<T1>(&mut v1, 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::checkpoint::take_next<T2, T3, T1>(arg0));
        };
        let v2 = if (arg2) {
            0x2::balance::value<T0>(&v0)
        } else {
            0x2::balance::value<T1>(&v1)
        };
        let (v3, v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, arg2, arg3, v2, arg4, arg5, arg6, arg7);
        if (arg2) {
            0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::checkpoint::place_next<T2, T3, T1>(arg0, v4);
            0x2::balance::destroy_zero<T0>(v3);
        } else {
            0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::checkpoint::place_next<T2, T3, T0>(arg0, v3);
            0x2::balance::destroy_zero<T1>(v4);
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v5, v0, v1, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

