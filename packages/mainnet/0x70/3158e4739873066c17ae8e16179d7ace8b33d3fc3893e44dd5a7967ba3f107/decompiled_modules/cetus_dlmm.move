module 0x703158e4739873066c17ae8e16179d7ace8b33d3fc3893e44dd5a7967ba3f107::cetus_dlmm {
    fun swap_<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, arg3, arg4, arg5, arg7, arg6, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v3);
        let v7 = if (arg3) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg4) {
            assert!(v6 == arg5, 4200);
        } else {
            assert!(v7 == arg5, 4200);
        };
        let (v8, v9) = if (arg3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v6, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v6, arg9)))
        };
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, v8, v9, v3, arg6);
        0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v5, arg9));
        0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v4, arg9));
        (arg1, arg2)
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return 0x2::coin::zero<T1>(arg5)
        };
        let v1 = 0x2::coin::zero<T1>(arg5);
        let (v2, v3) = swap_<T0, T1>(arg0, arg1, v1, true, true, v0, arg3, arg2, arg4, arg5);
        0x2::coin::destroy_zero<T0>(v2);
        v3
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T1>(arg1);
            return 0x2::coin::zero<T0>(arg5)
        };
        let v1 = 0x2::coin::zero<T0>(arg5);
        let (v2, v3) = swap_<T0, T1>(arg0, v1, arg1, false, true, v0, arg3, arg2, arg4, arg5);
        0x2::coin::destroy_zero<T1>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

