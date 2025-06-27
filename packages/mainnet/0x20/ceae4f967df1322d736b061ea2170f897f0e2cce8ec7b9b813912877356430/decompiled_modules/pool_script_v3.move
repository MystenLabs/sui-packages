module 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::pool_script_v3 {
    public entry fun collect_fee<T0, T1>(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg1: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::pool::Pool<T0, T1>, arg2: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg1: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::pool::Pool<T0, T1>, arg2: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::position::Position, arg3: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg1: &mut 0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::pool::Pool<T0, T1>, arg2: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::rewarder::RewarderGlobalVault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, 0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg4 as u128)), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

