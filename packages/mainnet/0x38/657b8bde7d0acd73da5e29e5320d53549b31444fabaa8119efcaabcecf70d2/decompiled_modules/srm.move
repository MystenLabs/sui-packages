module 0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::srm {
    public fun sr1f<T0, T1>(arg0: &0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::cfm::Config, arg1: &0x2::clock::Clock, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg11: u8, arg12: u64, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::csw::borrow_b<T0, T1>(arg1, arg2, arg7, arg12);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T1, T0>(arg1, arg3, arg4, arg11, arg10, v0, arg8, arg9, arg13, arg5, arg6, arg14);
        let v4 = v2;
        0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::csw::borrow_b_repay_a<T0, T1>(arg2, arg7, &mut v4, v1);
        0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::cfm::tfb<T0>(arg0, v4, arg14);
        0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::cfm::tfb<T1>(arg0, v3, arg14);
    }

    public fun sr1t<T0, T1>(arg0: &0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::cfm::Config, arg1: &0x2::clock::Clock, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg11: u8, arg12: u64, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::csw::borrow_a<T0, T1>(arg1, arg2, arg7, arg12);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::liquidation<T0, T1>(arg1, arg3, arg4, arg8, arg9, v0, arg11, arg10, arg13, arg5, arg6, arg14);
        let v4 = v2;
        0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::csw::borrow_a_repay_b<T0, T1>(arg2, arg7, &mut v4, v1);
        0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::cfm::tfb<T0>(arg0, v3, arg14);
        0x38657b8bde7d0acd73da5e29e5320d53549b31444fabaa8119efcaabcecf70d2::cfm::tfb<T1>(arg0, v4, arg14);
    }

    // decompiled from Move bytecode v6
}

