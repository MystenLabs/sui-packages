module 0x5b9428ad212672a6ef8404569ae79de723610993579996e0fc2ae7e1665fd1f5::pool_script_v3 {
    public entry fun collect_fee<T0, T1>(arg0: &0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::config::GlobalConfig, arg1: &mut 0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::pool::Pool<T0, T1>, arg2: &mut 0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::config::GlobalConfig, arg1: &mut 0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::pool::Pool<T0, T1>, arg2: &mut 0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::position::Position, arg3: &mut 0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::config::GlobalConfig, arg1: &mut 0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::pool::Pool<T0, T1>, arg2: &0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::rewarder::RewarderGlobalVault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, 0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg4 as u128)), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

