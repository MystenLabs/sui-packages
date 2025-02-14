module 0x5f40da851d866d2adb350214188a60d2aee8d33304ea738fa39261fdf310e083::pool_script_v3 {
    public entry fun collect_fee<T0, T1>(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg2: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg2: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::position::Position, arg3: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg1: &mut 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::Pool<T0, T1>, arg2: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::rewarder::RewarderGlobalVault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg4 as u128)), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

