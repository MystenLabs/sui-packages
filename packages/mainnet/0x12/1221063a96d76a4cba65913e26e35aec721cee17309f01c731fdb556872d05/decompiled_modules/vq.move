module 0x47b26b4430860ef0badb84f3ef5bf5aa1fd7215fe6482a92aaf1b602fe2165cb::vq {
    public fun sa<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, true, true, 0x2::balance::value<T0>(&arg3), arg1, arg2, arg4, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut arg3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3, arg2);
        0x2::balance::destroy_zero<T0>(arg3);
        v1
    }

    public fun sb<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, false, true, 0x2::balance::value<T1>(&arg3), arg1, arg2, arg4, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v3)), v3, arg2);
        0x2::balance::destroy_zero<T1>(arg3);
        v0
    }

    // decompiled from Move bytecode v7
}

