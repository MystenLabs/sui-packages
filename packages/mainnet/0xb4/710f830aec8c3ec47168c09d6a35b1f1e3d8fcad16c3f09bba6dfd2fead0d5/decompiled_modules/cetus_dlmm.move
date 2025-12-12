module 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::cetus_dlmm {
    public fun swap<T0, T1, T2, T3>(arg0: &mut 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::Payload<T2, T3>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        if (arg2) {
            0x2::balance::join<T0>(&mut v0, 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::take_next<T2, T3, T0>(arg0));
        } else {
            0x2::balance::join<T1>(&mut v1, 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::take_next<T2, T3, T1>(arg0));
        };
        let v2 = if (arg2) {
            0x2::balance::value<T0>(&v0)
        } else {
            0x2::balance::value<T1>(&v1)
        };
        let (v3, v4, v5) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, arg2, arg3, v2, arg4, arg5, arg6, arg7);
        if (arg2) {
            0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::place_next<T2, T3, T1>(arg0, v4);
            0x2::balance::destroy_zero<T0>(v3);
        } else {
            0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::place_next<T2, T3, T0>(arg0, v3);
            0x2::balance::destroy_zero<T1>(v4);
        };
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg1, v0, v1, v5, arg5);
    }

    // decompiled from Move bytecode v6
}

