module 0xf110a66514bf405790e1c428370bbc499f985ea689dad06cf701015f8c1399aa::flash2 {
    fun compute_repay(arg0: u64) : u64 {
        arg0 + ((((arg0 as u128) * 500 + 1000000 - 1) / 1000000) as u64)
    }

    public entry fun f2_bb2a_cb2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::cetus_b2a<T0, T1>(arg0, arg4, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::bf_b2a<T1, T0>(arg3, arg2, 0x2::coin::from_balance<T0>(v0, arg8), arg5, arg8), arg5, arg8);
        let v4 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_bb2a_da2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::db_a2b<T1, T0>(arg4, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::bf_b2a<T1, T0>(arg3, arg2, 0x2::coin::from_balance<T0>(v0, arg8), arg5, arg8), arg5, 0x2::tx_context::sender(arg8), arg8);
        let v4 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_bb2a_ma2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::mmt_a2b<T1, T0>(arg4, arg5, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::bf_b2a<T1, T0>(arg3, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f2_bb2a_ta2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::bf_b2a<T1, T0>(arg3, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9);
        let v4 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::turbos_a2b<T1, T0, T2>(arg4, v3, 0x2::coin::value<T1>(&v3), 0x2::tx_context::sender(arg9), 18446744073709551615, arg6, arg5, arg9);
        let v5 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg9));
    }

    public entry fun f2_ca2b_ba2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::bf_a2b<T1, T0>(arg4, arg3, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg8), arg5, arg8), arg5, arg8);
        let v4 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_ca2b_da2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::db_a2b<T1, T0>(arg3, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg7), arg4, arg7), arg4, 0x2::tx_context::sender(arg7), arg7);
        let v4 = compute_repay(arg5);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg6, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg7)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun f2_ca2b_ma2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::mmt_a2b<T1, T0>(arg3, arg4, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg8), arg5, arg8), arg5, arg8);
        let v4 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_ca2b_ta2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg8), arg5, arg8);
        let v4 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::turbos_a2b<T1, T0, T2>(arg3, v3, 0x2::coin::value<T1>(&v3), 0x2::tx_context::sender(arg8), 18446744073709551615, arg5, arg4, arg8);
        let v5 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_db2a_ba2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::bf_a2b<T1, T0>(arg4, arg3, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::db_b2a<T1, T0>(arg2, 0x2::coin::from_balance<T0>(v0, arg8), arg5, 0x2::tx_context::sender(arg8), arg8), arg5, arg8);
        let v4 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_db2a_cb2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::cetus_b2a<T0, T1>(arg0, arg3, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::db_b2a<T1, T0>(arg2, 0x2::coin::from_balance<T0>(v0, arg7), arg4, 0x2::tx_context::sender(arg7), arg7), arg4, arg7);
        let v4 = compute_repay(arg5);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg6, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg7)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun f2_db2a_ma2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::mmt_a2b<T1, T0>(arg3, arg4, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::db_b2a<T1, T0>(arg2, 0x2::coin::from_balance<T0>(v0, arg8), arg5, 0x2::tx_context::sender(arg8), arg8), arg5, arg8);
        let v4 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_db2a_ta2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::db_b2a<T1, T0>(arg2, 0x2::coin::from_balance<T0>(v0, arg8), arg5, 0x2::tx_context::sender(arg8), arg8);
        let v4 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::turbos_a2b<T1, T0, T2>(arg3, v3, 0x2::coin::value<T1>(&v3), 0x2::tx_context::sender(arg8), 18446744073709551615, arg5, arg4, arg8);
        let v5 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_mb2a_ba2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::bf_a2b<T1, T0>(arg5, arg4, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::mmt_b2a<T1, T0>(arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f2_mb2a_cb2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::cetus_b2a<T0, T1>(arg0, arg4, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::mmt_b2a<T1, T0>(arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg8), arg5, arg8), arg5, arg8);
        let v4 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_mb2a_da2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::db_a2b<T1, T0>(arg4, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::mmt_b2a<T1, T0>(arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg8), arg5, arg8), arg5, 0x2::tx_context::sender(arg8), arg8);
        let v4 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_mb2a_ta2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::mmt_b2a<T1, T0>(arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9);
        let v4 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::turbos_a2b<T1, T0, T2>(arg4, v3, 0x2::coin::value<T1>(&v3), 0x2::tx_context::sender(arg9), 18446744073709551615, arg6, arg5, arg9);
        let v5 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg9));
    }

    public entry fun f2_tb2a_ba2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg9);
        let v4 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::bf_a2b<T1, T0>(arg5, arg4, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::turbos_b2a<T1, T0, T2>(arg2, v3, 0x2::coin::value<T0>(&v3), 0x2::tx_context::sender(arg9), 18446744073709551615, arg6, arg3, arg9), arg6, arg9);
        let v5 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg9));
    }

    public entry fun f2_tb2a_cb2a<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v4 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::cetus_b2a<T0, T1>(arg0, arg4, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::turbos_b2a<T1, T0, T2>(arg2, v3, 0x2::coin::value<T0>(&v3), 0x2::tx_context::sender(arg8), 18446744073709551615, arg5, arg3, arg8), arg5, arg8);
        let v5 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_tb2a_da2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v4 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::db_a2b<T1, T0>(arg4, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::turbos_b2a<T1, T0, T2>(arg2, v3, 0x2::coin::value<T0>(&v3), 0x2::tx_context::sender(arg8), 18446744073709551615, arg5, arg3, arg8), arg5, 0x2::tx_context::sender(arg8), arg8);
        let v5 = compute_repay(arg6);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg7, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg8)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg8));
    }

    public entry fun f2_tb2a_ma2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg9);
        let v4 = 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::mmt_a2b<T1, T0>(arg4, arg5, 0xa769233bc4ed59e98dcdc99b1efb783a02cafbc0c1daaa8a60fc925cc670faef::arb::turbos_b2a<T1, T0, T2>(arg2, v3, 0x2::coin::value<T0>(&v3), 0x2::tx_context::sender(arg9), 18446744073709551615, arg6, arg3, arg9), arg6, arg9);
        let v5 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg9));
    }

    // decompiled from Move bytecode v6
}

