module 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_script {
    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_router::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun init_pool<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_router::init_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::GlobalPauseStatus, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_router::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_fee_config<T0, T1>(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Deployer, arg1: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_router::set_fee_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_global_pause_status(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::AdminCap, arg1: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::GlobalPauseStatus, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_router::set_global_pause_status(arg0, arg1, arg2, arg3);
    }

    public entry fun swap_exact_coinA_for_coinB<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_router::swap_exact_coinA_for_coinB<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun swap_exact_coinB_for_coinA<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_router::swap_exact_coinB_for_coinA<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

