module 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_script {
    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::Pool<T0, T1>, arg1: &0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_router::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun claim_fee<T0, T1>(arg0: &0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::AdminCap, arg1: &mut 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_router::claim_fee<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun init_and_add_pool<T0, T1>(arg0: &mut 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::PairStore, arg1: &0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_router::init_and_add_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun init_pool<T0, T1>(arg0: &mut 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::PairStore, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_router::init_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::Pool<T0, T1>, arg1: &0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::PoolLiquidityCoin<T0, T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_router::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_fee_config<T0, T1>(arg0: &0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::AdminCap, arg1: &mut 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_router::set_fee_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_global_pause_status(arg0: &0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::AdminCap, arg1: &mut 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::GlobalPauseStatus, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_router::set_global_pause_status(arg0, arg1, arg2, arg3);
    }

    public entry fun swap_coinA_for_exact_coinB<T0, T1>(arg0: &mut 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::Pool<T0, T1>, arg1: &0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_router::swap_coinA_for_exact_coinB<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun swap_coinB_for_exact_coinA<T0, T1>(arg0: &mut 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::Pool<T0, T1>, arg1: &0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_router::swap_coinB_for_exact_coinA<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun swap_exact_coinA_for_coinB<T0, T1>(arg0: &mut 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::Pool<T0, T1>, arg1: &0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_router::swap_exact_coinA_for_coinB<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun swap_exact_coinB_for_coinA<T0, T1>(arg0: &mut 0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_swap::Pool<T0, T1>, arg1: &0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xc7784c4f06d7c75a165f0d73140412e6a5b29babed104910c002aaa5e4182490::amm_router::swap_exact_coinB_for_coinA<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

