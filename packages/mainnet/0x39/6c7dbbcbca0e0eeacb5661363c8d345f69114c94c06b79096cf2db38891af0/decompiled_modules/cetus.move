module 0x396c7dbbcbca0e0eeacb5661363c8d345f69114c94c06b79096cf2db38891af0::cetus {
    fun flash_swap<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: u64, arg4: bool, arg5: bool, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = if (0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner>(arg2) == @0x59ae16f6c42f578063c2da9b9c0173fe58120ceae08e40fd8212c8eceb80bb86) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, arg4, arg5, arg3, arg0, arg6, arg7, arg8)
        } else {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg4, arg5, arg3, arg0, arg6, arg7, arg8)
        };
        let v3 = v2;
        (v0, v1, v3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v3))
    }

    fun repay_flash_swap<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg2: bool, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = if (arg2) {
            (0x2::balance::split<T0>(&mut arg3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&arg5)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&arg5)))
        };
        if (0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner>(arg1) == @0x59ae16f6c42f578063c2da9b9c0173fe58120ceae08e40fd8212c8eceb80bb86) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, v0, v1, arg5, arg6);
        } else {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, v0, v1, arg5, arg6);
        };
        (arg3, arg4)
    }

    public fun swap_a2b<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2, _) = flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T0>(&arg3), true, true, arg4, arg5, arg6);
        let (v4, v5) = repay_flash_swap<T0, T1>(arg1, arg2, true, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v2, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T0>(v4);
        0x2::balance::destroy_zero<T1>(v5);
        0x2::coin::from_balance<T1>(v1, arg6)
    }

    public fun swap_b2a<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: 0x2::coin::Coin<T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2, _) = flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T1>(&arg3), false, true, arg4, arg5, arg6);
        let (v4, v5) = repay_flash_swap<T0, T1>(arg1, arg2, false, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), v2, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::balance::destroy_zero<T0>(v4);
        0x2::balance::destroy_zero<T1>(v5);
        0x2::coin::from_balance<T0>(v0, arg6)
    }

    // decompiled from Move bytecode v6
}

