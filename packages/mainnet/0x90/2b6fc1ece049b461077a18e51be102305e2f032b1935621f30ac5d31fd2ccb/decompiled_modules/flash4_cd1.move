module 0x902b6fc1ece049b461077a18e51be102305e2f032b1935621f30ac5d31fd2ccb::flash4_cd1 {
    fun compute_repay(arg0: u64) : u64 {
        arg0 + ((((arg0 as u128) * 500 + 1000000 - 1) / 1000000) as u64)
    }

    public entry fun f4_ca2b_da2b_ba2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ba2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ba2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ba2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ba2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ba2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ba2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ba2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ba2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ba2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_bb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_bb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_bb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_bb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_bb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_bb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_bb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_bb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_bb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_bb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ca2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ca2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ca2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_da2b_ca2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_da2b_ca2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_da2b_ca2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_da2b_ca2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ca2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ca2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ca2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_cb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_cb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_cb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_da2b_cb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_da2b_cb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_da2b_cb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_da2b_cb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_cb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_cb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_cb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ma2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ma2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ma2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ma2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ma2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ma2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ma2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ma2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ma2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ma2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_mb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_mb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_mb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_mb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_mb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_mb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_mb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_mb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_mb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_mb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ta2b_ba2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ta2b_bb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ta2b_ca2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ta2b_cb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_ta2b_ma2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ta2b_mb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ta2b_ta2b<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_ta2b_tb2a<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_tb2a_ba2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_tb2a_bb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_tb2a_ca2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_tb2a_cb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_da2b_tb2a_ma2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_tb2a_mb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_tb2a_ta2b<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_da2b_tb2a_tb2a<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ba2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ba2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ba2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ba2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ba2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ba2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ba2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ba2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ba2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ba2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_bb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_bb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_bb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_bb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_bb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_bb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_bb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_bb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_bb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_bb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ca2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ca2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ca2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_db2a_ca2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_db2a_ca2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_db2a_ca2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_db2a_ca2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ca2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ca2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ca2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_cb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_cb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_cb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_db2a_cb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_db2a_cb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_db2a_cb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_ca2b_db2a_cb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_cb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_cb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_cb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ma2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ma2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ma2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ma2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ma2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ma2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ma2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ma2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ma2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ma2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_mb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_mb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_mb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_mb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_mb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_mb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_mb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_mb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_mb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_mb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ta2b_ba2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ta2b_bb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ta2b_ca2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ta2b_cb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_ta2b_ma2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ta2b_mb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ta2b_ta2b<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_ta2b_tb2a<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_tb2a_ba2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_tb2a_bb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_tb2a_ca2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_tb2a_cb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_ca2b_db2a_tb2a_ma2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_tb2a_mb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_tb2a_ta2b<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_ca2b_db2a_tb2a_tb2a<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ba2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ba2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ba2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ba2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ba2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ba2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ba2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ba2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ba2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ba2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_bb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_bb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_bb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_bb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_bb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_bb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_bb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_bb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_bb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_bb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ca2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ca2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ca2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_da2b_ca2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_da2b_ca2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_da2b_ca2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_da2b_ca2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ca2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ca2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ca2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_cb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_cb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_cb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_da2b_cb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_da2b_cb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_da2b_cb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_da2b_cb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_cb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_cb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_cb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ma2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ma2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ma2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ma2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ma2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ma2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ma2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ma2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ma2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ma2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_mb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_mb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_mb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_mb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_mb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_mb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_mb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_mb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_mb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_mb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ta2b_ba2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ta2b_bb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ta2b_ca2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ta2b_cb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_ta2b_ma2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ta2b_mb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ta2b_ta2b<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_ta2b_tb2a<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_tb2a_ba2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_tb2a_bb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_tb2a_ca2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_tb2a_cb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_da2b_tb2a_ma2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_tb2a_mb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_tb2a_ta2b<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_da2b_tb2a_tb2a<T0, T1, T2, T3, T4, T5>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T5>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T1, T2>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11);
        let v5 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T5>(arg6, v4, 0x2::coin::value<T3>(&v4), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v6 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v5) >= v6 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ba2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ba2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ba2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ba2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ba2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ba2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ba2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ba2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ba2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ba2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T2, T3>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_bb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_bb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_bb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_bb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_bb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_bb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_bb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_bb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_bb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_bb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T3, T2>(arg5, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ca2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ca2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ca2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_db2a_ca2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_db2a_ca2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_db2a_ca2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_db2a_ca2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ca2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ca2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ca2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T2, T3>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_cb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_cb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg6, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_cb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_db2a_cb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_db2a_cb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_db2a_cb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg7);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9), arg6, arg9), arg6, 0x2::tx_context::sender(arg9), arg9);
        let v4 = compute_repay(arg7);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg8, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg9)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    public entry fun f4_cb2a_db2a_cb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_cb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg5, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_cb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_cb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T3, T2>(arg0, arg4, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg5, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg6, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ma2b_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ma2b_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ma2b_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ma2b_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ma2b_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ma2b_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ma2b_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ma2b_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ma2b_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ma2b_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T2, T3>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_mb2a_ba2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_mb2a_bb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_mb2a_ca2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_mb2a_cb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_mb2a_da2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_a2b<T3, T0>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_mb2a_db2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T0, T3>(arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_mb2a_ma2b<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_mb2a_mb2a<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11), arg8, arg11);
        let v4 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v3) >= v4 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, v4, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_mb2a_ta2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T0, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T3, T0, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_mb2a_tb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T3, T4>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T3, T2>(arg4, arg5, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11), arg8, arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T0, T3, T4>(arg6, v3, 0x2::coin::value<T3>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg7, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ta2b_ba2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ta2b_bb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ta2b_ca2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ta2b_cb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_ta2b_ma2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_ta2b_mb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_a2b<T2, T3, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_tb2a_ba2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_a2b<T3, T0>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_tb2a_bb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::bf_b2a<T0, T3>(arg7, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_tb2a_ca2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_a2b<T3, T0>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_tb2a_cb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg8);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg10), arg7, arg10), arg7, 0x2::tx_context::sender(arg10), arg10);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T0, T3>(arg0, arg6, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg10), 18446744073709551615, arg7, arg5, arg10), arg7, arg10);
        let v5 = compute_repay(arg8);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg9, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg10)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
    }

    public entry fun f4_cb2a_db2a_tb2a_ma2b<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T0>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_a2b<T3, T0>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun f4_cb2a_db2a_tb2a_mb2a<T0, T1, T2, T3, T4>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T2, T4>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T3>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &0x2::clock::Clock, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg9);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::db_b2a<T2, T1>(arg3, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::cetus_b2a<T1, T0>(arg0, arg2, 0x2::coin::from_balance<T0>(v0, arg11), arg8, arg11), arg8, 0x2::tx_context::sender(arg11), arg11);
        let v4 = 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::mmt_b2a<T0, T3>(arg6, arg7, 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb::turbos_b2a<T3, T2, T4>(arg4, v3, 0x2::coin::value<T2>(&v3), 0x2::tx_context::sender(arg11), 18446744073709551615, arg8, arg5, arg11), arg8, arg11);
        let v5 = compute_repay(arg9);
        assert!(0x2::coin::value<T0>(&v4) >= v5 + arg10, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg11)), 0x2::balance::zero<T1>(), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    // decompiled from Move bytecode v6
}

