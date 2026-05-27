module 0x9ed567ca5723e43a1155aacb324e6de5157653c4bd3848e381811790e23dc338::flash_arb {
    public fun swap_cetus_cetus<T0, T1>(arg0: &0x9ed567ca5723e43a1155aacb324e6de5157653c4bd3848e381811790e23dc338::config::GlobalConfig, arg1: &mut 0x9ed567ca5723e43a1155aacb324e6de5157653c4bd3848e381811790e23dc338::pool::Pool<T0, T1>, arg2: &mut 0x9ed567ca5723e43a1155aacb324e6de5157653c4bd3848e381811790e23dc338::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: u128, arg7: u128) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x9ed567ca5723e43a1155aacb324e6de5157653c4bd3848e381811790e23dc338::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg4), arg6, arg3);
        let v3 = v1;
        0x9ed567ca5723e43a1155aacb324e6de5157653c4bd3848e381811790e23dc338::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg4, 0x2::balance::zero<T1>(), v2);
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5, v6) = 0x9ed567ca5723e43a1155aacb324e6de5157653c4bd3848e381811790e23dc338::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v3), arg7, arg3);
        let v7 = v4;
        0x9ed567ca5723e43a1155aacb324e6de5157653c4bd3848e381811790e23dc338::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v3, v6);
        0x2::balance::destroy_zero<T1>(v5);
        assert!(0x2::balance::value<T0>(&v7) >= arg5, 1);
        v7
    }

    // decompiled from Move bytecode v7
}

