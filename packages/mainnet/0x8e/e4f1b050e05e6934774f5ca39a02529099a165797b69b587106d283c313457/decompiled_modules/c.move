module 0x8ee4f1b050e05e6934774f5ca39a02529099a165797b69b587106d283c313457::c {
    public fun sxy<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg2, true, true, 0x2::coin::value<T0>(&arg3), arg0, arg1, arg4, arg5);
        let v3 = v2;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v3), arg5)), 0x2::balance::zero<T1>(), v3, arg1);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        tod<T0>(arg3, 0x2::tx_context::sender(arg5));
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun syx<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg2, false, true, 0x2::coin::value<T1>(&arg3), arg0, arg1, arg4, arg5);
        let v3 = v2;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v3), arg5)), v3, arg1);
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v1, arg5));
        tod<T1>(arg3, 0x2::tx_context::sender(arg5));
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    fun tod<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

