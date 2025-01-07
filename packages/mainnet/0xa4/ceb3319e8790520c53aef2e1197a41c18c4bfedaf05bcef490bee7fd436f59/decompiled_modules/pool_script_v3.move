module 0xa4ceb3319e8790520c53aef2e1197a41c18c4bfedaf05bcef490bee7fd436f59::pool_script_v3 {
    public entry fun collect_fee<T0, T1>(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::pool::Pool<T0, T1>, arg2: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::pool::Pool<T0, T1>, arg2: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::position::Position, arg3: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::pool::Pool<T0, T1>, arg2: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::rewarder::RewarderGlobalVault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, 0xfa0e2d4afab23c5947ed9057cfc87c886324ce1fc0738af4820a88b1a48f503e::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg4 as u128)), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

