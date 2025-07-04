module 0xf16f79b13fbe2c509cf9e0078bbdcd824b4739da14dcedcc3b6386ab70b5d7de::pool_script_v3 {
    public entry fun collect_fee<T0, T1>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg2: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg2: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::position::Position, arg3: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg2: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::RewarderGlobalVault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg4 as u128)), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

