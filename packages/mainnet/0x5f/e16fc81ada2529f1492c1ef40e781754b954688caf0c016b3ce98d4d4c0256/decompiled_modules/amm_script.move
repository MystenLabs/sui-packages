module 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_script {
    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_swap::Pool, arg1: &0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_router::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun init_pool<T0, T1>(arg0: &mut 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_swap::Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_router::init_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_swap::Pool, arg1: &0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_config::GlobalPauseStatus, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_router::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_fee_config<T0, T1>(arg0: &0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_swap::Deployer, arg1: &mut 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_swap::Pool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_router::set_fee_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_global_pause_status(arg0: &0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_swap::AdminCap, arg1: &mut 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_config::GlobalPauseStatus, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_router::set_global_pause_status(arg0, arg1, arg2, arg3);
    }

    public entry fun swap_exact_coinA_for_coinB<T0, T1>(arg0: &mut 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_swap::Pool, arg1: &0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_router::swap_exact_coinA_for_coinB<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun swap_exact_coinB_for_coinA<T0, T1>(arg0: &mut 0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_swap::Pool, arg1: &0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x5fe16fc81ada2529f1492c1ef40e781754b954688caf0c016b3ce98d4d4c0256::amm_router::swap_exact_coinB_for_coinA<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

