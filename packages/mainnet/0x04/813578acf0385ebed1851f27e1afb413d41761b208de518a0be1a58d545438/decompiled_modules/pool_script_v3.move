module 0x4813578acf0385ebed1851f27e1afb413d41761b208de518a0be1a58d545438::pool_script_v3 {
    public entry fun collect_fee<T0, T1>(arg0: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::GlobalConfig, arg1: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::pool::Pool<T0, T1>, arg2: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::GlobalConfig, arg1: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::pool::Pool<T0, T1>, arg2: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::position::Position, arg3: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::GlobalConfig, arg1: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::pool::Pool<T0, T1>, arg2: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::rewarder::RewarderGlobalVault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg4 as u128)), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

