module 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::srm {
    public fun sr1f<T0, T1>(arg0: &0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::Config, arg1: &0x2::clock::Clock, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg11: u8, arg12: u64, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_b<T0, T1>(arg1, arg2, arg7, arg12);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T1, T0>(arg1, arg3, arg4, arg11, arg10, v0, arg8, arg9, arg13, arg5, arg6, arg14);
        let v4 = v2;
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_b_repay_a<T0, T1>(arg2, arg7, &mut v4, v1);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T0>(arg0, v4, arg14);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T1>(arg0, v3, arg14);
    }

    public fun sr1t<T0, T1>(arg0: &0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::Config, arg1: &0x2::clock::Clock, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg11: u8, arg12: u64, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_a<T0, T1>(arg1, arg2, arg7, arg12);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T0, T1>(arg1, arg3, arg4, arg8, arg9, v0, arg11, arg10, arg13, arg5, arg6, arg14);
        let v4 = v2;
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_a_repay_b<T0, T1>(arg2, arg7, &mut v4, v1);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T0>(arg0, v3, arg14);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T1>(arg0, v4, arg14);
    }

    public fun sr2ff<T0, T1, T2>(arg0: &0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::Config, arg1: &0x2::clock::Clock, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg12: u8, arg13: u64, arg14: address, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_b<T1, T0>(arg1, arg2, arg7, arg13);
        let v2 = v1;
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T0, T2>(arg1, arg3, arg4, arg9, arg10, v0, arg12, arg11, arg14, arg5, arg6, arg15);
        let v5 = v3;
        let v6 = 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::fixed_swap_a_to_b_out<T2, T1>(arg1, arg2, arg8, &mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v2));
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_b_repay_a<T1, T0>(arg2, arg7, &mut v6, v2);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T0>(arg0, v4, arg15);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T2>(arg0, v5, arg15);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T1>(arg0, v6, arg15);
    }

    public fun sr2ft<T0, T1, T2>(arg0: &0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::Config, arg1: &0x2::clock::Clock, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg12: u8, arg13: u64, arg14: address, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_b<T1, T0>(arg1, arg2, arg7, arg13);
        let v2 = v1;
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T0, T2>(arg1, arg3, arg4, arg9, arg10, v0, arg12, arg11, arg14, arg5, arg6, arg15);
        let v5 = v3;
        let v6 = 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::fixed_swap_b_to_a_out<T1, T2>(arg1, arg2, arg8, &mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v2));
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_b_repay_a<T1, T0>(arg2, arg7, &mut v6, v2);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T0>(arg0, v4, arg15);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T2>(arg0, v5, arg15);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T1>(arg0, v6, arg15);
    }

    public fun sr2tf<T0, T1, T2>(arg0: &0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::Config, arg1: &0x2::clock::Clock, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg12: u8, arg13: u64, arg14: address, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_a<T0, T1>(arg1, arg2, arg7, arg13);
        let v2 = v1;
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T0, T2>(arg1, arg3, arg4, arg9, arg10, v0, arg12, arg11, arg14, arg5, arg6, arg15);
        let v5 = v3;
        let v6 = 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::fixed_swap_a_to_b_out<T2, T1>(arg1, arg2, arg8, &mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v2));
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_a_repay_b<T0, T1>(arg2, arg7, &mut v6, v2);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T0>(arg0, v4, arg15);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T2>(arg0, v5, arg15);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T1>(arg0, v6, arg15);
    }

    public fun sr2tt<T0, T1, T2>(arg0: &0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::Config, arg1: &0x2::clock::Clock, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg12: u8, arg13: u64, arg14: address, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_a<T0, T1>(arg1, arg2, arg7, arg13);
        let v2 = v1;
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T0, T2>(arg1, arg3, arg4, arg9, arg10, v0, arg12, arg11, arg14, arg5, arg6, arg15);
        let v5 = v3;
        let v6 = 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::fixed_swap_b_to_a_out<T1, T2>(arg1, arg2, arg8, &mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v2));
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::sw::borrow_a_repay_b<T0, T1>(arg2, arg7, &mut v6, v2);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T0>(arg0, v4, arg15);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T2>(arg0, v5, arg15);
        0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::cm::tfb<T1>(arg0, v6, arg15);
    }

    // decompiled from Move bytecode v6
}

