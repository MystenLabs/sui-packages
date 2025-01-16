module 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_script {
    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::Pool<T0, T1>, arg1: &0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_router::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun claim_fee<T0, T1>(arg0: &0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::AdminCap, arg1: &mut 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_router::claim_fee<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun init_pool<T0, T1>(arg0: &0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_router::init_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::Pool<T0, T1>, arg1: &0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::PoolLiquidityCoin<T0, T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_router::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_fee_config<T0, T1>(arg0: &0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::AdminCap, arg1: &mut 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_router::set_fee_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_global_pause_status(arg0: &0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::AdminCap, arg1: &mut 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_config::GlobalPauseStatus, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_router::set_global_pause_status(arg0, arg1, arg2, arg3);
    }

    public entry fun swap_coinA_for_exact_coinB<T0, T1>(arg0: &mut 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::Pool<T0, T1>, arg1: &0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_router::swap_coinA_for_exact_coinB<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun swap_coinB_for_exact_coinA<T0, T1>(arg0: &mut 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::Pool<T0, T1>, arg1: &0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_router::swap_coinB_for_exact_coinA<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun swap_exact_coinA_for_coinB<T0, T1>(arg0: &mut 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::Pool<T0, T1>, arg1: &0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_router::swap_exact_coinA_for_coinB<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun swap_exact_coinB_for_coinA<T0, T1>(arg0: &mut 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_swap::Pool<T0, T1>, arg1: &0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_router::swap_exact_coinB_for_coinA<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

