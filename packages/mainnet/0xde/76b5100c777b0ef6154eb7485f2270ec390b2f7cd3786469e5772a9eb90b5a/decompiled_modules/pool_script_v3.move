module 0xde76b5100c777b0ef6154eb7485f2270ec390b2f7cd3786469e5772a9eb90b5a::pool_script_v3 {
    public entry fun collect_fee<T0, T1>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::position::Position, arg3: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg2: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::RewarderGlobalVault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg4 as u128)), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

