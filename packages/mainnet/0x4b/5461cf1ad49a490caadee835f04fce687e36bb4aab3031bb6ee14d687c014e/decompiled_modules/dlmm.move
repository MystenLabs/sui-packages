module 0x4b5461cf1ad49a490caadee835f04fce687e36bb4aab3031bb6ee14d687c014e::dlmm {
    public fun cetus_dlmm_flash_swap_a_to_b<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: 0x2::coin::Coin<T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T2, T3>(arg3, true, true, arg2, arg4, arg5, arg7, arg8);
        let v3 = v0;
        0x2::balance::join<T2>(&mut v3, 0x2::coin::into_balance<T2>(arg6));
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T2, T3>(arg3, v3, 0x2::balance::zero<T3>(), v2, arg5);
        let v4 = 0x2::coin::from_balance<T3>(v1, arg8);
        let v5 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>>(arg3);
        0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::record_leg<T0, T1, T2, T3>(arg0, arg1, 14, 0x2::object::id_to_address(&v5), arg2, 0x2::coin::value<T3>(&v4));
        v4
    }

    public fun cetus_dlmm_flash_swap_b_to_a<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: 0x2::coin::Coin<T3>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T2, T3>(arg3, false, true, arg2, arg4, arg5, arg7, arg8);
        let v3 = v1;
        0x2::balance::join<T3>(&mut v3, 0x2::coin::into_balance<T3>(arg6));
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T2, T3>(arg3, 0x2::balance::zero<T2>(), v3, v2, arg5);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg8);
        let v5 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>>(arg3);
        0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::record_leg<T0, T1, T3, T2>(arg0, arg1, 14, 0x2::object::id_to_address(&v5), arg2, 0x2::coin::value<T2>(&v4));
        v4
    }

    public fun ferra_dlmm_swap_a_to_b<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg4: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T2, T3>, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T2, T3>(arg3, arg4, true, 0, arg5, 0x2::coin::zero<T3>(arg7), arg6, arg7);
        let v2 = v1;
        let v3 = 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T2, T3>>(arg4);
        refund_and_record<T0, T1, T2, T3>(arg0, arg1, 6, 0x2::object::id_to_address(&v3), arg2, v0, &v2);
        v2
    }

    public fun ferra_dlmm_swap_b_to_a<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg4: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T2, T3>, arg5: 0x2::coin::Coin<T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T2, T3>(arg3, arg4, false, 0, 0x2::coin::zero<T2>(arg7), arg5, arg6, arg7);
        let v2 = v0;
        let v3 = 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T2, T3>>(arg4);
        refund_and_record<T0, T1, T3, T2>(arg0, arg1, 6, 0x2::object::id_to_address(&v3), arg2, v1, &v2);
        v2
    }

    fun refund_and_record<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u8, arg3: address, arg4: u64, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::coin::Coin<T3>) {
        0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::refund_aux<T0, T1, T2>(arg0, arg5);
        0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::record_leg<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::value<T3>(arg6));
    }

    // decompiled from Move bytecode v6
}

