module 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::mB {
    public fun dC<T0, T1>(arg0: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::dB::AP, arg1: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::AC, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: bool, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        if (arg3) {
            dD<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            eF<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun dD<T0, T1>(arg0: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::dB::AP, arg1: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::AC, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::gO<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, true, true, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg4, arg3, arg5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v4, v0, 0x2::balance::zero<T1>(), arg3, arg5);
        0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::dB::eA<T0>(arg0, v2, 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::BBget_noteAAA(arg1));
        0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::eA<T1>(arg1, v3);
    }

    fun eF<T0, T1>(arg0: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::dB::AP, arg1: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::AC, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::gO<T1>(arg1);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, false, true, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg4, arg3, arg5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v4, 0x2::balance::zero<T0>(), v0, arg3, arg5);
        0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::dB::eA<T1>(arg0, v3, 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::BBget_noteAAA(arg1));
        0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::eA<T0>(arg1, v2);
    }

    // decompiled from Move bytecode v6
}

