module 0x9bf8a2ee11923b2bf663f945649b350d84d8f542084fe46fb9fe67f7a5bd0ca6::single_wallet_add_liquidity {
    struct LiquidityState {
        completed: bool,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut LiquidityState, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 0);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::add_liquidity<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        arg0.completed = true;
    }

    public fun init_state(arg0: &mut 0x2::tx_context::TxContext) : LiquidityState {
        LiquidityState{completed: false}
    }

    // decompiled from Move bytecode v6
}

