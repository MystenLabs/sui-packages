module 0xd6aa23dafdd701ab63de1131ac53ffb8766559a4ea1fcbf333a2fd39cc472fab::flash_swap_module {
    public entry fun do_swap<T0, T1>(arg0: u64, arg1: bool, arg2: bool, arg3: u8, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg11, arg10, arg1, arg2, arg0, v0, arg12);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg1) {
            0x2::balance::destroy_zero<T1>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay<T1>(arg12, arg9, arg7, arg6, arg4, 0x2::coin::from_balance<T1>(v5, arg13), 0x2::balance::value<T1>(&v5), arg8, arg13));
            0x2::balance::destroy_zero<T0>(v6);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg11, arg10, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::borrow<T0>(arg12, arg9, arg7, arg5, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg8, arg13), 0x2::balance::zero<T1>(), v4);
        } else {
            0x2::balance::destroy_zero<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay<T0>(arg12, arg9, arg7, arg5, arg3, 0x2::coin::from_balance<T0>(v6, arg13), 0x2::balance::value<T0>(&v6), arg8, arg13));
            0x2::balance::destroy_zero<T1>(v5);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg11, arg10, 0x2::balance::zero<T0>(), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::borrow<T1>(arg12, arg9, arg7, arg6, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg8, arg13), v4);
        };
    }

    // decompiled from Move bytecode v6
}

