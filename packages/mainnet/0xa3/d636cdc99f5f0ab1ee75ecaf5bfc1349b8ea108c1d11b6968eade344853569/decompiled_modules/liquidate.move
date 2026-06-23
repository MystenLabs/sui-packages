module 0xa3d636cdc99f5f0ab1ee75ecaf5bfc1349b8ea108c1d11b6968eade344853569::liquidate {
    public fun flash_liquidate<T0, T1>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: u8, arg10: u8, arg11: address, arg12: u64, arg13: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg14: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg15: u128, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg1, arg12, arg7, arg17);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg8, arg4, arg3, arg9, arg1, v0, arg10, arg2, arg11, arg5, arg6, arg7, arg17);
        let (v4, v5) = 0xa3d636cdc99f5f0ab1ee75ecaf5bfc1349b8ea108c1d11b6968eade344853569::swap::swap_a2b<T1, T0>(arg13, arg14, v2, arg15, arg8);
        let v6 = v4;
        0x2::balance::join<T0>(&mut v6, v3);
        let v7 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg8, arg3, arg1, v1, v6, arg17);
        assert!(0x2::balance::value<T0>(&v7) >= arg16, 1);
        let v8 = 0x2::tx_context::sender(arg17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg17), v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg17), v8);
    }

    // decompiled from Move bytecode v7
}

