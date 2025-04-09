module 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::pool_script_v3 {
    public entry fun collect_fee<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::rewarder::RewarderGlobalVault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, 0x273edb422b3404487a0e700224f541852e799957e4e289363a1675a8dcee158b::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg4 as u128)), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

