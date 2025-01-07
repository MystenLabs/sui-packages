module 0xeca272da225a80301e2003c65d46d9d9b5f40cb6367284f45d88978d00f4ccdd::single_wallet_add_liquidity {
    struct LiquidityState {
        creator: address,
        completed: bool,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut LiquidityState, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 0);
        assert!(0x2::tx_context::sender(arg8) == arg0.creator, 1);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::add_liquidity<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        arg0.completed = true;
    }

    public fun init_state(arg0: &mut 0x2::tx_context::TxContext) : LiquidityState {
        LiquidityState{
            creator   : 0x2::tx_context::sender(arg0),
            completed : false,
        }
    }

    // decompiled from Move bytecode v6
}

