module 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::aB {
    public fun dC<T0, T1>(arg0: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::dB::AP, arg1: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::AC, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: bool, arg5: &0x2::clock::Clock) {
        if (arg4) {
            dD<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        } else {
            eF<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        };
    }

    fun dD<T0, T1>(arg0: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::dB::AP, arg1: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::AC, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        let v0 = 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::gO<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg2, arg3, v0, 0x2::balance::zero<T1>(), true, true, v1, 0, 4295048017);
        0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::dB::eA<T0>(arg0, v2, 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::BBget_noteAAA(arg1));
        0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::eA<T1>(arg1, v3);
    }

    fun eF<T0, T1>(arg0: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::dB::AP, arg1: &mut 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::AC, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        let v0 = 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::gO<T1>(arg1);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg4, arg2, arg3, 0x2::balance::zero<T0>(), v0, false, true, v1, 0, 79226673515401279992447579054);
        0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::dB::eA<T1>(arg0, v3, 0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::BBget_noteAAA(arg1));
        0xa70754ee92537bfa90b7ecc88229ce5de801f424b6b57f4c385c84dd2e92382a::cB::eA<T0>(arg1, v2);
    }

    // decompiled from Move bytecode v6
}

