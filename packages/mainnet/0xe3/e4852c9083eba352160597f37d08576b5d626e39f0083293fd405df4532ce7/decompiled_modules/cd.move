module 0xe3e4852c9083eba352160597f37d08576b5d626e39f0083293fd405df4532ce7::cd {
    public fun a<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg2, true, true, 0x2::coin::value<T0>(&arg3), arg0, arg1, arg4, arg5);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v2, arg1);
        0xb4a01ffa50893ef256b3be007cecdae74744c4b236f229bc33babccb4a8e5ad::vv::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg5), arg5);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun b<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg2, false, true, 0x2::coin::value<T1>(&arg3), arg0, arg1, arg4, arg5);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), v2, arg1);
        0xb4a01ffa50893ef256b3be007cecdae74744c4b236f229bc33babccb4a8e5ad::vv::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg5), arg5);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    // decompiled from Move bytecode v6
}

